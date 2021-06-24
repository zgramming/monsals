import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../network/model/my_network.dart';
import '../../utils/my_utils.dart';

class PenjualanProvider extends StateNotifier<List<PenjualanModel>> {
  PenjualanProvider() : super([]);
  final _dio = Dio();

  Future<Map<String, dynamic>> add({
    required int idProduk,
    required int idRencana,
    required int harga,
    required int jumlah,
  }) async {
    final data = FormData.fromMap({
      'rencana': idRencana,
      'produk': idProduk,
      'jumlah': jumlah,
      'harga': harga,
    });

    final response = await _dio.post(
      '${Constant.fullBaseAPI}/penjualan/createPenjualan',
      data: data,
      options: Options(validateStatus: (status) => (status ?? 0) < 500),
    );

    final Map<String, dynamic> json = response.data as Map<String, dynamic>;

    if (response.statusCode != 201) {
      final error = json['message'];
      throw Exception(error);
    }

    await _getPenjualan(idRencana);
    return json;
  }

  Future<List<PenjualanModel>> _getPenjualan(int idRencana) async {
    final response = await _dio.get('${Constant.fullBaseAPI}/penjualan',
        options: Options(validateStatus: (status) => (status ?? 0) < 500),
        queryParameters: {
          'id_rencana': idRencana,
        });

    final Map<String, dynamic> json = response.data as Map<String, dynamic>;

    if (response.statusCode != 200) {
      final error = json['message'];
      throw Exception(error);
    }

    final List<dynamic> list = json['data'] as List<dynamic>;
    final List<PenjualanModel> listPenjualan = List<PenjualanModel>.from(
        list.map((e) => PenjualanModel.fromJson(e as Map<String, dynamic>)));

    state = [...listPenjualan];
    return listPenjualan;
  }

  Future<void> delete(int idPenjualan) async {
    final response = await _dio.delete('${Constant.fullBaseAPI}/penjualan/deletePenjualan',
        options: Options(
          validateStatus: (status) => (status ?? 0) < 500,
          contentType: Headers.formUrlEncodedContentType,
        ),
        data: {'penjualan': idPenjualan});

    final Map<String, dynamic> json = response.data as Map<String, dynamic>;

    if (response.statusCode != 200) {
      final error = json['message'];
      throw Exception(error);
    }
  }
}

final penjualanProvider =
    StateNotifierProvider<PenjualanProvider, List<PenjualanModel>>((ref) => PenjualanProvider());

final getPenjualan =
    FutureProvider.autoDispose.family<List<PenjualanModel>, int>((ref, idRencana) async {
  final result = await ref.watch(penjualanProvider.notifier)._getPenjualan(idRencana);
  return result;
});

final totalDataPenjualan = StateProvider.autoDispose.family<int, int>((ref, idRencana) {
  final penjualan = ref
      .watch(penjualanProvider)
      .where((element) => element.rencana.idRencana == idRencana)
      .toList();
  return penjualan.length;
});

final totalHargaPenjualan = StateProvider.autoDispose.family<int, int>((ref, idRencana) {
  final penjualan = ref
      .watch(penjualanProvider)
      .where((element) => element.rencana.idRencana == idRencana)
      .toList();
  return penjualan.fold(0, (p, c) => p + (c.total ?? 0));
});
