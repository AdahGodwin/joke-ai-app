import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../../widgets/logo_text.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  RegistrationFormState createState() => RegistrationFormState();
}

class RegistrationFormState extends State<RegistrationForm> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  void _submitForm(
    String email,
    String password,
    String username,
    BuildContext ctx,
  ) async {
    // ignore: unused_local_variable
    UserCredential authResult;
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          _isLoading = true;
        });
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // UserModel user = UserModel(
        //   username: username,
        //   profileImageUrl: url,
        // );

        // await FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(authResult.user?.uid)
        //     .set(user.toMap());
      } on PlatformException catch (err) {
        var message = 'An error occurred, please check your creds';

        if (err.message != null) {
          message = err.message as String;
        }

        if (!context.mounted) return;
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(ctx).colorScheme.error,
          ),
        );

        setState(() {
          _isLoading = false;
        });
      } catch (err) {
        setState(() {
          _isLoading = false;
        });
        if (!context.mounted) return;

        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(
            content: Text(err.toString()),
            backgroundColor: Theme.of(ctx).colorScheme.error,
          ),
        );
      }
    }
  }

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
            child: Center(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: screenWidth > 500 ? 400 : double.infinity,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const LogoText(),
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
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Name",
                          labelText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        controller: nameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please Enter Your Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Please Enter a valid email address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Email Address",
                          labelText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter Password",
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          suffixIcon: IconButton(
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
                        obscureText: _obscurePassword,
                        controller: passwordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) {
                          if (val?.isEmpty ?? true) {
                            return 'Please enter your password';
                          } else if ((val?.length ?? 0) < 8) {
                            return 'Password is not up to 8 characters';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (val) {
                          if (val?.isEmpty ?? true) {
                            return 'Please enter your password';
                          } else if (((val ?? "") != passwordController.text)) {
                            return "Password texts don't match";
                          } else {
                            return null;
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                          labelText: "Confirm Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                          ),
                        ),
                        obscureText: _obscureConfirmPassword,

                        // controller: widget.passwordController,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _isLoading == true
                          ? const CircularProgressIndicator(
                              color: Colors.blue,
                            )
                          : SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    Colors.blue,
                                  ),
                                ),
                                onPressed: nameController.text.isEmpty ||
                                        emailController.text.isEmpty ||
                                        passwordController.text.isEmpty
                                    ? null
                                    : () {
                                        final email = (emailController).text;
                                        final password =
                                            (passwordController).text;
                                        final name = nameController.text;

                                        _submitForm(
                                            email, password, name, context);
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
                              Navigator.of(context).pushNamed("/login");
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
        ),
      ),
    );
  }
}
