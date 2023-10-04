import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jokes_ai_app/models/scrolling_card_data.dart';

class ScrollingCards extends StatelessWidget {
  final List<ScrollingCardData> cardTitles = [
    ScrollingCardData(
        jokeTitle: 'This is the funniest thing you have heard all year'),
    ScrollingCardData(
        jokeTitle:
            'Why did the chicken cross the road asks the curious passerby'),
    ScrollingCardData(
        jokeTitle:
            'Two girls and one guy where caught in bed. Do you know why?'),
    ScrollingCardData(jokeTitle: 'The dog said to the lion, you talk too much'),
  ];

  ScrollingCards({super.key});

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cardTitles.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: MediaQuery.of(context).size.width - 100,
            child: Card(
              color: Color((random.nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(1.0),
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      'assets/images/spring.png',
                      height: 70,
                      width: 100,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        cardTitles[index].jokeTitle,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
