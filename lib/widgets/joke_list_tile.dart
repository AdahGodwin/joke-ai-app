import 'package:flutter/material.dart';
import 'package:jokes_ai_app/providers/chats_provider.dart';
import 'package:provider/provider.dart';

class JokeListTile extends StatefulWidget {
  const JokeListTile({
    super.key,
    required this.jokes,
    required this.selectedJokeId,
    required this.index,
    required this.closeDrawer,
  });

  final List<Chat> jokes;
  final String selectedJokeId;
  final int index;
  final Function closeDrawer;
  @override
  State<JokeListTile> createState() => _JokeListTileState();
}

class _JokeListTileState extends State<JokeListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      titleAlignment: ListTileTitleAlignment.top,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      leading: CircleAvatar(
        radius: 17,
        backgroundColor:
            widget.jokes[widget.index].chatId == widget.selectedJokeId
                ? Colors.blueGrey
                : Colors.grey[350],
        child: Image.asset(
          'assets/images/bg2.png',
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        widget.jokes[widget.index].chatTitle,
        style: TextStyle(
          color: widget.jokes[widget.index].chatId == widget.selectedJokeId
              ? Colors.blue
              : Colors.black,
        ),
      ),
      trailing: PopupMenuButton(
        onSelected: (value) {
          Provider.of<ChatsProvider>(context, listen: false)
              .clearOneChat(widget.jokes[widget.index].chatId);
        },
        itemBuilder: (context) {
          return const [
            PopupMenuItem(
              value: "delete",
              child: Text("Delete Chat"),
            ),
          ];
        },
      ),
      onTap: () {
        if (!widget.jokes[widget.index].pressed) {
          Provider.of<ChatsProvider>(context, listen: false)
              .setSelectedId(widget.jokes[widget.index].chatId);
          widget.closeDrawer();
        } else {
          setState(() {
            widget.jokes[widget.index].pressed = false;
          });
        }
      },
    );
  }
}
