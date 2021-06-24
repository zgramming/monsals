import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../network/model/my_network.dart';
import '../../utils/my_utils.dart';
import '../my_provider.dart';

class DashboardProvider extends StateNotifier<DashboardModel> {
  DashboardProvider() : super(const DashboardModel());
  final dio = Dio();

  Future<int> _getRencana({
    int idSales = 0,
  }) async {
    try {
      final response = await dio.get(
        '${Constant.fullBaseAPI}/home/rencanaTotal',
        options: Options(validateStatus: (status) => (status ?? 0) < 500),
        queryParameters: {'sales': idSales.toString()},
      );

      final Map<String, dynamic> json = response.data as Map<String, dynamic>;
      if (response.statusCode != 200) {
        final error = json['message'];
        throw Exception(error);
      }

      final totalRencana = json['data'] as int;
      state = state.copyWith(totalRencana: totalRencana);
      return totalRencana;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> _getRealisasi({
    int idSales = 0,
  }) async {
    try {
      final response = await dio.get(
        '${Constant.fullBaseAPI}/home/realisasiTotal',
        options: Options(validateStatus: (status) => (status ?? 0) < 500),
        queryParameters: {'sales': idSales.toString()},
      );
      final Map<String, dynamic> json = response.data as Map<String, dynamic>;
      if (response.statusCode != 200) {
        final error = json['message'];
        throw Exception(error);
      }

      final totalRealisasi = json['data'] as int;
      state = state.copyWith(totalRealisasi: totalRealisasi);
      return totalRealisasi;
    } catch (e) {
      rethrow;
    }
  }

  Future<int> _getPenjualan({
    int idSales = 0,
  }) async {
    try {
      final response = await dio.get(
        '${Constant.fullBaseAPI}/home/penjualanTotal',
        options: Options(validateStatus: (status) => (status ?? 0) < 500),
        queryParameters: {'sales': idSales.toString()},
      );
      final Map<String, dynamic> json = response.data as Map<String, dynamic>;
      if (response.statusCode != 200) {
        final error = json['message'];
        throw Exception(error);
      }

      final totalPenjualan = json['data'] as int;
      state = state.copyWith(totalPenjualan: totalPenjualan);
      return totalPenjualan;
    } catch (e) {
      rethrow;
    }
  }

  void setPersentasi(int persentasi) {
    state = state.copyWith(persentasi: persentasi);
  }
}

final dashboardProvider =
    StateNotifierProvider<DashboardProvider, DashboardModel>((ref) => DashboardProvider());

final initializeDashboard = FutureProvider.autoDispose<void>((ref) async {
  final idSales = ref.read(userProvider).sales.idSales;

  await ref.watch(dashboardProvider.notifier)._getPenjualan(idSales: idSales ?? 0);

  final rencana = await ref.watch(dashboardProvider.notifier)._getRencana(idSales: idSales ?? 0);
  final realisasi =
      await ref.watch(dashboardProvider.notifier)._getRealisasi(idSales: idSales ?? 0);
  final persentasi = (realisasi / rencana) * 100;

  ref.read(dashboardProvider.notifier).setPersentasi(persentasi.toInt());
});
