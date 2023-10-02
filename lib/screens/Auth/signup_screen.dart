import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hng_authentication/authentication.dart';
import 'package:hng_authentication/widgets/rounded_bordered_textfield.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  RegistrationFormState createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                    height: 50,
                  ),
                  Text(
                    "Create Account",
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
                    hintText: "Username",
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 20,
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
                  RoundedBorderedTextField(
                    hintText: "Confirm Password",
                    obscureText: _obscureConfirmPassword,
                    validator: (val) {
                      if (val?.isEmpty ?? true) {
                        return 'Please enter your password';
                      } else if ((val?.length ?? 0) < 6) {
                        return 'Password is not up to 6 characters';
                      } else if (((val?.length ?? 0) >= 6) &&
                          ((val ?? "") != passwordController.text)) {
                        return "Password texts don't match";
                      } else {
                        return null;
                      }
                    },
                    // controller: widget.passwordController,
                    isPass: true,
                    icon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue,
                        ),
                      ),
                      onPressed: () async {
                        final email = (emailController).text;
                        final password = (passwordController).text;
                        final name = nameController.text;
                        final authRepository = Authentication();
                        final data =
                            await authRepository.signUp(email, name, password);
                        if (data != null) {
                          // Registration failed, display an error message

                          print('sign up result: >>> $data');
                          // if (!context.mounted) return;
                          // Navigator.of(context).pushNamed("/home");
                        } else {
                          print('errror:   eeeeeee');
                        }
                      },
                      child: Text(
                        "Sign Up",
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
                        "Have an account?",
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            letterSpacing: .5,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed("/login");
                        },
                        child: Text(
                          "Login",
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
