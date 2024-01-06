import 'package:flutter/material.dart';
import 'package:tijaramart/features/account/components/chip_button.dart';

class TopChips extends StatelessWidget {
  const TopChips({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ChipButton(text: "Viral", onPressed: () {}),
            ChipButton(text: "Top Rated", onPressed: () {}),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            ChipButton(text: "For You", onPressed: () {}),
            ChipButton(text: "Summer Sales", onPressed: () {}),
          ],
        ),
      ],
    );
  }
}
