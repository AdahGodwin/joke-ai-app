import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jokes_ai_app/providers/chats_provider.dart';
import 'package:jokes_ai_app/screens/joke_screen/joke_screen.dart';
import 'package:jokes_ai_app/screens/home_screen.dart';

class CurrentScreen extends StatelessWidget {
  const CurrentScreen(
      {required this.isDrawerOpen,
      required this.xOffset,
      required this.yOffset,
      required this.scaleFactor,
      super.key,
      required this.closeDrawer,
      required this.openDrawer,
      required this.selectedJokeId,
      required this.showChat,
      required this.showHomePage,
      required this.showHome});
  final String selectedJokeId;
  final bool isDrawerOpen;
  final VoidCallback openDrawer;
  final VoidCallback closeDrawer;
  final double xOffset;
  final double yOffset;
  final double scaleFactor;
  final bool showChat;
  final bool showHomePage;
  final Function(bool value) showHome;

  @override
  Widget build(BuildContext context) {
    Chat selectedChat =
        Provider.of<ChatsProvider>(context).getRecentChat(selectedJokeId);

    return GestureDetector(
      onTap: closeDrawer,
      child: AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(239, 233, 232, 232),
              blurRadius: 10,
              offset: Offset(-5, 0), // Shadow position
            ),
          ],
          borderRadius: BorderRadius.circular(25),
        ),
        child: AbsorbPointer(
          absorbing: isDrawerOpen,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(isDrawerOpen ? 25 : 0),
            child: selectedChat.messages!.isEmpty && showChat == false ||
                    showHomePage == true
                ? HomeScreen(
                    openDrawer: openDrawer,
                    closeDrawer: closeDrawer,
                    isDrawerOpen: isDrawerOpen,
                    selectedJokeId: selectedJokeId,
                    showHome: showHome)
                : ChatScreen(
                    openDrawer: openDrawer,
                    closeDrawer: closeDrawer,
                    isDrawerOpen: isDrawerOpen,
                    selectedJokeId: selectedJokeId,
                  ),
          ),
        ),
      ),
    );
  }
}
