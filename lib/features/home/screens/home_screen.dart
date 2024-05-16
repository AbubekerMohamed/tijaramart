import 'package:flutter/material.dart';
import 'package:tijaramart/common/utils/screen_size_config.dart';
import 'package:tijaramart/constants/global_variables.dart';
import 'package:tijaramart/features/home/components/address_box.dart';
import 'package:tijaramart/features/home/components/category_box.dart';
import 'package:tijaramart/features/home/components/daily_deal.dart';
import 'package:tijaramart/features/home/components/for_you_products.dart';
import 'package:tijaramart/features/home/components/product_advert_banner.dart';
import 'package:tijaramart/features/home/components/product_banner.dart';
import 'package:tijaramart/features/search/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _homeScreenSearchKey = GlobalKey<FormState>();

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(getProportionateScreenHeight(60)),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: getProportionateScreenHeight(42),
                  margin: EdgeInsets.only(
                      left: getProportionateScreenWidth(12),
                      top: getProportionateScreenWidth(12)),
                  child: Material(
                    borderRadius: BorderRadius.circular(
                      getProportionateScreenWidth(20),
                    ),
                    color: kSecondaryColor.withOpacity(0.1),
                    elevation: 1,
                    child: TextFormField(
                      key: _homeScreenSearchKey,
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: getProportionateScreenWidth(6)),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: getProportionateScreenWidth(22),
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: kSecondaryColor.withOpacity(0.3),
                        contentPadding: const EdgeInsets.only(
                          top: 10,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Search tijaramart...",
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: getProportionateScreenHeight(12),
                margin: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10),
                ),
                child: Icon(
                  Icons.mic,
                  size: getProportionateScreenWidth(25),
                ),
              )
            ],
          ),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            ProductAdvertBanner(),
            // AddressBox(),
            SizedBox(
              height: 10,
            ),
            CategoryBox(),
            SizedBox(
              height: 10,
            ),
            ProductBanner(),
            ForYouProduct(),
            DailyDeal()
          ],
        ),
      ),
    );
  }
}
