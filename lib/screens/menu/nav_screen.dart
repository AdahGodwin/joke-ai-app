import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jokes_ai_app/providers/chats_provider.dart';
import 'package:jokes_ai_app/screens/menu/joke_list_screen.dart';
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
  bool showJoke = false;

  void openDrawer() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
      Future.delayed(const Duration(milliseconds: 180), () {
        setState(() {
          // xOffset = 300;
          // yOffset = 30;
          xOffset = 270;
          yOffset = 150;
          scaleFactor = 0.8;
          isDrawerOpen = true;
        });
      });
    } else {
      setState(() {
        // xOffset = 300;
        // yOffset = 30;
        xOffset = 270;
        yOffset = 150;
        scaleFactor = 0.8;
        isDrawerOpen = true;
      });
    }
  }

  void closeDrawer() {
    if (isDrawerOpen) {
      setState(() {
        xOffset = 0;
        yOffset = 0;
        scaleFactor = 1;
        isDrawerOpen = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String selectedJokeId =
        Provider.of<ChatsProvider>(context).getRecentChatId();

    return Scaffold(
      body: Stack(
        children: [
          JokeListScreen(
            closeDrawer: closeDrawer,
            selectedJokeId: selectedJokeId,
          ),
          CurrentScreen(
            isDrawerOpen: isDrawerOpen,
            xOffset: xOffset,
            yOffset: yOffset,
            scaleFactor: scaleFactor,
            closeDrawer: closeDrawer,
            openDrawer: openDrawer,
            selectedJokeId: selectedJokeId,
          ),
        ],
      ),
    );
  }
}
