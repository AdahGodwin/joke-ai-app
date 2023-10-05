import "package:flutter/material.dart";
import "package:hngx_openai/repository/openai_repository.dart";
import "package:shared_preferences/shared_preferences.dart";

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
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  OpenAIRepository openAI = OpenAIRepository();
  bool _isTyping = false;
  final List<Chat> _chatList = [];
  bool get isTyping {
    return _isTyping;
  }

  List<Chat> get allChats {
    return [..._chatList];
  }

  String createChat(String userId, [bool notify = true]) {
    String chatId = DateTime.now().millisecondsSinceEpoch.toString();
    _chatList.insert(
        0,
        Chat(
          userId: userId,
          chatId: chatId,
          chatTitle: "New Joke",
          messages: [],
        ));
    if (notify == true) {
      notifyListeners();
    }

    return chatId;
  }

  Chat getChatbyId(String id) {
    List<Chat> chat = _chatList.where((chat) => chat.chatId == id).toList();

    return chat[0];
  }

  Chat getRecentChat(id) {
    List<Chat> chat = _chatList.where((chat) => chat.chatId == id).toList();

    return chat[0];
  }

  String getRecentChatId(userId) {
    if (_chatList.isEmpty) {
      String chatId = createChat(userId, false);
      return chatId;
    }

    List<Chat> emptyChat =
        _chatList.where((chat) => chat.messages!.isEmpty).toList();
    if (emptyChat.isEmpty) {
      String chatId = createChat(userId, false);
      return chatId;
    }
    return emptyChat[0].chatId;
  }

  void sendMessage(Map<String, dynamic> message, String chatId, bool typing) {
    Chat chat = _chatList.where((chat) => chat.chatId == chatId).toList()[0];
    chat.messages?.add(message);
    if (chat.messages!.length == 1) {
      if (chat.messages != null && chat.messages!.isNotEmpty) {
        chat.chatTitle = chat.messages![0]['message'];

        if (chat.chatTitle.length > 50) {
          chat.chatTitle = '${chat.chatTitle.substring(0, 50)}...';
        }
      }
    }
    _isTyping = typing;
    notifyListeners();
  }

  // void clearChats() {
  //   _chatList.clear();
  //   notifyListeners();
  // }
  String filterText(String response) {
    if (response.startsWith("M")) {
      return response.substring(8).trim();
    } else {
      return response.substring(6);
    }
  }

  Future<void> sendRequest(userInput, String chatId) async {
    final SharedPreferences prefs = await _prefs;
    String cookie = prefs.getString("cookie")!;

    try {
      final aiResponse = await openAI.getChat(userInput, cookie);
      if (aiResponse.toLowerCase().contains("error")) {
        _isTyping = false;
      } else {
        String response = filterText(aiResponse);
        String id = DateTime.now().millisecondsSinceEpoch.toString();
        sendMessage(
            {"id": id, "sender": "bot", "message": response}, chatId, false);
      }
    } catch (error) {
      _isTyping = false;
    }
    notifyListeners();
  }
}
