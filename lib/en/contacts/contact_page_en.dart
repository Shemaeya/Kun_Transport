import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kun_transport/constants.dart';
import 'package:kun_transport/en/actual_order/actual_orders_en_page.dart';
import 'package:kun_transport/en/home_page_en.dart';
import 'package:kun_transport/en/login_page_en.dart';
import 'package:kun_transport/en/my_bottom_nav_bar_en.dart';
import 'package:kun_transport/pages/widget/utils.dart';
import 'package:kun_transport/screens/welcom_view.dart';
import 'package:kun_transport/service/auth_service.dart';
import 'package:provider/provider.dart';

class ContactPageEn extends StatefulWidget {
  const ContactPageEn({super.key});

  @override
  _ContactPageEnState createState() => _ContactPageEnState();
}

class _ContactPageEnState extends State<ContactPageEn> {
  late String userName;
  late String userName2;
  late String userEmail;
  late String userPhone;

  int selsctedIconIndex = 2;

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    return WillPopScope(
      onWillPop: () async => false,
      child: MultiProvider(
        providers: [
          Provider<FirebaseAuthMethods>(
            create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) => context.read<FirebaseAuthMethods>().authState,
            initialData: null,
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            // key: _key,
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: appColor,

            actions: [
              (firebaseUser != null)
                  ? IconButton(
                      icon: const Icon(
                        Icons.logout,
                      ),
                      onPressed: () {
                        showCupertinoDialog(
                            context: context, builder: createDialog);
                      },
                    )
                  : Container(),
            ],
          ),
          backgroundColor: appColor,
          body: SafeArea(
            child: (firebaseUser != null)
                ? Column(
                    children: [
                      Expanded(
                          child: Center(
                        child: Scrollbar(
                            child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(5),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40.0),
                                    border: Border.all(
                                      width: 3,
                                      color: const Color(0xFF40D876),
                                    ),
                                    image: const DecorationImage(
                                      image:
                                          AssetImage("assets/images/elel.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 30,
                                ),

                                FutureBuilder(
                                    future: _fetch(),
                                    builder: (context, snapshot) {
                                      if (firebaseUser != null) {
                                        if (snapshot.connectionState !=
                                            ConnectionState.done) {
                                          return Text(
                                            "...",
                                            style: GoogleFonts.bebasNeue(
                                              fontSize: 24,
                                              color: white,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.9,
                                            ),
                                          );
                                        }
                                        return Text(
                                          "$userName2 $userName",
                                          style: GoogleFonts.bebasNeue(
                                            fontSize: 24,
                                            color: white,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.9,
                                          ),
                                        );
                                      }
                                      return Text("");
                                    }),

                                FutureBuilder(
                                    future: _fetch(),
                                    builder: (context, snapshot) {
                                      if (firebaseUser != null) {
                                        if (snapshot.connectionState !=
                                            ConnectionState.done) {
                                          return Text(
                                            "...",
                                            style: GoogleFonts.lato(
                                              fontSize: 20,
                                              color: white,
                                              fontWeight: FontWeight.normal,
                                              letterSpacing: 1.8,
                                            ),
                                          );
                                        }
                                        return Text(
                                          userPhone,
                                          style: GoogleFonts.lato(
                                            fontSize: 20,
                                            color: white,
                                            fontWeight: FontWeight.normal,
                                            letterSpacing: 1.8,
                                          ),
                                        );
                                      }
                                      return Text("");
                                    }),

                                FutureBuilder(
                                    future: _fetch(),
                                    builder: (context, snapshot) {
                                      if (firebaseUser != null) {
                                        if (snapshot.connectionState !=
                                            ConnectionState.done) {
                                          return Text(
                                            "...",
                                            style: GoogleFonts.lato(
                                              fontSize: 20,
                                              color: white,
                                              fontWeight: FontWeight.w300,
                                              letterSpacing: 1.8,
                                            ),
                                          );
                                        }
                                        return Text(
                                          userEmail,
                                          style: GoogleFonts.lato(
                                            fontSize: 20,
                                            color: white,
                                            fontWeight: FontWeight.w300,
                                            letterSpacing: 1.8,
                                          ),
                                        );
                                      }
                                      return Text("");
                                    }),

                                const SizedBox(
                                  height: 25,
                                ),

                                //                 GestureDetector(
                                //   onTap: () {},
                                //   child: Container(
                                //     width: 200,
                                //     height: 50,
                                //     decoration: BoxDecoration(
                                //       borderRadius:BorderRadius.circular(25),
                                //       color: Colors.amber,
                                //     ),
                                //     child: Center(
                                //       child: Text(
                                //         "Editer le profile",
                                //         style:
                                //                GoogleFonts.lato(
                                //                   fontSize:20,
                                //                   color: Colors.black,
                                //                   fontWeight: FontWeight.bold
                                //                        ),
                                //                        ),
                                //     ),

                                //   )
                                // ),

                                const SizedBox(
                                  height: 100,
                                ),

                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  height: 70,
                                  color: const Color.fromARGB(255, 24, 24, 50),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const CircleAvatar(
                                          backgroundColor: Colors.pink,
                                          child: Icon(
                                            Icons.phone_iphone_outlined,
                                            color: Colors.white70,
                                            size: 30,
                                          )),
                                      // const SizedBox(width: 30,),
                                      Text(
                                        "Call the customer service",
                                        style: GoogleFonts.lato(
                                            fontSize: 20,
                                            color: white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      //  const SizedBox(width: 40,),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                            onPressed: () {
                                              Utils.openPhoneCall(
                                                  phoneNumber: "+33658882995");
                                            },
                                            icon: const Icon(
                                              Icons.navigate_next,
                                              color: white,
                                              size: 30,
                                            )),
                                      )
                                    ],
                                  ),
                                ),

                                const SizedBox(
                                  height: 10,
                                ),

                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  height: 70,
                                  color: const Color.fromARGB(255, 24, 24, 50),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const CircleAvatar(
                                          backgroundColor: Colors.blue,
                                          child: Icon(
                                            Icons.message_outlined,
                                            color: Colors.white70,
                                            size: 30,
                                          )),
                                      // const SizedBox(width: 30,),
                                      Text(
                                        "Send us a Message",
                                        style: GoogleFonts.lato(
                                            fontSize: 20,
                                            color: white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      //  const SizedBox(width: 40,),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                            onPressed: () {
                                              Utils.openSMS(
                                                  phoneNumber: "+33658882995");
                                            },
                                            icon: const Icon(
                                              Icons.navigate_next,
                                              color: white,
                                              size: 30,
                                            )),
                                      )
                                    ],
                                  ),
                                ),

