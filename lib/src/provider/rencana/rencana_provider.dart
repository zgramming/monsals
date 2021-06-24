import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../network/model/my_network.dart';
import '../../utils/my_utils.dart';

import '../my_provider.dart';

class RencanaProvider extends StateNotifier<RencanaModel> {
  RencanaProvider() : super(const RencanaModel());
  final _dio = Dio();

  Future<RencanaModel> _getDetailRencana(int idRencana) async {
    try {
      final response = await _dio.get(
        '${Constant.fullBaseAPI}/kegiatan/rencanaDetail',
        options: Options(validateStatus: (status) => (status ?? 0) < 500),
        queryParameters: {
          'rencana': idRencana.toString(),
        },
      );

      final Map<String, dynamic> json = response.data as Map<String, dynamic>;
      if (response.statusCode != 200) {
        final error = json['message'];
        throw Exception(error);
      }

      final rencana = RencanaModel.fromJson(json['data'] as Map<String, dynamic>);
      state = rencana;
      return rencana;
    } catch (e) {
      rethrow;
    }
  }
}

final rencanaProvider =
    StateNotifierProvider<RencanaProvider, RencanaModel>((ref) => RencanaProvider());

final getDetailRencana =
    FutureProvider.autoDispose.family<RencanaModel, int>((ref, idRencana) async {
  final result = await ref.watch(rencanaProvider.notifier)._getDetailRencana(idRencana);
  await ref.watch(getPenjualan(idRencana).future);
  return result;
});
