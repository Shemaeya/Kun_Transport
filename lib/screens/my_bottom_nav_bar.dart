// import 'package:firebase_auth/firebase_auth.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:kun_transport/constants.dart';
import 'package:kun_transport/pages/actual_order/actual_orders_page.dart';
import 'package:kun_transport/pages/contact/contact_page.dart';
import 'package:kun_transport/screens/home_page.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyBottomNavBarState createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int _selectedIndex = 1;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static final List<Widget> _widgetOptions = <Widget>[
    const ActualOrderPage(),
    const HomePage(),
    const ContactPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 30, 40),
      extendBody: true,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: CurvedNavigationBar(
            backgroundColor: appColor,
            index: _selectedIndex,
            buttonBackgroundColor: appColor,
            height: 45.0,
            color: white,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            animationDuration: const Duration(
              milliseconds: 200,
            ),
            items: <Widget>[
              Icon(
                Icons.play_arrow_outlined,
                size: 30,
                color: _selectedIndex == 0 ? white : black,
              ),
              Icon(
                Icons.home_outlined,
                size: 30,
                color: _selectedIndex == 1 ? white : black,
              ),
              Icon(
                Icons.person_outline,
                size: 30,
                color: _selectedIndex == 2 ? white : black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
