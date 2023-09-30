import 'package:flutter/material.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: 280,
          child: Padding(
            padding: const EdgeInsets.only(top: 28.0, left: 10, bottom: 20),
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
                Container(
                  height: 45,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.add),
                      SizedBox(
                        width: 15,
                      ),
                      Text("Start New Chat"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) => ListTile(
                      titleAlignment: ListTileTitleAlignment.top,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
                      leading: CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.grey[100],
                        child: Icon(
                          Icons.chat_bubble_outline_rounded,
                          color: Colors.grey[350],
                        ),
                      ),
                      title: const Text("Joke about fishes and how they act"),
                    ),
                  ),
                ),
                const Spacer(),
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
