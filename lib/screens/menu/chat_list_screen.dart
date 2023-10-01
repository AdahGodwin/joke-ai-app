import 'package:flutter/material.dart';
import 'package:jokes_ai_app/providers/chats_provider.dart';
import 'package:provider/provider.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen(
      {super.key, required this.setChatId, required this.selectedChatId});
  final Function(String id) setChatId;
  final String selectedChatId;
  @override
  Widget build(BuildContext context) {
    List<Chat> chats = Provider.of<ChatsProvider>(context).allChats;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 28.0, left: 10, bottom: 20),
            width: 280,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Your Jokes",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  // height: 45,
                  width: double.infinity,

                  child: OutlinedButton.icon(
                    onPressed: () {
                      String chatId =
                          Provider.of<ChatsProvider>(context, listen: false)
                              .createChat("user1");
                      setChatId(chatId);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text(
                      "Start new Chat",
                    ),
                    style: OutlinedButton.styleFrom(
                      alignment: const AlignmentDirectional(-1, 0),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (context, index) => ListTile(
                      titleAlignment: ListTileTitleAlignment.top,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      leading: CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.grey[100],
                        child: Icon(
                          Icons.chat_bubble_outline_rounded,
                          color: chats[index].chatId == selectedChatId
                              ? Colors.blue
                              : Colors.grey[350],
                        ),
                      ),
                      title: Text(
                        chats[index].chatTitle,
                        style: TextStyle(
                          color: chats[index].chatId == selectedChatId
                              ? Colors.blue
                              : Colors.black,
                        ),
                      ),
                      onTap: () {
                        setChatId(chats[index].chatId);
                      },
                    ),
                  ),
                ),
                const Divider(),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.grey[100],
                      child: const Icon(
                        Icons.logout,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    CircleAvatar(
                      radius: 17,
                      backgroundColor: Colors.grey[100],
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.black54,
                      ),
                    ),
                    // CircleAvatar(
                    //   radius: 17,
                    //   backgroundColor: Colors.grey[300],
                    //   child: const Icon(
                    //     Icons.chat_bubble_outline_rounded,
                    //     color: Colors.white,
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
