import 'package:flutter/material.dart';

import 'social_icons_card.dart';

class SocialAuths extends StatelessWidget {
  const SocialAuths({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialIconsCard(
          icon: "assets/icons/google-icon.svg",
          press: () {},
        ),
        SocialIconsCard(
          icon: "assets/icons/facebook-2.svg",
          press: () {},
        ),
        SocialIconsCard(
          icon: "assets/icons/twitter.svg",
          press: () {},
        ),
      ],
    );
  }
}
