import 'package:flutter/material.dart';
import 'package:tijaramart/common/utils/screen_size_config.dart';
import 'package:tijaramart/constants/global_variables.dart';
import 'package:tijaramart/features/home/screens/category_screen.dart';

class CategoryBox extends StatelessWidget {
  const CategoryBox({super.key});

  navigateToCategoryScreen(BuildContext context, String category) {
    Navigator.pushNamed(
      context,
      CategoryScreen.routeName,
      arguments: category,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: SizedBox(
        height: getProportionateScreenHeight(80),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemExtent: 75,
          itemCount: GlobalVariables.categoryImages.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                navigateToCategoryScreen(
                  context,
                  GlobalVariables.categoryImages[index]['title']!,
                );
              },
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        GlobalVariables.categoryImages[index]['image']!,
                        fit: BoxFit.cover,
                        height: getProportionateScreenHeight(50),
                        width: getProportionateScreenWidth(50),
                      ),
                    ),
                  ),
                  Text(
                    GlobalVariables.categoryImages[index]['title']!,
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
