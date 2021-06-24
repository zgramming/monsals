import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';
import 'package:google_fonts/google_fonts.dart';

import './network/model/my_network.dart';
import './screens/activity/activity_form_screen.dart';
import './screens/login/login_screen.dart';
import './screens/product/product_detail_screen.dart';
import './screens/splash/splash_screen.dart';
import './screens/transaction/transaction_sreen.dart';
import './screens/welcome/welcome_screen.dart';

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
              screen: (ctx, animation, secondaryAnimation) {
                final idRencana = settings.arguments as int?;
                return ActivityFormScreen(idRencana: idRencana);
              },
            );
          case ProductDetailScreen.routeNamed:
            return routeAnimation.fadeTransition(
              screen: (ctx, animation, secondaryAnimation) {
                final ProdukModel? produk = settings.arguments as ProdukModel?;
                return ProductDetailScreen(produk: produk);
              },
            );
          case TransactionScreen.routeNamed:
            return routeAnimation.fadeTransition(
              screen: (ctx, animation, secondaryAnimation) {
                final int? idRencana = settings.arguments as int?;
                return TransactionScreen(idRencana: idRencana ?? 0);
              },
            );
          default:
        }
      },
    );
  }
}
