import 'package:flutter/material.dart';

import '../common/utils/screen_size_config.dart';

// slim pc ip 192.168.43.29
// work pc Ethernet adapter Ethernet 172.20.102.160
const String backendURL = "https://tij-backend-vercel.vercel.app";

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(239, 165, 52, 240),
      Color.fromARGB(255, 209, 136, 243),
      Color.fromARGB(255, 209, 135, 243),
    ],
    stops: [0.2, 0.7, 0.5],
  );

  static const secondaryColor = Color.fromRGBO(0, 115, 255, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.purple[800]!;
  static const unselectedNavBarColor = Colors.black87;

  // STATIC IMAGES
  static const List<String> carouselImages = [
    'https://img.freepik.com/free-psd/retro-bazaar-web-template_23-2149052573.jpg?t=st=1715775293~exp=1715778893~hmac=94e118b75f29b92ce378ad2b0c0d8898787dd0eef5af1a9ed0b1d72a280d7987&w=1060',
    'https://img.freepik.com/free-psd/black-friday-super-sale-web-banner-template_120329-3852.jpg?t=st=1715775150~exp=1715778750~hmac=e3a95f2ce00e4cca5c441801dab25f42623f757ac9d97f2d51aa4ea3c52fb928&w=900',
    'https://media.istockphoto.com/id/1359380730/photo/technology-and-multimedia-online-shopping-concept.jpg?s=1024x1024&w=is&k=20&c=dzm-NuVf3HSeSYwDj5EW-iAdmRXVvmq8VURN0hg8ZwU=',
    'https://w7.pngwing.com/pngs/124/695/png-transparent-digital-electronic-products-product-physical-map-digital-electronic-products-phone-thumbnail.png',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Mobiles',
      'image': 'assets/images/mobiles.jpeg',
    },
    {
      'title': 'Essentials',
      'image': 'assets/images/glap.png',
    },
    {
      'title': 'Appliances',
      'image': 'assets/images/appliances.jpeg',
    },
    {
      'title': 'Books',
      'image': 'assets/images/books.jpg',
    },
    {
      'title': 'Fashions',
      'image': 'assets/images/tshirt.png',
    },
  ];
}

const kPrimaryColor = Color.fromARGB(255, 136, 0, 255);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: const BorderSide(color: kTextColor),
  );
}
