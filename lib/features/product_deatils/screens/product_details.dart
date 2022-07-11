import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/common/widgets/star.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:amazon_clone/common/widgets/custom_button.dart';

class ProductDetails extends StatefulWidget {
  static const String routeName = '/product-details';

  final Product product;
  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(right: 15),
                  alignment: Alignment.topLeft,
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
                            child: Icon(Icons.search,
                                color: Colors.black, size: 23),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
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
                          borderSide:
                              BorderSide(color: Colors.black38, width: 1),
                        ),
                        hintText: "Search Amazon.in",
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 25,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // PRODUCT ID AND RATING
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(widget.product.id!), const Stars(rating: 4)],
            ),
          ),

          // PRODUCT NAME
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Text(
              widget.product.name,
              style: const TextStyle(fontSize: 15),
            ),
          ),

          // IMAGE CAROUSEL
          CarouselSlider(
              items: widget.product.images.map((i) {
                return Builder(
                    builder: (BuildContext context) => Image.network(
                          i,
                          fit: BoxFit.contain,
                        ));
              }).toList(),
              options: CarouselOptions(height: 300, viewportFraction: 1)),

          // DIVIDER
          Container(
            color: Colors.black12,
            height: 5,
          ),

          // PRODUCT PRICE
          Padding(
            padding: const EdgeInsets.all(8),
            child: RichText(
              text: TextSpan(
                  text: "Deal Price: ",
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: "\$${widget.product.price}",
                        style: const TextStyle(
                            fontSize: 22,
                            color: Colors.red,
                            fontWeight: FontWeight.w500))
                  ]),
            ),
          ),

          // PRODUCT DESCRIPTION
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(widget.product.description),
          ),

          // DIVIDER
          Container(
            color: Colors.black12,
            height: 5,
          ),

          // BUTTON
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomButton(text: "Buy now", onTap: () {}),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CustomButton(
              text: "Add to cart",
              onTap: () {},
              color: const Color.fromRGBO(254, 216, 19, 1),
            ),
          ),

          // DIVIDER
          Container(
            color: Colors.black12,
            height: 5,
          ),

          // RATE THE PRODUCT
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Rate the product",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),

          RatingBar.builder(
              direction: Axis.horizontal,
              initialRating: 0,
              minRating: 1,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4),
              itemBuilder: (context, _) =>
                  const Icon(Icons.star, color: GlobalVariables.secondaryColor),
              onRatingUpdate: (rating) {})
        ],
      )),
    );
  }
}
