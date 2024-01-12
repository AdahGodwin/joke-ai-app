import 'package:flutter/material.dart';

import 'package:jokes_ai_app/screens/joke_screen/joke_screen.dart';

class CurrentScreen extends StatelessWidget {
  const CurrentScreen({
    required this.isDrawerOpen,
    required this.xOffset,
    required this.yOffset,
    required this.scaleFactor,
    super.key,
    required this.closeDrawer,
    required this.openDrawer,
    required this.selectedJokeId,
    required this.showJoke,
  });
  final String selectedJokeId;
  final bool isDrawerOpen;
  final VoidCallback openDrawer;
  final VoidCallback closeDrawer;
  final double xOffset;
  final double yOffset;
  final double scaleFactor;
  final bool showJoke;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: closeDrawer,
      child: AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor)
          ..rotateZ(isDrawerOpen ? 24.999 : 0),
        duration: const Duration(milliseconds: 400),
        curve: Curves.ease,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(239, 233, 232, 232),
              blurRadius: 3,
              offset: Offset(-15, 15),
            ),
            BoxShadow(
              color: Color.fromARGB(238, 204, 203, 203),
              blurRadius: 2,
              offset: Offset(0, 0),
            ),
          ],
          borderRadius: BorderRadius.circular(25),
        ),
        child: AbsorbPointer(
          absorbing: isDrawerOpen,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(isDrawerOpen ? 25 : 0),
            child: ChatScreen(
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
