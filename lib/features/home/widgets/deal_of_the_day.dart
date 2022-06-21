import 'package:flutter/material.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({Key? key}) : super(key: key);

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 10, top: 15),
          child: const Text(
            "Deal of the day",
            style: TextStyle(fontSize: 20),
          ),
        ),
        Image.network(
          "https://tse1.mm.bing.net/th?id=OIP.Wo9TGZukb55eA7lge_z--QHaFn&pid=Api&P=0&w=236&h=178",
          height: 250,
          fit: BoxFit.fitHeight,
        ),
        Container(
          padding: const EdgeInsets.only(left: 15, top: 5),
          alignment: Alignment.topLeft,
          child: const Text(
            "\$100",
            style: TextStyle(fontSize: 18),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
          alignment: Alignment.topLeft,
          child: const Text(
            "Asus Zenmax Pro",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Image.network(
                'https://tse2.mm.bing.net/th?id=OIP.CIM8UVfmX9h7Ufovm_XZgAHaE4&pid=Api&P=0&w=268&h=176',
                width: 100,
                height: 100,
                fit: BoxFit.fitWidth,
              ),
              Image.network(
                'https://tse2.mm.bing.net/th?id=OIP.CIM8UVfmX9h7Ufovm_XZgAHaE4&pid=Api&P=0&w=268&h=176',
                width: 100,
                height: 100,
                fit: BoxFit.fitWidth,
              ),
              Image.network(
                'https://tse2.mm.bing.net/th?id=OIP.CIM8UVfmX9h7Ufovm_XZgAHaE4&pid=Api&P=0&w=268&h=176',
                width: 100,
                height: 100,
                fit: BoxFit.fitWidth,
              ),
              Image.network(
                'https://tse2.mm.bing.net/th?id=OIP.CIM8UVfmX9h7Ufovm_XZgAHaE4&pid=Api&P=0&w=268&h=176',
                width: 100,
                height: 100,
                fit: BoxFit.fitWidth,
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
          alignment: Alignment.topLeft,
          child: Text(
            "See all deals",
            style: TextStyle(color: Colors.cyan[800]),
          ),
        )
      ],
    );
  }
}
