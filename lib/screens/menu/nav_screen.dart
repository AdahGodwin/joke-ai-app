import 'package:flutter/material.dart';
import 'package:jokes_ai_app/screens/menu/chat_list_screen.dart';
import 'package:jokes_ai_app/screens/menu/current_screen.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  void openDrawer() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
      Future.delayed(const Duration(milliseconds: 180), () {
        setState(() {
          xOffset = 300;
          yOffset = 30;
          isDrawerOpen = true;
        });
      });
    } else {
      setState(() {
        xOffset = 300;
        yOffset = 30;
        isDrawerOpen = true;
      });
    }
  }

  void closeDrawer() {
    setState(() {
      xOffset = 0;
      yOffset = 0;
      scaleFactor = 1;
      isDrawerOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const ChatListScreen(),
          CurrentScreen(
              isDrawerOpen: isDrawerOpen,
              xOffset: xOffset,
              yOffset: yOffset,
              scaleFactor: scaleFactor,
              closeDrawer: closeDrawer,
              openDrawer: openDrawer),
        ],
      ),
    );
  }
}
