import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../provider/my_provider.dart';
import '../../utils/my_utils.dart';
import './product_detail_screen.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Consumer(
              builder: (context, watch, child) {
                final categoriesProduct = watch(kategoriProdukProvider);
                final _selectedCategoryProduct = watch(selectedCategoryProduct).state;
                return DropdownButton<int>(
                  onChanged: (value) => context.read(selectedCategoryProduct).state = value ?? 0,
                  isExpanded: true,
                  value: _selectedCategoryProduct,
                  hint: const Text('Semua Kategori'),
                  items: categoriesProduct.map(
                    (e) {
                      return DropdownMenuItem<int>(
                        value: e.idKategoriP ?? 0,
                        child: Center(child: Text(e.nama ?? '')),
                      );
                    },
                  ).toList(),
                );
              },
            ),
          ),
          Expanded(
            child: Consumer(
              builder: (context, watch, child) {
                final futureProduk = watch(getProdukByKategori);
                return futureProduk.when(
                  data: (_) {
                    final produks = watch(produkProvider);
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 12.0,
                      ),
                      itemCount: produks.length,
                      itemBuilder: (context, index) {
                        final produk = produks[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    ProductDetailScreen.routeNamed,
                                    arguments: produk,
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          '${Constant.baseImageProduct}/${produk.foto}'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              produk.nama,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.openSans(fontSize: 12),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) => Center(
                    child: Text(error.toString()),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
