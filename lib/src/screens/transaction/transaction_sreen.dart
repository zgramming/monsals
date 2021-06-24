import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';

import '../../provider/my_provider.dart';
import '../welcome/appbar_monsals.dart';

class TransactionScreen extends StatefulWidget {
  static const routeNamed = '/transaction-screen';

  final int idRencana;
  const TransactionScreen({
    Key? key,
    required this.idRencana,
  }) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController hargaController;
  late final TextEditingController pcsController;

  @override
  void initState() {
    super.initState();
    hargaController = TextEditingController();
    pcsController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMonsals(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Rencana - ${GlobalFunction.formatYMD(DateTime.now())}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const TextFormFieldCustom(
                    labelText: 'Kode Rencan22a',
                    initialValue: '01111R',
                    disableOutlineBorder: false,
                    prefixIcon: null,
                    padding: EdgeInsets.all(12.0),
                    readOnly: true,
                  ),
                  const SizedBox(height: 20),
                  const TextFormFieldCustom(
                    labelText: 'Customer',
                    initialValue: 'Toko Ibu Hasan',
                    disableOutlineBorder: false,
                    prefixIcon: null,
                    padding: EdgeInsets.all(12.0),
                    readOnly: true,
                  ),
                  const SizedBox(height: 20),
                  const TextFormFieldCustom(
                    labelText: 'Kategori',
                    initialValue: 'Kunjungan / Transaksi',
                    disableOutlineBorder: false,
                    prefixIcon: null,
                    padding: EdgeInsets.all(12.0),
                    readOnly: true,
                  ),
                  const SizedBox(height: 20),
                  const TextFormFieldCustom(
                    labelText: 'Kegiatan',
                    initialValue: 'Kunjungan ke Toko Ibu Hasan',
                    disableOutlineBorder: false,
                    prefixIcon: null,
                    padding: EdgeInsets.all(12.0),
                    readOnly: true,
                  ),
                  const SizedBox(height: 20),
                  Divider(thickness: 1, color: colorPallete.primaryColor),
                  const SizedBox(height: 20),
                  Consumer(
                    builder: (context, watch, child) {
                      final _futureProduct = watch(getProduk);
                      final _selectedProduct = watch(selectedIdProduct).state;

                      return _futureProduct.when(
                        data: (products) {
                          return Ink(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey[400]!),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownButton<int>(
                              isExpanded: true,
                              value: _selectedProduct,
                              hint: const Text('Semua Produk'),
                              underline: const SizedBox(),
                              onChanged: (value) => context.read(selectedIdProduct).state = value,
                              items: products
                                  .map(
                                    (e) => DropdownMenuItem<int>(
                                      value: e.idProduk,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                        child: Text(e.nama),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          );
                        },
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (error, stackTrace) => Center(child: Text(error.toString())),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormFieldCustom(
                    controller: hargaController,
                    labelText: 'Harga Satuan',
                    disableOutlineBorder: false,
                    prefixIcon: null,
                    padding: const EdgeInsets.all(12.0),
                    keyboardType: TextInputType.number,
                    inputFormatter: [
                      InputNumberFormat(),
                    ],
                    onChanged: (value) {
                      final harga =
                          int.tryParse(GlobalFunction.unFormatNumber(hargaController.text)) ?? 0;
                      final pcs =
                          int.tryParse(GlobalFunction.unFormatNumber(pcsController.text)) ?? 0;
                      final total = harga * pcs;
                      context.read(totalPenjualan).state = total;
                    },
                    validator: (value) =>
                        (value?.isEmpty ?? true) ? 'Harga tidak boleh kosong' : null,
                  ),
                  const SizedBox(height: 20),
                  TextFormFieldCustom(
                    controller: pcsController,
                    labelText: 'Pcs / Box',
                    disableOutlineBorder: false,
                    prefixIcon: null,
                    padding: const EdgeInsets.all(12.0),
                    keyboardType: TextInputType.number,
                    inputFormatter: [
                      InputNumberFormat(),
                    ],
                    onChanged: (value) {
                      final harga =
                          int.tryParse(GlobalFunction.unFormatNumber(hargaController.text)) ?? 0;
                      final pcs =
                          int.tryParse(GlobalFunction.unFormatNumber(pcsController.text)) ?? 0;
                      final total = harga * pcs;
                      context.read(totalPenjualan).state = total;
                    },
                    validator: (value) =>
                        (value?.isEmpty ?? true) ? 'Pcs/Box tidak boleh kosong' : null,
                  ),
                  const SizedBox(height: 20),
                  Consumer(
                    builder: (context, watch, child) {
                      final _totalPenjualan = watch(totalPenjualan).state;
                      return TextFormFieldCustom(
                        controller: TextEditingController(
                            text: GlobalFunction.formatNumber(_totalPenjualan)),
                        disableOutlineBorder: false,
                        prefixIcon: null,
                        padding: const EdgeInsets.all(12.0),
                        keyboardType: TextInputType.number,
                        readOnly: true,
                        inputFormatter: [
                          InputNumberFormat(),
                        ],
                        validator: (value) =>
                            (value?.isEmpty ?? true) ? 'Total tidak boleh kosong' : null,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          final validation = _formKey.currentState?.validate();
                          if (!validation!) {
                            throw 'Validasi gagal';
                          }
                          context.read(isLoading).state = true;
                          final idProduk = context.read(selectedIdProduct).state;
                          await context.read(penjualanProvider.notifier).add(
                                idProduk: idProduk ?? 0,
                                idRencana: widget.idRencana,
                                harga: int.tryParse(
                                        GlobalFunction.unFormatNumber(hargaController.text)) ??
                                    0,
                                jumlah: int.tryParse(
                                        GlobalFunction.unFormatNumber(pcsController.text)) ??
                                    0,
                              );
                          await context.refresh(getPenjualan(widget.idRencana));
                          context.read(isLoading).state = false;
                        } catch (e) {
                          GlobalFunction.showSnackBar(
                            context,
                            content: Text(e.toString()),
                            snackBarType: SnackBarType.error,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(primary: colorPallete.primaryColor),
                      child: const Text('Simpan'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'List Penjualan',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Consumer(
                    builder: (context, watch, child) {
                      final futurePenjualan = watch(getPenjualan(widget.idRencana));

                      return futurePenjualan.when(
                        data: (value) => DataTable(
                            columnSpacing: 0,
                            columns: const <DataColumn>[
                              DataColumn(label: Text('No')),
                              DataColumn(label: Text('Produk')),
                              DataColumn(label: Text('Jumlah')),
                              DataColumn(label: Text('Total')),
                              DataColumn(label: Text('Aksi')),
                            ],
                            rows: List.generate(
                              value.length,
                              (index) {
                                final penjualan = value[index];
                                return DataRow(
                                  cells: [
                                    DataCell(Text('${index + 1}')),
                                    DataCell(Text(penjualan.produk.nama)),
                                    DataCell(Text(penjualan.jml.toString())),
                                    DataCell(Text(penjualan.total.toString())),
                                    DataCell(
                                      IconButton(
                                        onPressed: () async {
                                          try {
                                            await context
                                                .read(penjualanProvider.notifier)
                                                .delete(penjualan.idPenjualan ?? 0);
                                            await context.refresh(getPenjualan(widget.idRencana));
                                            GlobalFunction.showSnackBar(
                                              context,
                                              content: const Text('Berhasil menghapus penjualan'),
                                              snackBarType: SnackBarType.success,
                                            );
                                          } catch (e) {
                                            GlobalFunction.showSnackBar(
                                              context,
                                              content: Text(e.toString()),
                                              snackBarType: SnackBarType.error,
                                            );
                                          }
                                        },
                                        icon: const Icon(Icons.delete, color: Colors.red),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )
                            // rows: const <DataRow>[
                            //   DataRow(
                            //     cells: <DataCell>[
                            //       DataCell(Text('1')),
                            //       DataCell(Text('Krim Pemutih')),
                            //       DataCell(Text('10')),
                            //       DataCell(Text('1.000.000')),
                            //     ],
                            //   ),
                            //   DataRow(
                            //     cells: <DataCell>[
                            //       DataCell(Text('2')),
                            //       DataCell(Text('Sabun Cuci Muka')),
                            //       DataCell(Text('5')),
                            //       DataCell(Text('200.000')),
                            //     ],
                            //   ),
                            // ],
                            ),
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (error, stackTrace) => Center(
                          child: Text(error.toString()),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
