import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:global_template/global_template.dart';
import 'package:image_picker/image_picker.dart';

import '../../provider/my_provider.dart';
import '../../utils/my_utils.dart';
import '../transaction/transaction_sreen.dart';
import '../welcome/appbar_monsals.dart';
import './take_activity.dart';

class ActivityFormScreen extends StatefulWidget {
  static const routeNamed = '/activity-form-screen';
  final int? idRencana;
  const ActivityFormScreen({
    Key? key,
    required this.idRencana,
  }) : super(key: key);
  @override
  _ActivityFormScreenState createState() => _ActivityFormScreenState();
}

class _ActivityFormScreenState extends State<ActivityFormScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController tanggalRealisasiController;
  late TextEditingController mulaiRealisasiController;
  late TextEditingController selesaiRealisasiController;
  late TextEditingController picController;
  late TextEditingController catatanController;
  late TextEditingController penjualanController;

  late DateTime? tanggalRealisasi;
  late String? mulaiRealisasi;
  late String? selesaiRealisasi;

  File? _startPicture;
  File? _endPicture;

  File? _fileActivity1;
  File? _fileActivity2;
  File? _fileActivity3;
  File? _fileActivity4;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    context.read(getRealisasiByRencana(widget.idRencana ?? 0).future).then((realisasi) {
      if (realisasi == null) {
        tanggalRealisasiController = TextEditingController();
        mulaiRealisasiController = TextEditingController();
        selesaiRealisasiController = TextEditingController();
        picController = TextEditingController();
        catatanController = TextEditingController();
        penjualanController = TextEditingController();

        tanggalRealisasi = DateTime.now();
        mulaiRealisasi = '';
        selesaiRealisasi = '';
      } else {
        tanggalRealisasiController =
            TextEditingController(text: GlobalFunction.formatYMD(realisasi.tanggal!));
        mulaiRealisasiController = TextEditingController(text: realisasi.mulai);
        selesaiRealisasiController = TextEditingController(text: realisasi.selesai);
        picController = TextEditingController(text: realisasi.pic);
        catatanController = TextEditingController(text: realisasi.catatan);
        penjualanController =
            TextEditingController(text: (realisasi.totalPenjualan ?? 0).toString());

        tanggalRealisasi = realisasi.tanggal;
        mulaiRealisasi = realisasi.mulai;
        selesaiRealisasi = realisasi.selesai;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMonsals(
        actions: [
          IconButton(
            onPressed: () async {
              try {
                final validate = _formKey.currentState?.validate() ?? false;
                if (!validate) {
                  throw Exception('Validasi tidak valid');
                }
                final result =
                    await context.read(kegiatanProvider.notifier).insertOrUpdateRealisasi(
                          widget.idRencana ?? -1,
                          tanggalRealisasi: tanggalRealisasi ?? DateTime.now(),
                          mulaiRealisasi: mulaiRealisasi ?? '',
                          selesaiRealisasi: selesaiRealisasi,
                          fotoMulai: _startPicture,
                          fotoSelesai: _endPicture,
                          fotoAktifitas1: _fileActivity1,
                          fotoAktifitas2: _fileActivity2,
                          fotoAktifitas3: _fileActivity3,
                          fotoAktifitas4: _fileActivity4,
                          pic: picController.text,
                          catatan: catatanController.text,
                        );
                await context.refresh(getRealisasiByRencana(widget.idRencana ?? 0));

                GlobalFunction.showSnackBar(
                  context,
                  content: Text(result['message'] as String),
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
            icon: const Icon(FontAwesomeIcons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Consumer(
                builder: (context, watch, child) {
                  final _detailRencanaFuture = watch(getDetailRencana(widget.idRencana ?? 0));
                  return _detailRencanaFuture.when(
                    data: (rencana) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Rencana - ${GlobalFunction.formatYMD(DateTime.now())}',
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        TextFormFieldCustom(
                          labelText: 'Kode Rencana',
                          initialValue: rencana.kode,
                          disableOutlineBorder: false,
                          prefixIcon: null,
                          padding: const EdgeInsets.all(12.0),
                          readOnly: true,
                        ),
                        const SizedBox(height: 20),
                        TextFormFieldCustom(
                          labelText: 'Customer',
                          initialValue: rencana.customerNama,
                          disableOutlineBorder: false,
                          prefixIcon: null,
                          padding: const EdgeInsets.all(12.0),
                          readOnly: true,
                        ),
                        const SizedBox(height: 20),
                        TextFormFieldCustom(
                          labelText: 'Kategori',
                          initialValue: rencana.kategori,
                          disableOutlineBorder: false,
                          prefixIcon: null,
                          padding: const EdgeInsets.all(12.0),
                          readOnly: true,
                        ),
                        const SizedBox(height: 20),
                        TextFormFieldCustom(
                          labelText: 'Kegiatan',
                          initialValue: rencana.kegiatan,
                          disableOutlineBorder: false,
                          prefixIcon: null,
                          padding: const EdgeInsets.all(12.0),
                          readOnly: true,
                        ),
                        const SizedBox(height: 20),
                        TextFormFieldCustom(
                          labelText: 'HP / TLP Customer',
                          initialValue: rencana.customerPhone,
                          disableOutlineBorder: false,
                          prefixIcon: null,
                          padding: const EdgeInsets.all(12.0),
                          readOnly: true,
                        ),
                        const SizedBox(height: 20),
                        TextFormFieldCustom(
                          labelText: 'Alamat',
                          initialValue: rencana.customerAlamat,
                          disableOutlineBorder: false,
                          prefixIcon: null,
                          padding: const EdgeInsets.all(12.0),
                          readOnly: true,
                        ),
                      ],
                    ),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (error, stackTrace) => Center(
                      child: Text(error.toString()),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Divider(color: colorPallete.primaryColor, thickness: 2),
              const SizedBox(height: 10),
              const Text('Realisasi', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Consumer(
                builder: (context, watch, child) {
                  final futureRealisasi = watch(getRealisasiByRencana(widget.idRencana ?? 0));
                  return futureRealisasi.when(
                    data: (realisasi) {
                      return Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormFieldCustom(
                              controller: tanggalRealisasiController,
                              prefixIcon: null,
                              padding: const EdgeInsets.all(12.0),
                              labelText: 'Tanggal',
                              hintText: '27/03/2021',
                              disableOutlineBorder: false,
                              readOnly: true,
                              validator: (value) => (value?.isEmpty ?? true)
                                  ? 'Tanggal Realisasi tidak boleh kosong'
                                  : null,
                              onTap: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2100, 12, 12),
                                );

                                if (date != null) {
                                  setState(() {
                                    tanggalRealisasiController.text =
                                        GlobalFunction.formatYMD(date);
                                    tanggalRealisasi = date;
                                  });
                                }
                              },
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormFieldCustom(
                                    controller: mulaiRealisasiController,
                                    prefixIcon: null,
                                    padding: const EdgeInsets.all(12.0),
                                    labelText: 'Mulai',
                                    hintText: '12.00',
                                    disableOutlineBorder: false,
                                    readOnly: true,
                                    validator: (value) => (value?.isEmpty ?? true)
                                        ? 'Mulai Realisasi tidak boleh kosong'
                                        : null,
                                    onTap: () async {
                                      final now = DateTime.now();
                                      final time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay(
                                          hour: now.hour,
                                          minute: now.minute,
                                        ),
                                      );
                                      if (time != null) {
                                        final hour = time.hour.toString().length > 1
                                            ? time.hour
                                            : '0${time.hour}';
                                        final minute = time.minute.toString().length > 1
                                            ? time.minute
                                            : '0${time.minute}';
                                        final result = '$hour:$minute';
                                        setState(() {
                                          mulaiRealisasi = result;
                                          mulaiRealisasiController.text = result;
                                        });
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: TextFormFieldCustom(
                                    controller: selesaiRealisasiController,
                                    prefixIcon: null,
                                    padding: const EdgeInsets.all(12.0),
                                    labelText: 'Selesai',
                                    hintText: '16.00',
                                    disableOutlineBorder: false,
                                    readOnly: true,
                                    onTap: () async {
                                      final now = DateTime.now();
                                      final time = await showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay(
                                          hour: now.hour,
                                          minute: now.minute,
                                        ),
                                      );

                                      if (time != null) {
                                        final hour = time.hour.toString().length > 1
                                            ? time.hour
                                            : '0${time.hour}';
                                        final minute = time.minute.toString().length > 1
                                            ? time.minute
                                            : '0${time.minute}';
                                        final result = '$hour:$minute';
                                        setState(() {
                                          selesaiRealisasi = result;
                                          selesaiRealisasiController.text = result;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      final pickedImage = await picker.getImage(
                                        source: ImageSource.camera,
                                        imageQuality: 50,
                                        maxHeight: 400,
                                        maxWidth: 400,
                                      );
                                      if (pickedImage != null) {
                                        setState(() {
                                          _startPicture = File(pickedImage.path);
                                        });
                                      }
                                    },
                                    child: Ink(
                                      height: sizes.height(context) / 6,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: colorPallete.accentColor!),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: (realisasi?.fotoMulai != null && _startPicture == null)
                                          ? ClipRRect(
                                              borderRadius: BorderRadius.circular(10.0),
                                              child: Image.network(
                                                '${Constant.baseImageActivity}/${realisasi?.fotoMulai}',
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : (_startPicture == null)
                                              ? const Center(
                                                  child: Icon(FontAwesomeIcons.camera),
                                                )
                                              : ClipRRect(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  child: Image.file(
                                                    _startPicture!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      final pickedImage = await picker.getImage(
                                        source: ImageSource.camera,
                                        imageQuality: 50,
                                        maxHeight: 400,
                                        maxWidth: 400,
                                      );
                                      if (pickedImage != null) {
                                        setState(() {
                                          _endPicture = File(pickedImage.path);
                                        });
                                      }
                                    },
                                    child: Ink(
                                      height: sizes.height(context) / 6,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: colorPallete.accentColor!),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: (realisasi?.fotoSelesai != null && _endPicture == null)
                                          ? ClipRRect(
                                              borderRadius: BorderRadius.circular(10.0),
                                              child: Image.network(
                                                '${Constant.baseImageActivity}/${realisasi?.fotoSelesai}',
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : (_endPicture == null)
                                              ? const Center(
                                                  child: Icon(FontAwesomeIcons.camera),
                                                )
                                              : ClipRRect(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  child: Image.file(
                                                    _endPicture!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Divider(color: colorPallete.primaryColor, thickness: 2),
                            const SizedBox(height: 10),
                            const Text('Aktifitas', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 20,
                              runSpacing: 20,
                              children: [
                                TakeActivityPicture(
                                  filename: realisasi?.fotoAktifitas1,
                                  file: _fileActivity1,
                                  onTakePicture: (pickedFile) =>
                                      setState(() => _fileActivity1 = pickedFile),
                                ),
                                TakeActivityPicture(
                                  filename: realisasi?.fotoAktifitas2,
                                  file: _fileActivity2,
                                  onTakePicture: (pickedFile) =>
                                      setState(() => _fileActivity2 = pickedFile),
                                ),
                                TakeActivityPicture(
                                  filename: realisasi?.fotoAktifitas3,
                                  file: _fileActivity3,
                                  onTakePicture: (pickedFile) =>
                                      setState(() => _fileActivity3 = pickedFile),
                                ),
                                TakeActivityPicture(
                                  filename: realisasi?.fotoAktifitas4,
                                  file: _fileActivity4,
                                  onTakePicture: (pickedFile) =>
                                      setState(() => _fileActivity4 = pickedFile),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Consumer(
                              builder: (context, watch, child) {
                                final _totalPenjualan =
                                    watch(totalHargaPenjualan(widget.idRencana ?? 0)).state;
                                final _totalData =
                                    watch(totalDataPenjualan(widget.idRencana ?? 0)).state;
                                return TextFormFieldCustom(
                                  controller: TextEditingController(
                                      text:
                                          '$_totalData Produk - Rp.${GlobalFunction.formatNumber(_totalPenjualan)}'),
                                  readOnly: true,
                                  prefixIcon: null,
                                  labelText: 'Penjualan',
                                  hintText: 'Penjualan',
                                  disableOutlineBorder: false,
                                  padding: const EdgeInsets.all(12.0),
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      TransactionScreen.routeNamed,
                                      arguments: widget.idRencana,
                                    );
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            TextFormFieldCustom(
                              controller: picController,
                              prefixIcon: null,
                              labelText: 'PIC',
                              hintText: 'PIC',
                              disableOutlineBorder: false,
                              padding: const EdgeInsets.all(12.0),
                            ),
                            const SizedBox(height: 20),
                            TextFormFieldCustom(
                              controller: catatanController,
                              prefixIcon: null,
                              labelText: 'Catatan',
                              hintText: 'Catatan',
                              minLines: 3,
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              disableOutlineBorder: false,
                              padding: const EdgeInsets.all(12.0),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      );
                    },
                    loading: () => const Center(child: CircularProgressIndicator()),
                    error: (error, stackTrace) => Center(
                      child: Text(error.toString()),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
