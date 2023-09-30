import 'package:flutter/material.dart';
import 'package:jokes_ai_app/screens/chat_screen/widgets/welcome_template.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen(
      {super.key,
      required this.openDrawer,
      required this.closeDrawer,
      required this.isDrawerOpen});
  final VoidCallback openDrawer;
  final VoidCallback closeDrawer;
  final bool isDrawerOpen;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: isDrawerOpen ? closeDrawer : openDrawer,
                ),
                const Text(
                  "Logo",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            const WelcomeTemplate(),
            const Spacer(),
            Container(
              height: 60,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  const Expanded(
                      child: TextField(
                    decoration: InputDecoration.collapsed(
                        hintText: "Ask me Anything here"),
                  )),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: IconButton(
                        color: Colors.white,
                        onPressed: () {},
                        icon: const Icon(Icons.send),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
