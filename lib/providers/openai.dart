import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class OpenAi with ChangeNotifier {
  Future<void> sendRequest() async {
    try {
      final url = Uri.parse(
          "https://spitfire-interractions.onrender.com/api/chat/completions");
      final response = await http.post(
        url,
        body: json.encode(
          {
            "user_input": "Tell me a Joke on fishes",
          },
        ),
      );
      final responseData = json.decode(response.body);

      print(responseData);
    } catch (error) {
      print(error);
    }
  }
}