                                const SizedBox(
                                  height: 10,
                                ),

                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  height: 70,
                                  color: const Color.fromARGB(255, 24, 24, 50),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const CircleAvatar(
                                          backgroundColor: Colors.green,
                                          child: Icon(
                                            Icons.mail_outline_sharp,
                                            color: Colors.white70,
                                            size: 30,
                                          )),
                                      // const SizedBox(width: 30,),
                                      Text(
                                        "Send us an email",
                                        style: GoogleFonts.lato(
                                            fontSize: 20,
                                            color: white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      //  const SizedBox(width: 40,),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                            onPressed: () {
                                              Utils.openEmail(
                                                toEmail:
                                                    "kuntransport25@gmail.com",
                                                subject: '',
                                                body: '',
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.navigate_next,
                                              color: white,
                                              size: 30,
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),

                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const WelcomView())),
                                    child: Container(
                                      width: 200,
                                      height: 50,
                                      // decoration: BoxDecoration(
                                      //   borderRadius:BorderRadius.circular(25),
                                      //   color: Colors.amber,
                                      // )
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      color:
                                          const Color.fromARGB(255, 24, 24, 50),
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 25,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                border: Border.all(
                                                  width: 1,
                                                  color:
                                                      const Color(0xFF40D876),
                                                ),
                                                image: const DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/en.png"),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 17,
                                            ),
                                            Text(
                                              "Change language",
                                              style: GoogleFonts.lato(
                                                  fontSize: 16,
                                                  color: white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            //  const SizedBox(width: 40,),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: TextButton(
                                      onPressed: () {
                                        // Call this in a function
                                        showDialog<Dialog>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                const DialogFb1());
                                      },
                                      child: const Text("Delete your account?",
                                          style:
                                              TextStyle(color: Colors.white))),
                                )
                              ],
                            ),
                          ),
                        )),
                      ))
                    ],
                  )
                : Column(
                    children: [
                      Expanded(
                          child: Center(
                        child: Scrollbar(
                            child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(5),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40.0),
                                    border: Border.all(
                                      width: 3,
                                      color: const Color(0xFF40D876),
                                    ),
                                    image: const DecorationImage(
                                      image:
                                          AssetImage("assets/images/elel.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                FutureBuilder(
                                    future: _fetch(),
                                    builder: (context, snapshot) {
                                      if (firebaseUser != null) {
                                        return Text(
                                          "$userName2 $userName",
                                          style: GoogleFonts.bebasNeue(
                                            fontSize: 24,
                                            color: white,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.9,
                                          ),
                                        );
                                      }
                                      return const Text("");
                                    }),
                                FutureBuilder(
                                    future: _fetch(),
                                    builder: (context, snapshot) {
                                      if (firebaseUser != null) {
                                        return Text(
                                          userPhone,
                                          style: GoogleFonts.lato(
                                            fontSize: 20,
                                            color: white,
                                            fontWeight: FontWeight.normal,
                                            letterSpacing: 1.8,
                                          ),
                                        );
                                      }
                                      return Text(
                                        "Please, log in",
                                        style: GoogleFonts.bebasNeue(
                                          fontSize: 24,
                                          color: white,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.9,
                                        ),
                                      );
                                    }),
                                FutureBuilder(
                                    future: _fetch(),
                                    builder: (context, snapshot) {
                                      if (firebaseUser != null) {
                                        return Text(
                                          userEmail,
                                          style: GoogleFonts.lato(
                                            fontSize: 20,
                                            color: white,
                                            fontWeight: FontWeight.w300,
                                            letterSpacing: 1.8,
                                          ),
                                        );
                                      }
                                      return const Text("");
                                    }),
                                const SizedBox(
                                  height: 25,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => LoginPageEn()));
                                    },
                                    child: Container(
                                      width: 200,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.amber,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Log in",
                                          style: GoogleFonts.lato(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )),
                                const SizedBox(
                                  height: 100,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  height: 70,
                                  color: const Color.fromARGB(255, 24, 24, 50),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const CircleAvatar(
                                          backgroundColor: Colors.pink,
                                          child: Icon(
                                            Icons.phone_iphone_outlined,
                                            color: Colors.white70,
                                            size: 30,
                                          )),
                                      // const SizedBox(width: 30,),
                                      Text(
                                        "Call customer service",
                                        style: GoogleFonts.lato(
                                            fontSize: 20,
                                            color: white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      //  const SizedBox(width: 40,),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                            onPressed: () {
                                              Utils.openPhoneCall(
                                                  phoneNumber:
                                                      "+2250789308214");
                                            },
                                            icon: const Icon(
                                              Icons.navigate_next,
                                              color: white,
                                              size: 30,
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  height: 70,
                                  color: const Color.fromARGB(255, 24, 24, 50),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const CircleAvatar(
                                          backgroundColor: Colors.blue,
                                          child: Icon(
                                            Icons.message_outlined,
                                            color: Colors.white70,
                                            size: 30,
                                          )),
                                      // const SizedBox(width: 30,),
                                      Text(
                                        "Send us a Message",
                                        style: GoogleFonts.lato(
                                            fontSize: 20,
                                            color: white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      //  const SizedBox(width: 40,),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                            onPressed: () {
                                              Utils.openSMS(phoneNumber: "");
                                            },
                                            icon: const Icon(
                                              Icons.navigate_next,
                                              color: white,
                                              size: 30,
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20),
                                  height: 70,
                                  color: const Color.fromARGB(255, 24, 24, 50),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const CircleAvatar(
                                          backgroundColor: Colors.green,
                                          child: Icon(
                                            Icons.mail_outline_sharp,
                                            color: Colors.white70,
                                            size: 30,
                                          )),
                                      // const SizedBox(width: 30,),
                                      Text(
                                        "Send us an email",
                                        style: GoogleFonts.lato(
                                            fontSize: 20,
                                            color: white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      //  const SizedBox(width: 40,),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                            onPressed: () {
                                              Utils.openEmail(
                                                toEmail:
                                                    "kuntransport25@gmail.com",
                                                subject: '',
                                                body: '',
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.navigate_next,
                                              color: white,
                                              size: 30,
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: GestureDetector(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const WelcomView())),
                                    child: Container(
                                      width: 200,
                                      height: 50,
                                      // decoration: BoxDecoration(
                                      //   borderRadius:BorderRadius.circular(25),
                                      //   color: Colors.amber,
                                      // )
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      color:
                                          const Color.fromARGB(255, 24, 24, 50),
                                      child: Center(
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 23,
                                              height: 23,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                border: Border.all(
                                                  width: 1,
                                                  color:
                                                      const Color(0xFF40D876),
                                                ),
                                                image: const DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/en.png"),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 17,
                                            ),
                                            Text(
                                              "Change language",
                                              style: GoogleFonts.lato(
                                                  fontSize: 15,
                                                  color: white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            //  const SizedBox(width: 40,),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                      ))
                    ],
                  ),
          ),
         ),
      ),
    );
  }

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        userName = ds['firstName'];
        userName2 = ds['lastName'];
        userEmail = ds['email'];
        userPhone = ds['number'];
      }).catchError((e) {});
    }
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  Widget createDialog(BuildContext context) => CupertinoAlertDialog(
        title: const Text('Would you really like to disconnect?'),
        actions: [
          CupertinoDialogAction(
            onPressed: () => _auth.signOut().then(
              (value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyBottomNavBarEn(),
                  ),
                );
              },
            ),
            child: const Text('Yes'),
          ),
          CupertinoDialogAction(
              onPressed: () => Navigator.pop(context), child: const Text('No'))
        ],
      );
}

