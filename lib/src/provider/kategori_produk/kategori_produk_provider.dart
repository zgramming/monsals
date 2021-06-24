import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../network/model/my_network.dart';
import '../../utils/my_utils.dart';

class KategoriProdukProvider extends StateNotifier<List<KategoriProdukModel>> {
  KategoriProdukProvider() : super([]);
  final _dio = Dio();

  Future<List<KategoriProdukModel>> _getKategoriProduk() async {
    final response = await _dio.get(
      '${Constant.fullBaseAPI}/KategoriProduk',
      options: Options(validateStatus: (status) => (status ?? 0) < 500),
    );

    final Map<String, dynamic> json = response.data as Map<String, dynamic>;
    if (response.statusCode != 200) {
      final error = json['message'];
      throw Exception(error);
    }

    final List<dynamic> list = json['data'] as List<dynamic>;
    final listKategoriProduk = List<KategoriProdukModel>.from(
        list.map((e) => KategoriProdukModel.fromJson(e as Map<String, dynamic>)));

    state = [...listKategoriProduk];
    return listKategoriProduk;
  }
}

final kategoriProdukProvider =
    StateNotifierProvider<KategoriProdukProvider, List<KategoriProdukModel>>(
        (ref) => KategoriProdukProvider());

final getKategoriProduk = FutureProvider.autoDispose((ref) async {
  final result = await ref.watch(kategoriProdukProvider.notifier)._getKategoriProduk();
  return result;
});
