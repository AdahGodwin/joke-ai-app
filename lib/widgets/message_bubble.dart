import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    this.message,
    required this.isMe,
    required this.backgroundColor,
    super.key,
  });

  final Map<String, dynamic>? message;
  final bool isMe;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            // color: isMe ? Colors.blue : Colors.green,
            color: backgroundColor,
            borderRadius: BorderRadius.only(
              topRight:
                  isMe ? const Radius.circular(0) : const Radius.circular(15),
              topLeft:
                  isMe ? const Radius.circular(50) : const Radius.circular(0),
              bottomLeft:
                  isMe ? const Radius.circular(50) : const Radius.circular(25),
              bottomRight:
                  isMe ? const Radius.circular(50) : const Radius.circular(15),
            ),
            border: Border.all(
              color: Colors.blueGrey,
              width: 0.3,
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 17,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 8,
          ),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          child: Text(
            message?['message'] ?? "",
            style: TextStyle(
              color: isMe ? Colors.white : Colors.black,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
