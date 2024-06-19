import 'package:berry_happy/components/assets_image_widget.dart';
import 'package:berry_happy/cubit/cubit/auth_cubit.dart';
import 'package:berry_happy/dto/login.dart';
import 'package:berry_happy/services/data_service.dart';
import 'package:berry_happy/utils/constants.dart';
import 'package:berry_happy/utils/secure_storage_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 204, 229),
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const AssetImageWidget(
                imagePath: 'assets/images/logo.png',
                height: 250,
                width: 250,
                fit: BoxFit.fill),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                "Let's Make Your Day Berry Special!",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            Container(
              height: 50,
              width: 250,
              child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/main-login'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 255, 255, 255)),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 65, 158),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: AutofillHints.addressCity),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have account?"),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/signup-screen');
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors
                          .blue, // Ubah warna teks agar terlihat seperti link
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
