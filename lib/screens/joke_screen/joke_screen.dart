import 'package:flutter/material.dart';
import 'package:jokes_ai_app/providers/chats_provider.dart';
import 'package:jokes_ai_app/widgets/messages.dart';
import 'package:jokes_ai_app/widgets/new_message.dart';
import 'package:jokes_ai_app/widgets/welcome_template.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
    required this.openDrawer,
    required this.closeDrawer,
    required this.isDrawerOpen,
    required this.selectedJokeId,
  });
  final VoidCallback openDrawer;
  final VoidCallback closeDrawer;
  final bool isDrawerOpen;
  final String selectedJokeId;
  @override
  Widget build(BuildContext context) {
    Chat chat = Provider.of<ChatsProvider>(context).getChatbyId(selectedJokeId);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey[100],
                      ),
                      padding: const EdgeInsets.all(4.0),
                      child: IconButton(
                        icon: Image.asset('assets/icons/menu-icon.png'),
                        onPressed: isDrawerOpen ? closeDrawer : openDrawer,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                chat.messages!.isEmpty
                    ? const Expanded(
                        child: SingleChildScrollView(
                          child: WelcomeTemplate(),
                        ),
                      )
                    : Expanded(
                        child: Messages(
                          id: selectedJokeId,
                          chat: chat,
                        ),
                      ),
                // const Spacer(),
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
                  child: NewMessage(
                    chatId: selectedJokeId,
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
