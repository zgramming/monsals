import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../provider/my_provider.dart';

import 'activity_form_screen.dart';

class ActivityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Consumer(
                    builder: (context, watch, child) {
                      final _selectedMonthDropdown = watch(selectedMonthActivity).state;
                      return DropdownButton<int>(
                        onChanged: (value) => context.read(selectedMonthActivity).state =
                            value ?? DateTime.now().month,
                        isExpanded: true,
                        value: _selectedMonthDropdown,
                        items: GlobalFunction.listOfMonth()
                            .map(
                              (key, value) => MapEntry(
                                key,
                                DropdownMenuItem<int>(
                                  value: key,
                                  child: Center(child: Text(value.toString())),
                                ),
                              ),
                            )
                            .values
                            .toList(),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Consumer(
                    builder: (context, watch, child) {
                      final _selectedYearDropdown = watch(selectedYearActivity).state;

                      return DropdownButton<int>(
                        onChanged: (value) =>
                            context.read(selectedYearActivity).state = value ?? DateTime.now().year,
                        isExpanded: true,
                        value: _selectedYearDropdown,
                        items: GlobalFunction.listOfYear(from: 2010, to: DateTime.now().year)
                            .map(
                              (key, value) => MapEntry(
                                key,
                                DropdownMenuItem<int>(
                                  value: key,
                                  child: Center(child: Text(value.toString())),
                                ),
                              ),
                            )
                            .values
                            .toList(),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Consumer(
              builder: (context, watch, child) {
                final futureKegiatan = watch(getKegiatan);
                return futureKegiatan.when(
                  data: (_) {
                    final kegiatans = watch(kegiatanProvider);
                    if (kegiatans.isEmpty) {
                      return const Center(child: Text('Tidak ada kegiatan pada periode ini'));
                    }
                    return ListView.separated(
                      itemCount: kegiatans.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final kegiatan = kegiatans[index];
                        return ListTile(
                          onTap: () => Navigator.of(context).pushNamed(
                              ActivityFormScreen.routeNamed,
                              arguments: kegiatan.idRencana),
                          isThreeLine: true,
                          leading: Text('${index + 1}'),
                          title: Text(
                            kegiatan.kegiatan,
                            style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              '${kegiatan.mulai} - ${kegiatan.selesai} ${kegiatan.customer} \n ${GlobalFunction.formatYMD(kegiatan.tanggal ?? DateTime(2021), type: 2)}',
                            ),
                          ),
                          trailing: CircleAvatar(
                            foregroundColor: Colors.white,
                            backgroundColor: (kegiatan.statusRealisasi == "Selesai")
                                ? Colors.green
                                : (kegiatan.statusRealisasi == "Proses")
                                    ? Colors.yellow
                                    : Colors.red,
                          ),
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
