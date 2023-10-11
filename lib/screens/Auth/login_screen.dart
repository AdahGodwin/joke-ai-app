import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hng_authentication/authentication.dart';
import 'package:hng_authentication/widgets/rounded_bordered_textfield.dart';
import 'package:hng_authentication/widgets/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  bool _obscurePassword = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: screenWidth * 0.06,
            right: screenWidth * 0.06,
            bottom: 30,
          ),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        child: const Text(
                          "JOKES",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(4),
                        color: Colors.blue,
                        child: const Center(
                          child: Text(
                            "AI",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Text(
                    "Login Account",
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                        letterSpacing: .5,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  RoundedBorderedTextField(
                    hintText: "Email Address",
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RoundedBorderedTextField(
                    hintText: "Enter Password",
                    obscureText: _obscurePassword,
                    controller: passwordController,
                    isPass: true,
                    icon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  isLoading == true
                      ? const CircularProgressIndicator(
                          color: Colors.blue,
                        )
                      : SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.blue,
                              ),
                            ),
                            onPressed: emailController.text.isEmpty |
                                    passwordController.text.isEmpty
                                ? null
                                : () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    final email = (emailController).text;
                                    final password = (passwordController).text;
                                    final authRepository = Authentication();

                                    try {
                                      final data = await authRepository.signIn(
                                          email, password);
                                      if (data != null) {
                                        final SharedPreferences prefs =
                                            await _prefs;
                                        prefs.setString(
                                          "cookie",
                                          data.cookie,
                                        );
                                        prefs.setString(
                                            "user",
                                            jsonEncode({
                                              "id": data.id,
                                              "name": data.name,
                                              "email": data.email,
                                              "cookie": data.cookie,
                                              "credits": data.credits,
                                            }));

                                        if (!context.mounted) return;
                                        showSnackbar(context, Colors.blue,
                                            "Sign in Successfull");
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Navigator.of(context)
                                            .pushReplacementNamed("/");
                                      } else {
                                        if (!context.mounted) return;
                                        setState(() {
                                          isLoading = false;
                                        });
                                        showSnackbar(
                                          context,
                                          Colors.red,
                                          "An Error Occured",
                                        );
                                      }
                                    } catch (error) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      if (!context.mounted) return;

                                      showSnackbar(
                                        context,
                                        Colors.red,
                                        "An Error Occured",
                                      );
                                    }
                                  },
                            child: Text(
                              "Login",
                              style: GoogleFonts.lato(
                                textStyle: const TextStyle(
                                  letterSpacing: .16,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Dont have an account?",
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            letterSpacing: .5,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed("/signup");
                        },
                        child: Text(
                          "Sign up",
                          style: GoogleFonts.lato(
                            textStyle: const TextStyle(
                              letterSpacing: .5,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
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
