import 'package:flutter/material.dart';

class LogoText extends StatelessWidget {
  const LogoText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: const Text(
            "JOKES",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        Container(
          width: 40,
          // height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blueGrey,
          ),
          padding: const EdgeInsets.all(4),
          child: const Center(
            child: Text(
              "AI",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
