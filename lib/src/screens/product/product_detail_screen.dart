import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../network/model/my_network.dart';
import '../../utils/my_utils.dart';
import '../welcome/appbar_monsals.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeNamed = '/product-detail-screen';

  final ProdukModel? produk;
  const ProductDetailScreen({
    Key? key,
    required this.produk,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMonsals(
        actions: [
          // IconButton(
          //   onPressed: () => Navigator.of(context).pushNamed(TransactionScreen.routeNamed),
          //   icon: const Icon(FontAwesomeIcons.moneyCheck),
          // )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.network(
              '${Constant.baseImageProduct}/${produk?.foto}',
              // fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    produk?.nama ?? '',
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text('Exp : ${produk?.exp}'),
                  const SizedBox(height: 10.0),
                  const Text('Deskripsi'),
                  const SizedBox(height: 10.0),
                  Text(
                    produk?.deskripsi ?? '',
                    style: GoogleFonts.openSans(fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(height: 10.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
