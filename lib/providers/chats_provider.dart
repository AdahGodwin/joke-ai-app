import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jokes_ai_app/db_helper/db_helper.dart';

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
}

class ChatsProvider with ChangeNotifier {
  final String openaiApiKey = 'API_KEY';
  bool _isTyping = false;
  List<Chat> _chatList = [];

  bool get isTyping {
    return _isTyping;
  }

  List<Chat> get allChats {
    return [..._chatList];
  }

  Future<String> createChat(String userId, [bool notify = true]) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    await DBHelper.insert("chats", {
      "id": id,
      "userId": userId,
      "title": "New Joke",
      "messages": "",
    });
    await fetchAndSetChats();
    // _chatList.insert(
    //     0,
    //     Chat(
    //       userId: userId,
    //       chatId: chatId,
    //       chatTitle: "New Joke",
    //       messages: [],
    //     ));
    if (notify == true) {
      notifyListeners();
    }

    return id;
  }

  Chat getChatbyId(String id) {
    List<Chat> chat = _chatList.where((chat) => chat.chatId == id).toList();

    return chat[0];
  }

  Chat getRecentChat(id) {
    List<Chat> chat = _chatList.where((chat) => chat.chatId == id).toList();

    return chat[0];
  }

  Future<String> getRecentChatId(userId) async {
    await fetchAndSetChats();
    if (_chatList.isEmpty) {
      String chatId = await createChat(userId, false);
      return chatId;
    }

    List<Chat> emptyChat =
        _chatList.where((chat) => chat.messages!.isEmpty).toList();
    if (emptyChat.isEmpty) {
      String chatId = await createChat(userId, false);
      return chatId;
    }
    return emptyChat[0].chatId;
  }

  void sendMessage(Map<String, dynamic> message, String chatId, bool typing) {
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

  // void clearChats() {
  //   _chatList.clear();
  //   notifyListeners();
  // }
  // String filterText(String response) {
  //   if (response.startsWith("M")) {
  //     return response.substring(8).trim();
  //   } else {
  //     return response.substring(6);
  //   }
  // }

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
        "max_tokens": 150,
        "temperature": 0.2,
        'messages': [
          {
            'role': 'system',
            'content':
                'You are a friendly Nigerian comedian that understands pidgin as well as English,Every reply should be comedic, don\'t tell dad jokes, tell jokes the way Nigerian comedians like Bovi, Apororo, Basketmouth and the likes would, you are only a comedian that understands jokes. Your response shouldn\'t be more than 25 words'
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
      print(data);
      String? chatReply = data['choices'][0]['message']['content'];

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
                    'Suggest a short comedic, and suitable title of not more than 5 words for the chat'
              },
              ...?chat.messages
            ],
          }),
        );
        final Map<String, dynamic> data = jsonDecode(response.body);
        chat.chatTitle = data['choices'][0]['message']['content'];

        if (chat.chatTitle.length > 50) {
          chat.chatTitle = '${chat.chatTitle.substring(0, 50)}...';
        }
      }
    } on http.ClientException {
      _isTyping = false;
      notifyListeners();
      return "Please Check Your Internet Connection";
    } catch (error) {
      _isTyping = false;
      notifyListeners();
      print('$error is coming from here');
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
}
