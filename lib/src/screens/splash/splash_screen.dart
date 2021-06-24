import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';

import '../../provider/my_provider.dart';
import '../login/login_screen.dart';
import '../welcome/welcome_screen.dart';

class SplashScreen extends StatelessWidget {
  static const routeNamed = '/splash-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, watch, child) {
          final _session = watch(readSession);
          return _session.when(
            data: (value) => SplashScreenTemplate(
              image: Image.asset('${appConfig.urlImageAsset}/${appConfig.nameLogoAsset}'),
              navigateAfterSplashScreen: (context) {
                if (value == null) {
                  return LoginScreen();
                }

                return WelcomeScreen();
              },
              copyRightVersion: CopyRightVersion(
                copyRight:
                    'Copyright ${GlobalFunction.formatY(DateTime.now())} \u00a9 Syarif Hidayatullah',
              ),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(
              child: Text(error.toString()),
            ),
          );
        },
      ),
    );
  }
}
