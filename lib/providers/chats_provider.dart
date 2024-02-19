import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jokes_ai_app/db_helper/db_helper.dart';

String useruid = FirebaseAuth.instance.currentUser!.uid;

class Chat {
  Chat({
    required this.userId,
    required this.chatId,
    required this.chatTitle,
    this.messages,
  });

  final String userId;
  final String chatId;
  String chatTitle;
  final List<Map<String, dynamic>>? messages;
  bool pressed = false;
}

class ChatsProvider with ChangeNotifier {
  String selectedJokeId = "newchat";

  final String openaiApiKey = "API-KEY";
  bool _isTyping = false;

  Chat defaultChat = Chat(
    userId: useruid,
    chatId: "newchat",
    chatTitle: "New Joke",
    messages: [],
  );
  List<Chat> _chatList = [
    Chat(
        userId: useruid,
        chatId: "newchat",
        chatTitle: "New Joke",
        messages: []),
    Chat(
        userId: useruid,
        chatId: "newchat",
        chatTitle: "New Joke",
        messages: []),
    Chat(
        userId: useruid,
        chatId: "newchat",
        chatTitle: "New Joke",
        messages: []),
  ];

  bool get isTyping {
    return _isTyping;
  }

  List<Chat> get allChats {
    return [..._chatList.reversed];
  }

  Future<String> createChat([bool notify = true]) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    await DBHelper.insert("chats", {
      "id": id,
      "userId": useruid,
      "title": "New Joke",
      "messages": "",
    });
    await fetchAndSetChats();

    selectedJokeId = id;
    notifyListeners();
    return id;
  }

  Chat getChatbyId(String id) {
    if (id == "newchat") {
      return defaultChat;
    }

    List<Chat> chat = _chatList.where((chat) => chat.chatId == id).toList();

    return chat[0];
  }

  String getRecentChatId() {
    fetchAndSetChats();
    return selectedJokeId;
  }

  String convertString(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }

  void setSelectedId(String id) {
    selectedJokeId = id;
    notifyListeners();
  }

  void sendMessage(
      Map<String, dynamic> message, String chatId, bool typing) async {
    Chat chat = _chatList.where((chat) => chat.chatId == chatId).toList()[0];

    chat.messages?.add(message);
    DBHelper.update(
      'chats',
      {'messages': jsonEncode(chat.messages)},
      'id',
      chatId,
    );
    _isTyping = typing;
    notifyListeners();
  }

  // Send Request to OpenAI
  Future<dynamic> sendRequest(String chatId) async {
    Chat chat = _chatList.where((chat) => chat.chatId == chatId).toList()[0];
    try {
      final openaiEndpoint =
          Uri.parse('https://api.openai.com/v1/chat/completions');
      final openaiHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $openaiApiKey',
      };

      final openaiData = {
        'model': 'gpt-3.5-turbo',
        "max_tokens": 180,
        "temperature": 1,
        'messages': [
          {
            'role': 'system',
            'content':
                'You are a friendly Nigerian comedian that understands pidgin as well as English,Every reply should be comedic, don\'t tell any joke that starts with why, tell jokes the way Nigerian comedians like Bovi, Apororo, Basketmouth and others would, you can only tell jokes, don\'t write any form of code. Your response shouldn\'t be more than 25 words. Your creator/developer is Godwin Adah also known as Cypher'
          },
          ...?chat.messages
        ],
      };

      final response = await http.post(
        openaiEndpoint,
        headers: openaiHeaders,
        body: jsonEncode(openaiData),
      );
      final Map<String, dynamic> data = jsonDecode(response.body);
      String? chatReply =
          convertString(data['choices'][0]['message']['content']);

      sendMessage({"role": "assistant", "content": chatReply}, chatId, false);

      if (chat.messages!.isNotEmpty && chat.chatTitle == "New Joke") {
        final response = await http.post(
          openaiEndpoint,
          headers: openaiHeaders,
          body: jsonEncode({
            'model': 'gpt-3.5-turbo',
            "max_tokens": 50,
            "temperature": 0.2,
            'messages': [
              {
                'role': 'system',
                'content':
                    'Suggest a short comedic, and suitable title of not more than 5 words for the chat.'
              },
              ...?chat.messages
            ],
          }),
        );

        final Map<String, dynamic> data = jsonDecode(response.body);
        String newTitle =
            convertString(data['choices'][0]['message']['content']);

        //update chat title
        DBHelper.update(
          'chats',
          {'title': newTitle.replaceAll('"', '')},
          'id',
          chat.chatId,
        );

        await fetchAndSetChats();
      }
    } on http.ClientException {
      _isTyping = false;
      notifyListeners();
      return "Please Check Your Internet Connection";
    } catch (error) {
      _isTyping = false;
      notifyListeners();
      return error.toString();
    }
    _isTyping = false;
    notifyListeners();
  }

  Future<void> fetchAndSetChats() async {
    final dataList = await DBHelper.getData('chats');
    _chatList = dataList
        .map((chat) => Chat(
              chatId: chat['id'],
              userId: chat['userId'],
              chatTitle: chat['title'],
              messages: chat['messages'] == ""
                  ? []
                  : List<Map<String, dynamic>>.from(
                      jsonDecode(chat['messages'])),
            ))
        .toList();
    notifyListeners();
  }

  Future<void> clearChat() async {
    await DBHelper.clearDb("chats");
    await fetchAndSetChats();
    selectedJokeId = defaultChat.chatId;
    notifyListeners();
  }

  Future<void> clearOneChat(String id) async {
    if (id == selectedJokeId) {
      selectedJokeId = defaultChat.chatId;
      notifyListeners();
    }
    await DBHelper.deleteOne("chats", "id", id);
    await fetchAndSetChats();
  }
}
