import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NotificationProvider with ChangeNotifier {
  final String openaiApiKey =
      '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';

  Future<String?> sendRequest() async {
    try {
      final openaiEndpoint =
          Uri.parse('https://api.openai.com/v1/chat/completions');
      final openaiHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $openaiApiKey',
      };

      final openaiData = {
        'model': 'gpt-3.5-turbo',
        "max_tokens": 250,
        "temperature": 0.3,
        'messages': [
          {
            'role': 'system',
            'content':
                'You are a friendly Nigerian comedian named Bovi that understands pidgin, Every reply should be comedic, tell jokes the way Nigerian comedians like Bovi, Apororo, Basketmouth and the likes would, you are only a comedian that understands jokes. Don\'t repeat jokes, don\'t tell a joke that starts with why'
          },
          {'role': 'user', 'content': 'tell me a short joke in pidgin'},
        ],
      };

      final response = await http.post(
        openaiEndpoint,
        headers: openaiHeaders,
        body: jsonEncode(openaiData),
      );
      final Map<String, dynamic> data = jsonDecode(response.body);
      String? chatReply = data['choices'][0]['message']['content'];
      return chatReply;
    } on http.ClientException {
      return "Please Check Your Internet Connection";
    } catch (error) {
      return error.toString();
    }
  }
}
