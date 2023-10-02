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
        headers: {
          'Content-Type': 'application/json',
          "Cookie":
              "287531bd-2718-46b0-a2df-8fc41b4e9416.vqjOCRO6VdMuGBcwZY7o7JegB6M; Expires=Wed, 01 Nov 2023 21:31:45 GMT; Path=/;"
        },
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
