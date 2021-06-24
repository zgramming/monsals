import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';
import 'package:intl/date_symbol_data_local.dart';

import './src/app.dart';

class Logger extends ProviderObserver {
  @override
  void didUpdateProvider(ProviderBase provider, Object? newValue) {
    log('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "newValue": "$newValue"
}''');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  colorPallete.configuration(
    primaryColor: const Color(0xFF1E26D4),
    accentColor: const Color(0xFF00CD9D),
    monochromaticColor: const Color(0xFF0061FF),
  );

  appConfig.configuration(nameLogoAsset: 'logo.png');

  runApp(
    ProviderScope(
      observers: [Logger()],
      child: MyApp(),
    ),
  );
}
