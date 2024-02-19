import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jokes_ai_app/widgets/joke_list_tile.dart';
import 'package:provider/provider.dart';

import 'package:jokes_ai_app/providers/chats_provider.dart';

class JokeListScreen extends StatelessWidget {
  const JokeListScreen({
    super.key,
    required this.closeDrawer,
    required this.selectedJokeId,
  });

  final Function closeDrawer;
  final String selectedJokeId;

  @override
  Widget build(BuildContext context) {
    List<Chat> jokes = Provider.of<ChatsProvider>(context).allChats;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage("assets/images/background1.jpg"),
            //   ),
            // ),
            padding: const EdgeInsets.only(top: 20.0, left: 10, bottom: 20),
            width: 280,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Your Jokes",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Provider.of<ChatsProvider>(context, listen: false)
                          .setSelectedId("newchat");
                      closeDrawer();
                    },
                    icon: const Icon(Icons.add),
                    label: const Text(
                      "Start new Joke",
                    ),
                    style: OutlinedButton.styleFrom(
                      alignment: const AlignmentDirectional(-1, 0),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ListView.builder(
                    itemCount: jokes.length,
                    itemBuilder: (context, index) => JokeListTile(
                      jokes: jokes,
                      selectedJokeId: selectedJokeId,
                      closeDrawer: closeDrawer,
                      index: index,
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
                      backgroundColor: Colors.grey[100],
                      child: IconButton(
                        onPressed: jokes.isEmpty
                            ? null
                            : () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: const Text(
                                      "Are you sure you want to delete all chats?",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          await Provider.of<ChatsProvider>(
                                                  context,
                                                  listen: false)
                                              .clearChat();
                                          if (!context.mounted) return;
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Yes"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("No"),
                                      )
                                    ],
                                  ),
                                );
                              },
                        icon: const Icon(
                          Icons.delete,
                          size: 25,
                        ),
                        color: Colors.red,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      child: IconButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                        },
                        icon: Image.asset("assets/icons/logout.png"),
                        color: Colors.red,
                      ),
                    ),
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
