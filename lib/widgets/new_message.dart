import 'package:flutter/material.dart';
import 'package:jokes_ai_app/providers/chats_provider.dart';
import 'package:provider/provider.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({
    super.key,
    required this.chatId,
    this.showHome,
  });
  final String chatId;
  final Function(bool value)? showHome;

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();

  void _sendMessage(String messageId) async {
    FocusNode().unfocus();
    if (_messageController.text.trim().isNotEmpty) {
      Provider.of<ChatsProvider>(context, listen: false).sendMessage(
          {"sender": "user1", "message": _messageController.text},
          widget.chatId,
          true);
      _messageController.clear();
      String error = await Provider.of<ChatsProvider>(context, listen: false)
          .sendRequest(_messageController.text, widget.chatId);
      if (error.isNotEmpty) {
        if (!context.mounted) return;

        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Error"),
                content: Text(error),
              );
            });
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
              onPressed: () {
                String messageId =
                    DateTime.now().millisecondsSinceEpoch.toString();
                _sendMessage(messageId);
                if (widget.showHome != null) {
                  widget.showHome!(false);
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
