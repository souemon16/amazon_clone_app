import 'package:flutter/material.dart';

import 'package:amazon_clone/features/account/widgets/account_button.dart';

class SuggestedButtons extends StatefulWidget {
  const SuggestedButtons({Key? key}) : super(key: key);

  @override
  State<SuggestedButtons> createState() => _SuggestedButtonsState();
}

class _SuggestedButtonsState extends State<SuggestedButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: "Your Orders", onPressed: () {}),
            AccountButton(text: "Turn Seller", onPressed: () {})
          ],
        ),
        Row(
          children: [
            AccountButton(text: "Log Out", onPressed: () {}),
            AccountButton(text: "Your WishList", onPressed: () {})
          ],
        )
      ],
    );
  }
}
