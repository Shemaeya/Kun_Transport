
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kun_transport/en/aut_page_h_e.dart';
import 'package:kun_transport/pages/widget/showSnackBar.dart';

import '../components/my_textfield.dart';

class SignUpPageEn extends StatefulWidget {
  SignUpPageEn({super.key});

  @override
  State<SignUpPageEn> createState() => _SignUpPageEnState();
}

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = RegExp(p);
bool isLoading = false;

class _SignUpPageEnState extends State<SignUpPageEn> {
  // text editing controllers
  final _firstNameController = TextEditingController();

  final _lastNameController = TextEditingController();

  final _emailController = TextEditingController();

  final _numberController = TextEditingController();

  final _passwordController = TextEditingController();

  final _passwordConfirmController = TextEditingController();

  // sign user in method
  void signUserUp() async {
    if (_firstNameController.text.isEmpty &&
        _lastNameController.text.isEmpty &&
        _emailController.text.isEmpty &&
        _numberController.text.isEmpty &&
        _passwordController.text.isEmpty &&
        _passwordConfirmController.text.isEmpty) {
      showNotification(context, "All fields are empty");
    } else if (_firstNameController.text.isEmpty) {
      showNotification(context, "The first name field is empty");
    } else if (_lastNameController.text.isEmpty) {
      showNotification(context, "The laste name field is empty");
    } else if (_emailController.text.isEmpty) {
      showNotification(context, "The Email field is empty");
    } else if (!regExp.hasMatch(_emailController.text)) {
      showNotification(context, "Please try a valid email");
    } else if (_passwordController.text.isEmpty) {
      showNotification(context, "The password field is empty");
    } else if (_passwordController.text.length < 6) {
      showNotification(
          context, "The password is too short, enter at least 6 characters");
    } else if (_numberController.text.isEmpty) {
      showNotification(context, "The phone number field is empty");
    } else if (_numberController.text.length < 10 ||
        _numberController.text.length > 10) {
      showNotification(context, "The phone number must be 10 digits");
    } else {
      await signUp();
    }
  }

  Future signUp() async {
    UserCredential res;
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // int buildNumber = int.parse(packageInfo.buildNumber);

    try {
      res = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);

      if (res.user != null) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(res.user!.uid)
            .set({
          "firstName": _firstNameController.text,
          "lastName": _lastNameController.text,
          "uid": res.user!.uid,
          "email": _emailController.text,
          "number": _numberController.text,
          "role": "user",
          "last_login":
              res.user!.metadata.lastSignInTime!.millisecondsSinceEpoch,
          "created_at": res.user!.metadata.creationTime!.millisecondsSinceEpoch,
        }).asStream();
      }
    } on PlatformException catch (error) {
      var message = "Please check your Internet connection";
      if (error.message != null) {
        message = error.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message.toString()),
        duration: const Duration(milliseconds: 600),
        backgroundColor: Theme.of(context).primaryColor,
      ));
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
        duration: const Duration(milliseconds: 600),
        backgroundColor: Theme.of(context).primaryColor,
      ));
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AuthPageHE(),
      ),
    );
  }

  bool isButtonActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Registration",
          style: TextStyle(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // logo
                const Icon(
                  Icons.lock_open,
                  size: 100,
                ),

                const SizedBox(height: 30),

                // welcome back, you've been missed!
                Text(
                  'Register to take advantage of the benefits',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // username textfield
                MyTextField(
                  controller: _firstNameController,
                  hintText: 'Firste Name',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                MyTextField(
                  controller: _lastNameController,
                  hintText: 'laste Name',
                  obscureText: false,
                ),

                const SizedBox(height: 10),
                MyTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                MyTextField(
                  controller: _numberController,
                  hintText: 'Phone number',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                MyTextField(
                  controller: _passwordConfirmController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                const SizedBox(height: 25),

                // sign in button
                GestureDetector(
                  onTap: () async {
                    if (isLoading) return;
                    setState(() => isLoading = true);
                    await Future.delayed(const Duration(seconds: 5));
                    signUserUp();
                    setState(() => isLoading = false);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: isLoading
                          ? Row(
                              children: const [
                                CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                                SizedBox(width: 12),
                                Text(
                                  'Loading...',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            )
                          : const Text(
                              "Sign up",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                // or continue with
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: Divider(
                //           thickness: 0.5,
                //           color: Colors.grey[400],
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //         child: Text(
                //           'Ou continuer avec',
                //           style: TextStyle(color: Colors.grey[700]),
                //         ),
                //       ),
                //       Expanded(
                //         child: Divider(
                //           thickness: 0.5,
                //           color: Colors.grey[400],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                const SizedBox(height: 50),

                // google + apple sign in buttons
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children:  [
                //     // google button
                //     SquareTile(imagePath: 'assets/images/google.png', onTap: () => AuthService().signInWithGoogle(), ),

                //     const SizedBox(width: 25),

                // apple button
                //     SquareTile(imagePath: 'assets/images/apple.png', onTap: () {},)
                //   ],
                // ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
