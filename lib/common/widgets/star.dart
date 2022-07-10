import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Stars extends StatelessWidget {
  final double rating;
  const Stars({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
        itemCount: 5,
        direction: Axis.horizontal,
        itemSize: 15,
        rating: rating,
        itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: GlobalVariables.secondaryColor,
            ));
  }
}
