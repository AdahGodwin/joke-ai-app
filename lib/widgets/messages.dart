import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jokes_ai_app/providers/chats_provider.dart';
import 'package:jokes_ai_app/widgets/message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({required this.id, super.key, required this.chat});
  final String id;
  final Chat chat;

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    return ListView.builder(
        reverse: true,
        itemCount: chat.messages?.length ?? 0,
        itemBuilder: (context, index) {
          Color backgroundColor;

          if (index % 2 == 0) {
            // backgroundColor = Colors.red;
            backgroundColor = Color((random.nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(1.0);
          } else {
            // backgroundColor = Colors.green;
            backgroundColor = Color((random.nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(1.0);
          }

          return MessageBubble(
            backgroundColor: backgroundColor,
            isMe: chat.messages?.reversed.toList()[index]["sender"] == "user1",
            message: chat.messages?.reversed.toList()[index],
          );
        });
  }
}
