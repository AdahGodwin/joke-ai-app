import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jokes_ai_app/providers/chats_provider.dart';
import 'package:jokes_ai_app/providers/openai.dart';
import 'package:jokes_ai_app/screens/Auth/login_screen.dart';
import 'package:jokes_ai_app/screens/Auth/signup_screen.dart';
import 'package:jokes_ai_app/screens/menu/nav_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatsProvider>(
          create: (context) => ChatsProvider(),
        ),
        ChangeNotifierProvider<OpenAi>(
          create: (context) => OpenAi(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Jokes AI',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const NavScreen(),
        routes: {
          '/signup': (context) => const RegistrationForm(),
          '/login': (context) => const LoginForm(),
          '/home': (context) => const NavScreen(), // Define a route for Home
        },
      ),
    );
  }
}
