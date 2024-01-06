import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tijaramart/constants/global_variables.dart';

class ProductBanner extends StatelessWidget {
  const ProductBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages.map((index) {
        return Builder(
          builder: (BuildContext context) => Image.network(
            index,
            fit: BoxFit.cover,
            height: 200,
          ),
        );
      }).toList(),
      options: CarouselOptions(
        // the image fills the screen
        viewportFraction: 1,
        height: 200,
      ),
    );
  }
}
