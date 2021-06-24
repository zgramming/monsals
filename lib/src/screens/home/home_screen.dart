import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';

import '../../provider/my_provider.dart';
import '../../utils/my_utils.dart';
import './home_screen_dashboard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _selectedMonthDropdown;
  late int _selectedYearDropdown;

  @override
  void initState() {
    super.initState();
    _selectedMonthDropdown = DateTime.now().month;
    _selectedYearDropdown = DateTime.now().year;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: colorPallete.accentColor!.withOpacity(.5)),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Consumer(
                builder: (context, watch, child) {
                  final user = watch(userProvider);

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        '${Constant.baseImageSales}/${user.sales.foto}',
                        fit: BoxFit.cover,
                        height: sizes.width(context) / 4,
                        width: sizes.width(context) / 4,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 10),
                            Text(user.sales.nama ?? ''),
                            const SizedBox(height: 10),
                            Text(user.sales.cabang.nama ?? ''),
                            const SizedBox(height: 10),
                            Text(user.sales.hp ?? ''),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: DropdownButton<int>(
                      onChanged: (value) => setState(() => _selectedMonthDropdown = value!),
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
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: DropdownButton<int>(
                      onChanged: (value) => setState(() => _selectedYearDropdown = value!),
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
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const HomeScreenDashboard(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
