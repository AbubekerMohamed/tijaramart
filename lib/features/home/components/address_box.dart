import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tijaramart/providers/user_provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: 40,
      padding: const EdgeInsets.only(
        left: 10,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(136, 153, 6, 238),
            Color.fromARGB(148, 24, 72, 148),
          ],
          stops: [0.5, 1.0],
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 5,
              ),
              child: Text(
                "Delivery to ${user.name} - ${user.address}",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Icon(
              Icons.arrow_drop_down_circle_outlined,
              size: 18,
            ),
          )
        ],
      ),
    );
  }
}
