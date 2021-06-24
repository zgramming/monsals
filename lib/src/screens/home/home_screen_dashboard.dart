import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../provider/my_provider.dart';

class HomeScreenDashboard extends ConsumerWidget {
  const HomeScreenDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final getDashboard = watch(initializeDashboard);
    return getDashboard.when(
        data: (_) {
          final dashboard = watch(dashboardProvider);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Center(
                                child: Text(
                                  'Rencana',
                                  style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                height: sizes.height(context) / 6,
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      dashboard.totalRencana.toString(),
                                      style: GoogleFonts.montserratAlternates(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Center(
                                child: Text(
                                  'Realisasi',
                                  style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                height: sizes.height(context) / 6,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      dashboard.totalRealisasi.toString(),
                                      style: GoogleFonts.montserratAlternates(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Ink(
                          width: double.infinity,
                          height: sizes.height(context) / 10,
                          decoration: const BoxDecoration(color: Colors.grey),
                          child: FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text('${dashboard.persentasi}%'),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Ink(
                                height: 20.0,
                                color: Colors.orange,
                              ),
                            ),
                            Expanded(
                              child: Ink(
                                height: 20.0,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Penjualan',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Ink(
                    width: double.infinity,
                    height: sizes.height(context) / 10,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text('Rp. ${GlobalFunction.formatNumber(dashboard.totalPenjualan)}'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())));
  }
}
