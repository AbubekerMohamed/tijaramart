// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tijaramart/common/components/custom_button.dart';
import 'package:tijaramart/constants/global_variables.dart';
import 'package:tijaramart/features/admin/services/admin_service.dart';
import 'package:tijaramart/features/search/screens/search_screen.dart';

import 'package:tijaramart/models/order_model.dart';
import 'package:tijaramart/providers/user_provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = "/order-details-screen";
  OrderModel order;
  OrderDetailsScreen({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int statusStep = 0;
  AdminService _adminService = AdminService();
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  void initState() {
    super.initState();
    statusStep = widget.order.status;
  }

  void updateOrderStatus(int status) async {
    _adminService.updateOrderStatus(
        context: context,
        status: status,
        order: widget.order,
        onSuccess: () {
          setState(() {
            if (status == 1) {
              statusStep = statusStep + 1;
            } else {
              statusStep = statusStep - 1;
            }
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
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
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
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
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: "Search tijaramart...",
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: const Icon(
                  Icons.mic,
                  size: 25,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "View order details",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Order Date:   ${DateFormat().format(
                      DateTime.fromMillisecondsSinceEpoch(
                          widget.order.orderedAt),
                    )}"),
                    Text("Order ID:   ${widget.order.id}"),
                    Text("Order Total:  \$${widget.order.totalPrice}"),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "Purchase details",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(
                        children: [
                          Row(
                            children: [
                              Image.network(
                                widget.order.products[i].images[0],
                                height: 120.0,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.order.products[i].name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "Quantity: ${widget.order.quantity[i]}",
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      )
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                "Tracking",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Stepper(
                controlsBuilder: (context, details) {
                  return user.role == 'admin'
                      ? Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Column(
                            children: [
                              if (statusStep != 0)
                                CustomButton(
                                  text: "Rollback",
                                  onPressed: () {
                                    updateOrderStatus(0);
                                  },
                                ),
                              SizedBox(
                                height: 5.0,
                              ),
                              if (statusStep != 3)
                                CustomButton(
                                  color: Colors.deepPurple,
                                  text: "Done",
                                  onPressed: () {
                                    updateOrderStatus(1);
                                  },
                                ),
                            ],
                          ),
                        )
                      : const SizedBox();
                },
                currentStep: statusStep,
                steps: [
                  Step(
                    title: const Text("Pending"),
                    content: const Text("Your order is yet to be delivered."),
                    isActive: statusStep == 0,
                    state: statusStep == 0
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: const Text("Completed"),
                    content: const Text(
                        "Your order has been delivered. you have not signed."),
                    isActive: statusStep == 1,
                    state: statusStep == 1
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: Text("Recieved"),
                    content: Text(
                        "Your order  has been delivered and approved by signature."),
                    isActive: statusStep == 2,
                    state: statusStep == 2
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                  Step(
                    title: Text("Delivered"),
                    content: Text(
                        "Your order  has been delivered and approved by signature."),
                    isActive: statusStep == 3,
                    state: statusStep == 3
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
