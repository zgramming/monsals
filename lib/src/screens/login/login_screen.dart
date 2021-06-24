import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:global_template/global_template.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../provider/my_provider.dart';
import '../welcome/welcome_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeNamed = '/login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProviderListener(
        provider: isLoading,
        onChange: (context, value) {},
        child: SingleChildScrollView(
          child: SizedBox(
            height: sizes.height(context),
            width: sizes.width(context),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      TextFormFieldCustom(
                        controller: _usernameController,
                        disableOutlineBorder: false,
                        hintText: 'Syarif Hidayatullah',
                        labelText: 'Username',
                        validator: (value) =>
                            (value?.isEmpty ?? true) ? 'Username tidak boleh kosong' : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormFieldCustom(
                        controller: _passwordController,
                        disableOutlineBorder: false,
                        hintText: '********',
                        labelText: 'Password',
                        isPassword: true,
                        validator: (value) =>
                            (value?.isEmpty ?? true) ? 'Password tidak boleh kosong' : null,
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
                              await context.read(userProvider.notifier).login(
                                  username: _usernameController.text,
                                  password: _passwordController.text);

                              context.read(isLoading).state = false;
                              Navigator.of(context).pushReplacementNamed(WelcomeScreen.routeNamed);
                            } catch (e) {
                              GlobalFunction.showSnackBar(
                                context,
                                content: Text(e.toString()),
                                snackBarType: SnackBarType.error,
                              );
                            }
                          },
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
        ),
      ),
    );
  }
}
