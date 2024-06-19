import 'package:berry_happy/components/assets_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    // final authCubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 204, 229),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 60, left: 75, right: 60),
          child: Center(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
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
                // SizedBox(
                //   height: 10,
                // ),
                const Text(
                  'Sign in to continue!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 53, 2, 63),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  // controller: _emailController,
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
                    hintText: 'Email',
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Color.fromARGB(255, 110, 110, 110),
                    ),
                    fillColor:
                        Colors.white, // Set the background color to white
                    filled: true, // Enable filling the background color
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextField(
                  // controller: _passwordController,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Color.fromARGB(255, 168, 168, 168),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {}, icon: Icon(Icons.visibility)),
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
                    fillColor:
                        Colors.white, // Set the background color to white
                    filled: true, // Enable filling the background color
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  // controller: _passwordController,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    color: Color.fromARGB(255, 168, 168, 168),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {}, icon: Icon(Icons.visibility)),
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
                    hintText: 'Confirm password',
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                      color: Color.fromARGB(255, 110, 110, 110),
                    ),
                    fillColor:
                        Colors.white, // Set the background color to white
                    filled: true, // Enable filling the background color
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/main-login');
                      },
                      child: const Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Colors
                              .blue, // Ubah warna teks agar terlihat seperti link
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
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
                        'Sign Up',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 65, 158),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: AutofillHints.addressCity),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
