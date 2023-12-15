import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:kun_transport/pages/reset_password.dart';
import 'package:kun_transport/pages/signUp_page.dart';
import 'package:kun_transport/pages/widget/showSnackBar.dart';
import 'package:kun_transport/screens/aut_page_h.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = RegExp(p);

class _LoginPageState extends State<LoginPage> {
  String mtoken = "";
  //text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;

  Future updateUser(User user) async {
    final FirebaseFirestore _db = FirebaseFirestore.instance;
    final userRef = _db.collection("users").doc(user.uid);
    if ((await userRef.get()).exists) {
      await userRef.update({
        "last_login": user.metadata.lastSignInTime!.millisecondsSinceEpoch,
      });
    }
    print("succesfull");
  }

  // void getToken() async {}

  Future signIn() async {
    //show a loading circle
    // showDialog(context: context, builder: (context){
    //  return const Center(child: CircularProgressIndicator());
    // });

// Navigator.of(context).pop();
    //auth the user
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    )
        .then((value) async {
      // Navigator.of(context).pop();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthPageH(),
        ),
      );
      await FirebaseMessaging.instance.getToken().then((token) {
        final FirebaseAuth auth = FirebaseAuth.instance;
        var currentUser = auth.currentUser;
        setState(() {
          mtoken = token!;
        });

        FirebaseFirestore.instance
            .collection("users")
            .doc(currentUser!.uid)
            .update({
          'token': token,
        });
      });

      //  Navigator.of(context).pop();
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text("Email ou mot de passe incorrecte "),
        duration: const Duration(milliseconds: 800),
        backgroundColor: Theme.of(context).primaryColor,
      ));
    });

    // Nouvelle version
    updateUser;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void vaildation() async {
    if (_emailController.text.isEmpty && _passwordController.text.isEmpty) {
      showNotification(context, "Tous les champs sont vides");
    } else if (_emailController.text.isEmpty) {
      showNotification(context, "Le champ email est vide");
    } else if (!regExp.hasMatch(_emailController.text)) {
      showNotification(context, "Veuillez essayer un email valide");
    } else if (_passwordController.text.isEmpty) {
      showNotification(context, "Le champ mot de passe est vide");
    } else if (_passwordController.text.length < 6) {
      showNotification(context, "Le mot de passe est invalide");
    } else {
      signIn();
    }
  }

  bool isButtonActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
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

                const SizedBox(height: 30),

                // welcome back, you've been missed!
                Text(
                  'Bienvenue, vous nous avez manqué !',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                // username textfield
                MyTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                // password textfield
                MyTextField(
                  controller: _passwordController,
                  hintText: 'Mot de passe',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ResetPassword(),
                            ),
                          );
                        },
                        child: Text(
                          'Mot de passe oublié ?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                // sign in button
                GestureDetector(
                  onTap: () async {
                    if (isLoading) return;
                    setState(() => isLoading = true);
                    await Future.delayed(const Duration(seconds: 5));
                    signIn();
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
                                  'Chargement...',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            )
                          : const Text(
                              "Se connecter",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                ),

                // or continue with
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
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      //   child: Text(
                      //     'Ou continuer avec',
                      //     style: TextStyle(color: Colors.grey[700]),
                      //   ),
                      // ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // google + apple sign in buttons
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children:  [
                //     // google button
                //     SquareTile(imagePath: 'assets/images/google.png', onTap: () {

                //       AuthService().signInWithGoogle(); Navigator.push(
                //           context,
                //           MaterialPageRoute(builder: (context) => const AuthPage()));}),

                //     const SizedBox(width: 25),

                //     // apple button
                //     SquareTile(imagePath: 'assets/images/apple.png', onTap: () {},)
                //   ],
                // ),

                const SizedBox(height: 50),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Vous n'avez pas de compte?",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    TextButton(
                      onPressed: () async {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => SignUpPage()));
                      },
                      child: const Text(
                        "S'inscrire",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
