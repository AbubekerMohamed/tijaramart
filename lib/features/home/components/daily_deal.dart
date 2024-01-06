import 'package:flutter/material.dart';

class DailyDeal extends StatefulWidget {
  const DailyDeal({super.key});

  @override
  State<DailyDeal> createState() => _DailyDealState();
}

class _DailyDealState extends State<DailyDeal> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
              fontSize: 20,
            ),
          ),
        ),
        Image.network(
          "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fHByb2R1Y3R8ZW58MHx8MHx8fDA%3D",
          fit: BoxFit.fitHeight,
          height: 235,
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
            children: [
              Image.network(
                "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8bmlrZSUyMHNob2VzfGVufDB8fDB8fHww",
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
              Image.network(
                "https://images.unsplash.com/photo-1543508282-6319a3e2621f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTd8fG5pa2UlMjBzaG9lc3xlbnwwfHwwfHx8MA%3D%3D",
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
              Image.network(
                "https://images.unsplash.com/photo-1515955656352-a1fa3ffcd111?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fG5pa2UlMjBzaG9lc3xlbnwwfHwwfHx8MA%3D%3D",
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
              Image.network(
                "https://images.unsplash.com/photo-1600185365926-3a2ce3cdb9eb?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8bmlrZSUyMHNob2VzfGVufDB8fDB8fHww",
                fit: BoxFit.cover,
                width: 100,
                height: 100,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
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
    );
  }
}
