import 'package:flutter/material.dart';
import 'package:kun_transport/en/home_page_en.dart';
import 'package:kun_transport/en/login_page_en.dart';
import 'package:kun_transport/en/my_bottom_nav_bar_en.dart';
import 'package:kun_transport/pages/login_page.dart';
import 'package:kun_transport/pages/signUp_page.dart';
import 'package:kun_transport/screens/home_page.dart';

import '../components/my_button.dart';

class TransitionPageEn extends StatelessWidget {
  TransitionPageEn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),

                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),

                const SizedBox(height: 50),

                // welcome back, you've been missed!
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Text(
                    'Sorry, you need to login to access this page',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
                ),

                // username textfield

                const SizedBox(height: 25),

                // sign in button
                MyButtonEn(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => LoginPageEn()));
                  },
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Or ',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                MyButtonSingUpEn(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SignUpPage()));
                  },
                ),

                // or continue with

                const SizedBox(height: 20),

                // google + apple sign in buttons
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const MyBottomNavBarEn()));
                    },
                    child: const Text(
                      "Home>>",
                      style: TextStyle(
                        color: Colors.black26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                // not a member? register now
              ],
            ),
          ),
        ),
      ),
    );
  }
}
