import 'package:flutter/material.dart';
import 'package:tijaramart/common/components/loader.dart';
import 'package:tijaramart/features/home/services/home_service.dart';
import 'package:tijaramart/features/product_details/screens/product_details_screen.dart';
import 'package:tijaramart/models/product_nodel.dart';

class DailyDeal extends StatefulWidget {
  const DailyDeal({super.key});

  @override
  State<DailyDeal> createState() => _DailyDealState();
}

class _DailyDealState extends State<DailyDeal> {
  HomeService homeService = HomeService();
  ProductModel? dailyDealProduct;

  @override
  void initState() {
    super.initState();
    getDailyDeal();
  }

  void getDailyDeal() async {
    dailyDealProduct = await homeService.getDailyDeal(context: context);
    setState(() {});
  }

  void navigateToProductDetailsScreen() {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,
        arguments: dailyDealProduct);
  }

  @override
  Widget build(BuildContext context) {
    return dailyDealProduct == null
        ? const Loader()
        : dailyDealProduct!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: navigateToProductDetailsScreen,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 15,
                      ),
                      child: const Text(
                        "Deal of the Day",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w300),
                      ),
                    ),
                    Image.network(
                      dailyDealProduct!.images[0],
                      fit: BoxFit.contain,
                      height: 235,
                      width: double.infinity,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                        left: 15,
                      ),
                      child: const Text(
                        "\$100",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(
                        left: 15,
                        top: 5,
                        right: 40,
                      ),
                      child: const Text(
                        "Nike Zoom",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: dailyDealProduct!.images
                            .map(
                              (image) => Image.network(
                                image,
                                fit: BoxFit.contain,
                                width: 100,
                                height: 100,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                        top: 15,
                        bottom: 100,
                      ).copyWith(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "See all deals",
                        style: TextStyle(
                          color: Colors.purple[800],
                        ),
                      ),
                    )
                  ],
                ),
              );
  }
}
