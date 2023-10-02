import 'package:flutter/material.dart';

class ScrollingCards extends StatelessWidget {
  final List<String> cardTitles = [
    'Card 1',
    'Card 2',
    'Card 3',
  ];

  ScrollingCards({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cardTitles.length,
        itemBuilder: (context, index) {
          return SizedBox(
            width: MediaQuery.of(context).size.width - 50, // Width of each card
            child: Card(
              margin: const EdgeInsets.symmetric(
                  horizontal: 10.0, vertical: 10.0), // Margin around each card
              child: Center(
                child: Text(
                  cardTitles[index],
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
