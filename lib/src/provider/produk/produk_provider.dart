import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../network/model/my_network.dart';
import '../../utils/my_utils.dart';
import '../my_provider.dart';

class ProdukProvider extends StateNotifier<List<ProdukModel>> {
  ProdukProvider() : super([]);

  final dio = Dio();

  Future<List<ProdukModel>> _getProduk() async {
    final response = await dio.get(
      '${Constant.fullBaseAPI}/produk',
      options: Options(validateStatus: (status) => (status ?? 0) < 500),
    );

    final Map<String, dynamic> json = response.data as Map<String, dynamic>;
    if (response.statusCode != 200) {
      final error = json['message'];
      throw Exception(error);
    }

    final List<dynamic> list = json['data'] as List<dynamic>;
    final List<ProdukModel> listProduk =
        List<ProdukModel>.from(list.map((e) => ProdukModel.fromJson(e as Map<String, dynamic>)));

    state = [...listProduk];
    return listProduk;
  }

  Future<List<ProdukModel>> _getProdukByCategory(int kategori) async {
    final response = await dio.get(
      '${Constant.fullBaseAPI}/produk/produkBykategori',
      options: Options(validateStatus: (status) => (status ?? 0) < 500),
      queryParameters: {'kategori': kategori},
    );

    final Map<String, dynamic> json = response.data as Map<String, dynamic>;
    if (response.statusCode != 200) {
      final error = json['message'];
      throw Exception(error);
    }

    final List<dynamic> list = json['data'] as List<dynamic>;
    if (list.isEmpty) {
      return [];
    }
    final List<ProdukModel> listProduk =
        List<ProdukModel>.from(list.map((e) => ProdukModel.fromJson(e as Map<String, dynamic>)));

    state = [...listProduk];
    return listProduk;
  }
}

final produkProvider =
    StateNotifierProvider<ProdukProvider, List<ProdukModel>>((ref) => ProdukProvider());

final getProduk = FutureProvider.autoDispose((ref) async {
  await ref.watch(getKategoriProduk.future);
  final result = await ref.watch(produkProvider.notifier)._getProduk();
  return result;
});

final getProdukByKategori = FutureProvider.autoDispose<List<ProdukModel>>((ref) async {
  await ref.watch(getKategoriProduk.future);
  final idKategori = ref.watch(selectedCategoryProduct).state;
  final result = await ref.watch(produkProvider.notifier)._getProdukByCategory(idKategori ?? 0);
  return result;
});