class DialogFb1 extends StatelessWidget {
  const DialogFb1({Key? key}) : super(key: key);
  final primaryColor = const Color(0xff4338CA);
  final accentColor = const Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: MediaQuery.of(context).size.width / 0.2,
        height: MediaQuery.of(context).size.height / 3,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(12, 26),
                  blurRadius: 50,
                  spreadRadius: 0,
                  color: Colors.grey.withOpacity(.1)),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/undraw_Warning_re_eoyh.png",
              height: 120,
              width: 120,
            ),
            const Center(
              child: Text("Delete your account?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 3.5,
            ),
            const Text(
                "This action is irreversible and will result in \n the automatic and immediate deletion of all information \nrelated to this account.",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w300)),
            const SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SimpleBtn1(
                    text: "Cancel",
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                SimpleBtn1(
                  text: "Delete",
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.currentUser!.delete();
                      await FirebaseAuth.instance.signOut();
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const MyBottomNavBarEn()));
                    } on FirebaseAuthException catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(e.message!.toString()),
                          duration: const Duration(milliseconds: 800),
                          backgroundColor: Theme.of(context).primaryColor));
                      // Displaying the error message
                      // if an error of requires-recent-login is thrown, make sure to log
                      // in user again and then delete account.
                    }
                    // context.read<FirebaseAuthMethods>()
                    // .deleteAccount(context);
                  },
                  invertedColors: true,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SimpleBtn1 extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool invertedColors;
  SimpleBtn1(
      {required this.text,
      required this.onPressed,
      this.invertedColors = false,
      Key? key})
      : super(key: key);
  final primaryColor = secondApp;
  final accentColor = const Color(0xffffffff);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            alignment: Alignment.center,
            side: MaterialStateProperty.all(
                BorderSide(width: 1, color: primaryColor)),
            padding: MaterialStateProperty.all(
                const EdgeInsets.only(right: 25, left: 25, top: 0, bottom: 0)),
            backgroundColor: MaterialStateProperty.all(
                invertedColors ? accentColor : primaryColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            )),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              color: invertedColors ? primaryColor : accentColor, fontSize: 16),
        ));
  }
}
