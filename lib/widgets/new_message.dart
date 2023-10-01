import 'package:flutter/material.dart';
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
  void _sendMessage(String messageId) {
    FocusScope.of(context).unfocus();
    if (_messageController.text.trim().isNotEmpty) {
      Provider.of<ChatsProvider>(context, listen: false).sendMessage(
        {"sender": "user1", "message": _messageController.text},
        widget.chatId,
      );

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
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
              onPressed: () {
                String messageId =
                    DateTime.now().millisecondsSinceEpoch.toString();
                _sendMessage(messageId);
              },
              icon: const Icon(Icons.send),
            ),
          ),
        ),
      ],
    );
  }
}
