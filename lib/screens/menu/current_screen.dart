import 'package:flutter/material.dart';
import 'package:jokes_ai_app/screens/chat_screen/chat_screen.dart';

class CurrentScreen extends StatelessWidget {
  const CurrentScreen({
    required this.isDrawerOpen,
    required this.xOffset,
    required this.yOffset,
    required this.scaleFactor,
    super.key,
    required this.closeDrawer,
    required this.openDrawer,
  });

  final bool isDrawerOpen;
  final VoidCallback openDrawer;
  final VoidCallback closeDrawer;
  final double xOffset;
  final double yOffset;
  final double scaleFactor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: closeDrawer,
      child: AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor),
        duration: const Duration(milliseconds: 250),
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
              child: ChatScreen(
                openDrawer: openDrawer,
                closeDrawer: closeDrawer,
                isDrawerOpen: isDrawerOpen,
              )),
        ),
      ),
    );
  }
}
