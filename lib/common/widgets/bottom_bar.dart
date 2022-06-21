import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/screens/account_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/bottombar';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomNavWidth = 42;
  double borderWidth = 5;

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = const [
    HomeScreen(),
    AccountScreen(),
    Center(
      child: Text("Cart Page"),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[_page],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _page,
          selectedItemColor: GlobalVariables.selectedNavBarColor,
          unselectedItemColor: GlobalVariables.unselectedNavbarColor,
          backgroundColor: GlobalVariables.backgroudColor,
          iconSize: 28,
          onTap: updatePage,
          items: [
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
                child: const Icon(Icons.person_outline_outlined),
              ),
              label: "",
            ),
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
                child: Badge(
                    elevation: 0,
                    badgeContent: const Text("2"),
                    badgeColor: Colors.white,
                    child: const Icon(Icons.shopping_cart_outlined)),
              ),
              label: "",
            )
          ],
        ));
  }
}
