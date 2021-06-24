import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../network/model/my_network.dart';
import '../../utils/my_utils.dart';

class RealisasiProvider extends StateNotifier<RealisasiModel> {
  RealisasiProvider() : super(const RealisasiModel());
  final _dio = Dio();

  Future<RealisasiModel?> _getRealisasiByRencana(int idRencana) async {
    final response = await _dio.get(
      '${Constant.fullBaseAPI}/realisasi',
      options: Options(validateStatus: (status) => (status ?? 0) < 500),
      queryParameters: {
        'id_rencana': idRencana,
      },
    );

    final Map<String, dynamic> json = response.data as Map<String, dynamic>;

    if (response.statusCode != 200) {
      final error = json['message'];
      throw Exception(error);
    }

    if (json['data'] == null) {
      return null;
    }

    final realisasi = RealisasiModel.fromJson(json['data'] as Map<String, dynamic>);

    state = realisasi;

    return realisasi;
  }
}

final realisasiProvider =
    StateNotifierProvider<RealisasiProvider, RealisasiModel>((ref) => RealisasiProvider());

final getRealisasiByRencana =
    FutureProvider.autoDispose.family<RealisasiModel?, int>((ref, idRencana) async {
  final result = await ref.read(realisasiProvider.notifier)._getRealisasiByRencana(idRencana);
  return result;
});
