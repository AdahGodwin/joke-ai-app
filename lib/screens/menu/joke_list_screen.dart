import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hng_authentication/authentication.dart';
import 'package:hng_authentication/widgets/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:jokes_ai_app/providers/chats_provider.dart';
// import 'package:jokes_ai_app/providers/openai.dart';

class JokeListScreen extends StatelessWidget {
  const JokeListScreen({
    super.key,
    required this.setJokeId,
    required this.selectedJokeId,
    required this.showHome,
    required this.showHomePage,
  });

  final Function(String id) setJokeId;
  final String selectedJokeId;
  final Function(bool value) showHome;
  final bool showHomePage;

  @override
  Widget build(BuildContext context) {
    List<Chat> jokes = Provider.of<ChatsProvider>(context).allChats;
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

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
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      String jokeId =
                          Provider.of<ChatsProvider>(context, listen: false)
                              .createChat("user1");
                      setJokeId(jokeId);
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
                  height: 30,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView.builder(
                    itemCount: jokes.length,
                    itemBuilder: (context, index) => ListTile(
                      titleAlignment: ListTileTitleAlignment.top,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 10),
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
                      // radius: 17,
                      backgroundColor: Colors.grey[100],
                      child: IconButton(
                        onPressed: () {
                          if (showHomePage == false) {
                            String id = Provider.of<ChatsProvider>(context,
                                    listen: false)
                                .getRecentChatId("user1");
                            setJokeId(id);
                            showHome(true);
                          }
                        },
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
                      // radius: 20,
                      backgroundColor: Colors.grey[100],
                      child: IconButton(
                        onPressed: () async {
                          final prefs = await _prefs;
                          final user = jsonDecode(prefs.getString("user")!);
                          await Authentication().logout(user["email"]);
                          if (!context.mounted) return;

                          showSnackbar(
                              context, Colors.blue, "Logout Successfull");

                          Navigator.of(context).pushReplacementNamed("/");
                        },
                        icon: const Icon(
                          Icons.logout,
                          size: 25,
                        ),
                        color: Colors.red,
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
