import 'dart:ui';

import 'package:flutter/material.dart';

class ProductAdvertBanner extends StatelessWidget {
  const ProductAdvertBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        gradient: const RadialGradient(
          center: Alignment(0.7, -0.6), // near the top right
          radius: 0.8,
          colors: <Color>[
            Color.fromARGB(255, 166, 132, 250), //
            Color.fromARGB(255, 90, 30, 230), //
          ],
          stops: <double>[0.8, 1.0],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text.rich(
        TextSpan(
          style: TextStyle(color: Colors.white),
          children: [
            TextSpan(text: "A Holiday Surprise\n"),
            TextSpan(
              text: "Cashback 10%",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
