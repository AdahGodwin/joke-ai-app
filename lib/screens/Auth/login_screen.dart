import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../../widgets/logo_text.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  bool _obscurePassword = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  final _auth = FirebaseAuth.instance;

  void _submitForm(
    String email,
    String password,
    BuildContext ctx,
  ) async {
    // ignore: unused_local_variable
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!context.mounted) return;
      Navigator.of(context).pop();
    } on PlatformException catch (err) {
      var message = 'An error occurred, please check your credentials';

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LogoText(),
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
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Enter Password",
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
                    ),
                    const SizedBox(
                      height: 50,
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
                              onPressed: emailController.text.isEmpty |
                                      passwordController.text.isEmpty
                                  ? null
                                  : () {
                                      final email = (emailController).text;
                                      final password =
                                          (passwordController).text;
                                      _submitForm(email, password, context);
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
                            Navigator.of(context).pop();
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
      ),
    );
  }
}
