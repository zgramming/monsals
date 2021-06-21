import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:global_template/global_template.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  colorPallete.configuration(
    primaryColor: const Color(0xFF1E26D4),
    accentColor: const Color(0xFF00CD9D),
    monochromaticColor: const Color(0xFF0061FF),
  );

  appConfig.configuration(nameLogoAsset: 'logo.png');

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monsals',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: colorPallete.primaryColor,
        accentColor: colorPallete.accentColor,
        textTheme: GoogleFonts.openSansTextTheme(),
      ),
      home: SplashScreen(),
      // routes: <String, WidgetBuilder>{
      //   SplashScreen.routeNamed: (ctx) => SplashScreen(),
      //   LoginScreen.routeNamed: (ctx) => LoginScreen(),
      //   WelcomeScreen.routeNamed: (ctx) => WelcomeScreen(),
      //   ActivityFormScreen.routeNamed: (ctx) => ActivityFormScreen(),
      //   ProductDetailScreen.routeNamed: (ctx) => ProductDetailScreen(),
      // },
      onGenerateRoute: (settings) {
        final routeAnimation = RouteAnimation();
        switch (settings.name) {
          case LoginScreen.routeNamed:
            return routeAnimation.slideTransition(
              screen: (ctx, animation, secondaryAnimation) => LoginScreen(),
            );
          case WelcomeScreen.routeNamed:
            return routeAnimation.fadeTransition(
              screen: (ctx, animation, secondaryAnimation) => WelcomeScreen(),
            );
          case ActivityFormScreen.routeNamed:
            return routeAnimation.fadeTransition(
              screen: (ctx, animation, secondaryAnimation) => ActivityFormScreen(),
            );
          case ProductDetailScreen.routeNamed:
            return routeAnimation.fadeTransition(
              screen: (ctx, animation, secondaryAnimation) => ProductDetailScreen(),
            );
          case TransactionScreen.routeNamed:
            return routeAnimation.fadeTransition(
              screen: (ctx, animation, secondaryAnimation) => TransactionScreen(),
            );
          default:
        }
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  static const routeNamed = '/splash-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreenTemplate(
        image: Image.asset('${appConfig.urlImageAsset}/${appConfig.nameLogoAsset}'),
        navigateAfterSplashScreen: (context) => LoginScreen(),
        copyRightVersion: CopyRightVersion(
          copyRight:
              'Copyright ${GlobalFunction.formatY(DateTime.now())} \u00a9 Syarif Hidayatullah',
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  static const routeNamed = '/login-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: sizes.height(context),
          width: sizes.width(context),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: colorPallete.accentColor!),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      appConfig.fullPathImageAsset,
                      fit: BoxFit.cover,
                      height: sizes.width(context) / 4,
                      width: sizes.width(context) / 4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text('MONSALS',
                      style: GoogleFonts.montserratAlternates(
                          fontWeight: FontWeight.bold, fontSize: 20.0)),
                  const SizedBox(height: 20),
                  const TextFormFieldCustom(
                    disableOutlineBorder: false,
                    hintText: 'Syarif Hidayatullah',
                    labelText: 'Username',
                  ),
                  const SizedBox(height: 20),
                  const TextFormFieldCustom(
                    disableOutlineBorder: false,
                    hintText: '********',
                    labelText: 'Password',
                    isPassword: true,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () =>
                          Navigator.of(context).pushReplacementNamed(WelcomeScreen.routeNamed),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(12.0),
                      ),
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  static const routeNamed = '/welcome-screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _selectedIndex = 1;

  List<Widget> screens = [
    ActivityScreen(),
    const HomeScreen(),
    ProductScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMonsals(),
      body: screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: colorPallete.primaryColor,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Text(
              'Kegiatan',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Text(
              'Home',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Text(
              'Produk',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            label: '',
          ),
        ],
        onTap: (index) => setState(() => _selectedIndex = index),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedMonthDropdown = 'Jan';
  int _selectedYearDropdown = 2021;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Ink(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: colorPallete.accentColor!.withOpacity(.5)),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    '${appConfig.urlImageAsset}/profil.jpg',
                    fit: BoxFit.cover,
                    height: sizes.width(context) / 4,
                    width: sizes.width(context) / 4,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        SizedBox(height: 10),
                        Text('SLS123 - SYARIF H'),
                        SizedBox(height: 10),
                        Text('Cab Bekasi 3'),
                        SizedBox(height: 10),
                        Text('089517229249'),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: DropdownButton<String>(
                      onChanged: (value) => setState(() => _selectedMonthDropdown = value!),
                      isExpanded: true,
                      value: _selectedMonthDropdown,
                      items: <String>['Jan', 'Feb', 'Mar']
                          .map<DropdownMenuItem<String>>(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Center(child: Text(e)),
                            ),
                          )
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
                      items: <int>[2021, 2020, 2019, 2018, 2017]
                          .map<DropdownMenuItem<int>>(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Center(child: Text(e.toString())),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
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
                                    '100',
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
                                    '50',
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
                        child: const FittedBox(
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text('50%'),
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
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Rp. ${GlobalFunction.formatNumber(10000000)}'),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ActivityScreen extends StatefulWidget {
  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  String _selectedMonthDropdown = 'Jan';

  int _selectedYearDropdown = 2021;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: DropdownButton<String>(
                  onChanged: (value) => setState(() => _selectedMonthDropdown = value!),
                  isExpanded: true,
                  value: _selectedMonthDropdown,
                  items: <String>['Jan', 'Feb', 'Mar']
                      .map<DropdownMenuItem<String>>(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Center(child: Text(e)),
                        ),
                      )
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
                  items: <int>[2021, 2020, 2019, 2018, 2017]
                      .map<DropdownMenuItem<int>>(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Center(child: Text(e.toString())),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.separated(
            itemCount: 10,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) => ListTile(
              onTap: () => Navigator.of(context).pushNamed(ActivityFormScreen.routeNamed),
              isThreeLine: true,
              leading: Text('${index + 1}'),
              title: Text(
                'Kunjungan Toko Ibu Hasan',
                style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  '${GlobalFunction.formatHM(DateTime.now())} - ${GlobalFunction.formatHM(DateTime.now().add(const Duration(hours: 2)))} Toko Ibu Hasan \n ${GlobalFunction.formatYMD(DateTime.now(), type: 2)}',
                ),
              ),
              trailing: CircleAvatar(
                backgroundColor: index % 2 == 0 ? Colors.yellow : Colors.green,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ActivityFormScreen extends StatefulWidget {
  static const routeNamed = '/activity-form-screen';
  @override
  _ActivityFormScreenState createState() => _ActivityFormScreenState();
}

class _ActivityFormScreenState extends State<ActivityFormScreen> {
  File? _startPicture;
  File? _endPicture;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMonsals(
        actions: [
          IconButton(
            onPressed: () {},
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
              Text('Rencana - ${GlobalFunction.formatYMD(DateTime.now())}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const TextFormFieldCustom(
                labelText: 'Kode Rencana',
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
              const TextFormFieldCustom(
                labelText: 'HP / TLP Customer',
                initialValue: '089517229249',
                disableOutlineBorder: false,
                prefixIcon: null,
                padding: EdgeInsets.all(12.0),
                readOnly: true,
              ),
              const SizedBox(height: 20),
              const TextFormFieldCustom(
                labelText: 'Alamat',
                initialValue: 'Jl Pondok Ungu Permai Blok A7 No 20',
                disableOutlineBorder: false,
                prefixIcon: null,
                padding: EdgeInsets.all(12.0),
                readOnly: true,
              ),
              const SizedBox(height: 20),
              Divider(color: colorPallete.primaryColor, thickness: 2),
              const SizedBox(height: 10),
              const Text('Realisasi', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              TextFormFieldCustom(
                prefixIcon: null,
                padding: const EdgeInsets.all(12.0),
                labelText: 'Tanggal',
                hintText: '27/03/2021',
                disableOutlineBorder: false,
                readOnly: true,
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100, 12, 12),
                  );
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFormFieldCustom(
                      prefixIcon: null,
                      padding: const EdgeInsets.all(12.0),
                      labelText: 'Mulai',
                      hintText: '12.00',
                      disableOutlineBorder: false,
                      readOnly: true,
                      onTap: () {
                        final now = DateTime.now();
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextFormFieldCustom(
                      prefixIcon: null,
                      padding: const EdgeInsets.all(12.0),
                      labelText: 'Selesai',
                      hintText: '16.00',
                      disableOutlineBorder: false,
                      readOnly: true,
                      onTap: () {
                        final now = DateTime.now();
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
                        );
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
                        final pickedImage = await picker.getImage(source: ImageSource.camera);
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
                        child: (_startPicture == null)
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
                        final pickedImage = await picker.getImage(source: ImageSource.camera);
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
                        child: (_endPicture == null)
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
                  FractionallySizedBox(
                    widthFactor: .455,
                    child: InkWell(
                      onTap: () async {
                        final pickedImage = await picker.getImage(source: ImageSource.camera);
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
                        child: (_endPicture == null)
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
                  FractionallySizedBox(
                    widthFactor: .455,
                    child: InkWell(
                      onTap: () async {
                        final pickedImage = await picker.getImage(source: ImageSource.camera);
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
                        child: (_endPicture == null)
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
                  FractionallySizedBox(
                    widthFactor: .455,
                    child: InkWell(
                      onTap: () async {
                        final pickedImage = await picker.getImage(source: ImageSource.camera);
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
                        child: (_endPicture == null)
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
                  FractionallySizedBox(
                    widthFactor: .455,
                    child: InkWell(
                      onTap: () async {
                        final pickedImage = await picker.getImage(source: ImageSource.camera);
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
                        child: (_endPicture == null)
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
              const SizedBox(height: 20),
              const TextFormFieldCustom(
                prefixIcon: null,
                labelText: 'Penjualan',
                hintText: 'Penjualan',
                disableOutlineBorder: false,
                padding: EdgeInsets.all(12.0),
              ),
              const SizedBox(height: 20),
              const TextFormFieldCustom(
                prefixIcon: null,
                labelText: 'PIC',
                hintText: 'PIC',
                disableOutlineBorder: false,
                padding: EdgeInsets.all(12.0),
              ),
              const SizedBox(height: 20),
              const TextFormFieldCustom(
                prefixIcon: null,
                labelText: 'Catatan',
                hintText: 'Catatan',
                disableOutlineBorder: false,
                padding: EdgeInsets.all(12.0),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String? _selectedKategori;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: DropdownButton<String>(
              onChanged: (value) => setState(() => _selectedKategori = value),
              isExpanded: true,
              value: _selectedKategori,
              hint: const Text('Semua Kategori'),
              items: <String>['Makanan', 'Minuman', 'Mainan']
                  .map<DropdownMenuItem<String>>(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Center(child: Text(e)),
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
              ),
              itemCount: 10,
              itemBuilder: (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(ProductDetailScreen.routeNamed);
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('${appConfig.urlImageAsset}/profil.jpg'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Krim Pemutih ${index + 1}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.openSans(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  static const routeNamed = '/product-detail-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMonsals(
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(TransactionScreen.routeNamed),
            icon: const Icon(FontAwesomeIcons.moneyCheck),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.asset(
              '${appConfig.urlImageAsset}/profil.jpg',
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
                    'Krim Pemutih',
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text('Exp : ${GlobalFunction.formatYMD(DateTime.now())}'),
                  const SizedBox(height: 10.0),
                  const Text('Deskripsi'),
                  const SizedBox(height: 10.0),
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
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

class AppBarMonsals extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final List<Widget>? actions;

  const AppBarMonsals({
    Key? key,
    this.height = kToolbarHeight,
    this.actions,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            'MONSALS',
            style: GoogleFonts.openSans(),
          ),
          const SizedBox(width: 10),
          LiveClock(
            builder: (ctx, time) => RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: GlobalFunction.formatYMD(time)),
                  const TextSpan(text: ' '),
                  TextSpan(text: GlobalFunction.formatHMS(time)),
                ],
              ),
            ),
          )
        ],
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class TransactionScreen extends StatefulWidget {
  static const routeNamed = '/transaction-screen';

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  String? _selectedProduct;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarMonsals(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Rencana - ${GlobalFunction.formatYMD(DateTime.now())}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const TextFormFieldCustom(
                labelText: 'Kode Rencana',
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
              Ink(
                decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFBDBDBD)),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButton<String>(
                  onChanged: (value) => setState(() => _selectedProduct = value),
                  isExpanded: true,
                  value: _selectedProduct,
                  underline: const SizedBox(),
                  hint: const Text('Semua Produk'),
                  items: <String>['Krim Pemutih', 'Krim Kegantengan', 'Krim Kaya Raya']
                      .map<DropdownMenuItem<String>>(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(e),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormFieldCustom(
                labelText: 'Harga Satuan',
                disableOutlineBorder: false,
                prefixIcon: null,
                padding: const EdgeInsets.all(12.0),
                keyboardType: TextInputType.number,
                inputFormatter: [
                  InputNumberFormat(),
                ],
              ),
              const SizedBox(height: 20),
              TextFormFieldCustom(
                labelText: 'Pcs / Box',
                disableOutlineBorder: false,
                prefixIcon: null,
                padding: const EdgeInsets.all(12.0),
                keyboardType: TextInputType.number,
                inputFormatter: [
                  InputNumberFormat(),
                ],
              ),
              const SizedBox(height: 20),
              TextFormFieldCustom(
                labelText: 'Total',
                disableOutlineBorder: false,
                prefixIcon: null,
                padding: const EdgeInsets.all(12.0),
                keyboardType: TextInputType.number,
                readOnly: true,
                inputFormatter: [
                  InputNumberFormat(),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
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
              DataTable(
                columnSpacing: 0,
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text('No'),
                  ),
                  DataColumn(
                    label: Text('Produk'),
                  ),
                  DataColumn(
                    label: Text('Jumlah'),
                  ),
                  DataColumn(
                    label: Text('Total'),
                  ),
                ],
                rows: const <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('1')),
                      DataCell(Text('Krim Pemutih')),
                      DataCell(Text('10')),
                      DataCell(Text('1.000.000')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text('2')),
                      DataCell(Text('Sabun Cuci Muka')),
                      DataCell(Text('5')),
                      DataCell(Text('200.000')),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
