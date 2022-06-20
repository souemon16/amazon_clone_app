import 'package:amazon_clone/features/account/widgets/single_product.dart';
import 'package:flutter/material.dart';

import 'package:amazon_clone/constants/global_variables.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List list = [
    "https://tse3.explicit.bing.net/th?id=OIP.cIQdpNYm9Jyadq9sDlEKUgDMEy&pid=Api&P=0&w=111&h=167",
    "https://tse3.explicit.bing.net/th?id=OIP.cIQdpNYm9Jyadq9sDlEKUgDMEy&pid=Api&P=0&w=111&h=167",
    "https://tse3.explicit.bing.net/th?id=OIP.cIQdpNYm9Jyadq9sDlEKUgDMEy&pid=Api&P=0&w=111&h=167",
    "https://tse3.explicit.bing.net/th?id=OIP.cIQdpNYm9Jyadq9sDlEKUgDMEy&pid=Api&P=0&w=111&h=167",
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                "Your Orders",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                "See All",
                style: TextStyle(
                  color: GlobalVariables.selectedNavBarColor,
                ),
              ),
            )
          ],
        ),
        // DISPLAY PRODUCTS
        Container(
          height: 170,
          padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
          child: ListView.builder(
              itemCount: list.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SingleProuduct(image: list[index]);
              }),
        )
      ],
    );
  }
}
