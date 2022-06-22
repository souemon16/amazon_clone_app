import 'package:flutter/material.dart';

import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/admin/screens/post_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomNavWidth = 42;
  double borderWidth = 5;

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = const [
    PostScreen(),
    Center(
      child: Text("Analytics Page"),
    ),
    Center(
      child: Text("Orders Page"),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  width: 120,
                  height: 45,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: const Text(
                  "Admin",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavbarColor,
        backgroundColor: GlobalVariables.backgroudColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          // POSTS PAGE
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _page == 0
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroudColor,
                      width: borderWidth),
                ),
              ),
              child: const Icon(Icons.home_outlined),
            ),
            label: "",
          ),
          // ANALYTICS PAGE
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _page == 1
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroudColor,
                      width: borderWidth),
                ),
              ),
              child: const Icon(Icons.analytics_outlined),
            ),
            label: "",
          ),
          // ORDERS PAGE
          BottomNavigationBarItem(
            icon: Container(
              width: bottomNavWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _page == 2
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroudColor,
                      width: borderWidth),
                ),
              ),
              child: const Icon(Icons.all_inbox_outlined),
            ),
            label: "",
          )
        ],
      ),
    );
  }
}
