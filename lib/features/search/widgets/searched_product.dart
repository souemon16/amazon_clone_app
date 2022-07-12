import 'package:flutter/material.dart';

import 'package:amazon_clone/common/widgets/star.dart';
import 'package:amazon_clone/models/product.dart';

class SearchedProduct extends StatelessWidget {
  final Product product;
  const SearchedProduct({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    for (var i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
    }

    double avgRating = 0;
    if (totalRating != 0) {
      avgRating = totalRating / product.rating!.length;
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.contain,
                width: 135,
                height: 135,
              ),
              Column(
                children: [
                  // PRODUCT NAME
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.name,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 2,
                    ),
                  ),
                  // PRODUCT RATING
                  Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: Stars(rating: avgRating)),
                  // PRODUCT PRICE
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      "\$${product.price}",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                  ),
                  // SHIPPING
                  Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10),
                      child: const Text("Eligible For Free Shipping")),
                  // STOCK
                  Container(
                      width: 235,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      child: const Text(
                        "In Stock",
                        style: TextStyle(color: Colors.teal),
                      )),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
