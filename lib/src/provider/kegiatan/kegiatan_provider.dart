import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../network/model/my_network.dart';
import '../../utils/my_utils.dart';
import '../my_provider.dart';

class KegiatanProvider extends StateNotifier<List<KegiatanModel>> {
  KegiatanProvider() : super([]);
  final _dio = Dio();

  Future<List<KegiatanModel>> _getKegiatan(
    int idSales, {
    int? bulan,
    int? tahun,
  }) async {
    int _bulan = DateTime.now().month, _tahun = DateTime.now().year;

    if (bulan != null) _bulan = bulan;
    if (tahun != null) _tahun = tahun;

    final response = await _dio.get(
      '${Constant.fullBaseAPI}/kegiatan',
      options: Options(validateStatus: (status) => (status ?? 0) < 500),
      queryParameters: {
        'sales': idSales.toString(),
        'bulan': _bulan.toString(),
        'tahun': _tahun.toString(),
      },
    );

    final Map<String, dynamic> json = response.data as Map<String, dynamic>;
    if (response.statusCode != 200) {
      final error = json['message'];
      throw Exception(error);
    }

    final List<dynamic> list = json['data'] as List<dynamic>;
    final List<KegiatanModel> listKegiatan = List<KegiatanModel>.from(
        list.map((e) => KegiatanModel.fromJson(e as Map<String, dynamic>)));

    state = [...listKegiatan];

    return listKegiatan;
  }

  Future<Map<String, dynamic>> insertOrUpdateRealisasi(
    int idRencana, {
    required DateTime tanggalRealisasi,
    required String mulaiRealisasi,
    String? selesaiRealisasi,
    String? pic,
    String? catatan,
    File? fotoMulai,
    File? fotoSelesai,
    File? fotoAktifitas1,
    File? fotoAktifitas2,
    File? fotoAktifitas3,
    File? fotoAktifitas4,
  }) async {
    try {
      final data = FormData.fromMap({
        'rencana': idRencana,
        'tanggal': tanggalRealisasi,
        'mulai': mulaiRealisasi,
        'selesai': selesaiRealisasi,
        'foto_mulai': (fotoMulai != null)
            ? await MultipartFile.fromFile(fotoMulai.path)
            : MultipartFile.fromBytes(Uint8List.fromList([0])),
        'foto_selesai': (fotoSelesai != null) ? await MultipartFile.fromFile(fotoSelesai.path) : "",
        'foto_aktifitas1':
            (fotoAktifitas1 != null) ? await MultipartFile.fromFile(fotoAktifitas1.path) : "",
        'foto_aktifitas2':
            (fotoAktifitas2 != null) ? await MultipartFile.fromFile(fotoAktifitas2.path) : "",
        'foto_aktifitas3':
            (fotoAktifitas3 != null) ? await MultipartFile.fromFile(fotoAktifitas3.path) : "",
        'foto_aktifitas4':
            (fotoAktifitas4 != null) ? await MultipartFile.fromFile(fotoAktifitas4.path) : "",
        'pic': pic,
        'catatan': catatan,
      });

      final response = await _dio.post(
        '${Constant.fullBaseAPI}/kegiatan/createOrUpdateRealisasi',
        data: data,
        options: Options(validateStatus: (status) => (status ?? 0) < 500),
      );

      final Map<String, dynamic> json = response.data as Map<String, dynamic>;
      if (json['status'] != 'success') {
        final error = json['message'];
        throw Exception(error);
      }
      return json;
    } catch (e) {
      rethrow;
    }
  }
}

final kegiatanProvider =
    StateNotifierProvider<KegiatanProvider, List<KegiatanModel>>((ref) => KegiatanProvider());

final getKegiatan = FutureProvider.autoDispose((ref) async {
  final idSales = ref.read(userProvider).sales.idSales;
  final _selectedMonth = ref.watch(selectedMonthActivity).state;
  final _selectedYear = ref.watch(selectedYearActivity).state;
  final result = await ref.watch(kegiatanProvider.notifier)._getKegiatan(
        idSales ?? 0,
        bulan: _selectedMonth,
        tahun: _selectedYear,
      );
  return result;
});
