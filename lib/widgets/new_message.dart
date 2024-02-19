import 'package:flutter/material.dart';
// import 'package:jokes_ai_app/local_notifications.dart';
import 'package:jokes_ai_app/providers/chats_provider.dart';
import 'package:provider/provider.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({
    super.key,
    required this.chatId,
  });
  final String chatId;

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();

  void _sendMessage(BuildContext context, String chatId) async {
    ChatsProvider chatsProvider =
        Provider.of<ChatsProvider>(context, listen: false);
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (_messageController.text.trim().isNotEmpty) {
      if (!context.mounted) return;
      chatsProvider.sendMessage(
          {"role": "user", "content": _messageController.text.trim()},
          chatId,
          true);
      _messageController.clear();
      String? error = await chatsProvider.sendRequest(chatId);
      if (error != null && error.isNotEmpty) {
        if (!context.mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error,
              style: const TextStyle(fontSize: 16),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            minLines: 1,
            maxLines: 3,
            controller: _messageController,
            decoration: const InputDecoration.collapsed(
              hintText: "Ask me Anything here",
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
          ),
          child: Center(
            child: IconButton(
              color: const Color.fromRGBO(255, 255, 255, 1),
              onPressed: () async {
                if (widget.chatId == "newchat") {
                  String newId =
                      await Provider.of<ChatsProvider>(context, listen: false)
                          .createChat();
                  if (!context.mounted) return;
                  _sendMessage(context, newId);
                } else {
                  _sendMessage(context, widget.chatId);
                }
              },
              icon: const Icon(Icons.send),
            ),
          ),
        ),
      ],
    );
  }
}
