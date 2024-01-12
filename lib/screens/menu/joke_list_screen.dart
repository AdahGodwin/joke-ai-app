// import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:jokes_ai_app/providers/chats_provider.dart';

class JokeListScreen extends StatelessWidget {
  const JokeListScreen({
    super.key,
    required this.setJokeId,
    required this.selectedJokeId,
  });

  final Function(String id) setJokeId;
  final String selectedJokeId;

  @override
  Widget build(BuildContext context) {
    List<Chat> jokes = Provider.of<ChatsProvider>(context).allChats;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 20.0, left: 10, bottom: 20),
            width: 260,
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
                          .createChat("user1")
                          .then((jokeId) {
                        print("the id : $jokeId");
                        setJokeId(jokeId);
                      });
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
                    itemBuilder: (context, index) => ListTile(
                      titleAlignment: ListTileTitleAlignment.top,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 5),
                      leading: CircleAvatar(
                        radius: 17,
                        backgroundColor: Colors.grey[100],
                        child: Icon(
                          Icons.chat_bubble_outline_rounded,
                          color: jokes[index].chatId == selectedJokeId
                              ? Colors.blue
                              : Colors.grey[350],
                        ),
                      ),
                      title: Text(
                        jokes[index].chatTitle,
                        style: TextStyle(
                          color: jokes[index].chatId == selectedJokeId
                              ? Colors.blue
                              : Colors.black,
                        ),
                      ),
                      onTap: () {
                        setJokeId(jokes[index].chatId);
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
                      backgroundColor: Colors.grey[100],
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.home,
                          size: 25,
                        ),
                        color: Colors.blue,
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
                        icon: const Icon(
                          Icons.logout,
                          size: 25,
                        ),
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
