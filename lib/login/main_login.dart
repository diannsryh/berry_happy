import 'dart:convert';

import 'package:berry_happy/components/assets_image_widget.dart';
import 'package:berry_happy/dashboard/dashboard_consumer.dart';
import 'package:berry_happy/dashboard/dashboard_owner.dart'; 
import 'package:berry_happy/cubit/cubit/auth_cubit.dart';
import 'package:berry_happy/dto/login.dart';
import 'package:berry_happy/services/data_service.dart';
import 'package:berry_happy/utils/constants.dart';
import 'package:berry_happy/utils/secure_storage_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MainLogin extends StatefulWidget {
  const MainLogin({super.key});

  @override
  State<MainLogin> createState() => _MainLoginState();
}

class _MainLoginState extends State<MainLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void sendLogin(context, AuthCubit authCubit) async {
    final email = _emailController.text;
    final password = _passwordController.text;
    debugPrint(email);
    debugPrint(password);
    final response = await DataService.sendLoginData(email, password);
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      debugPrint("sending success");
      final data = jsonDecode(response.body);
      final loggedIn = Login.fromJson(data);
      await SecureStorageUtil.storage
          .write(key: tokenStoreName, value: loggedIn.accessToken);
      authCubit.login(loggedIn.accessToken, loggedIn.idUser, loggedIn.role); // Pass the role as well
      if (loggedIn.role == 'owner') {
        Navigator.pushReplacementNamed(context, "/dashboard-owner");
      } else if (loggedIn.role == 'customer') {
        Navigator.pushReplacementNamed(context, "/dashboard-consumer");
      }
      debugPrint(loggedIn.accessToken);
    } else {
      debugPrint("failed not");
    }
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 204, 229),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 60, left: 75, right: 60),
          child: Center(
            child: Column(
              children: [
                const AssetImageWidget(
                    imagePath: 'assets/images/logo.png',
                    height: 250,
                    width: 250,
                    fit: BoxFit.fill),
                const SizedBox(height: 20),
                const Text(
                  'Welcome,',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 65, 158)),
                ),
                const Text(
                  'Sign in to continue!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 53, 2, 63),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Color.fromARGB(255, 168, 168, 168),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1.0, color: Color.fromARGB(255, 102, 7, 128)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1.0, color: Color.fromARGB(255, 102, 7, 128)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Username',
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Color.fromARGB(255, 110, 110, 110),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Color.fromARGB(255, 168, 168, 168),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1.0, color: Color.fromARGB(255, 102, 7, 128)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 1.0, color: Color.fromARGB(255, 102, 7, 128)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Password',
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Color.fromARGB(255, 110, 110, 110),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      sendLogin(context, authCubit);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 65, 158),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
