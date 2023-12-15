import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:kun_transport/en/formules/quick_race.dart';
import 'package:kun_transport/pages/widget/showSnackBar.dart';
import 'package:random_string/random_string.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;

import '../../../service/notification_services.dart';
import '../../../widget/button.dart';
import '../../../constants.dart';
import '../../../widget/input_field.dart';

class DisneyPageEn extends StatefulWidget {
  const DisneyPageEn({super.key});

  @override
  State<DisneyPageEn> createState() => _DisneyPageEnState();
}

class _DisneyPageEnState extends State<DisneyPageEn> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  // final TextEditingController _endTimeController = TextEditingController();
  var same = randomAlphaNumeric(6);
  late String userName;
  late String userName2;
  late String userEmail;
  late String userPhone;
  late String uid;
  late String tokenAdmin;

  DateTime _selectedDate = DateTime.now();
  // String _endTime = "9:30 PM";
  // String _startTime = DateFormat("hh:mm a").format(DateTime.now());
  // int _selectedRemind = 5;
  List<int> remindList = [
    800,
    400,
  ];
  String _selectedTime = "";

  List<String> repeatList = [
    "PARIS",
    "AÉROPORT ORLY",
    "AÉROPORT CHARLES DE GAULES",
    "AÉROPORT DE BEAUVAIS",
  ];

  // String repeatList = 0;

  int _selectedColor = 0;
  var notifyHelper;

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    notifyHelper.isTokenRefresh();
    notifyHelper.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('device Token');
        print(value);
      }
    });
    token;
  }

  Future<String?> token = FirebaseMessaging.instance.getToken();

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    _dateController.dispose();
    _priceController.dispose();
    // _endTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: _fetchUser(),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 60.0,
            ),
            child: FutureBuilder(
              future: _fetch(),
              builder: (context, snapshot) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: appColor,
                                ),
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const QuickRacePage())),
                              ),
                              Text(
                                "Quick ",
                                style: GoogleFonts.bebasNeue(
                                  fontSize: 32,
                                  color: appColor,
                                  letterSpacing: 1.8,
                                ),
                              ),
                              Text(
                                "Race",
                                style: GoogleFonts.bebasNeue(
                                  fontSize: 32,
                                  color: const Color(0xFF40D876),
                                  letterSpacing: 1.8,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.0),
                              border: Border.all(
                                width: 3,
                                color: const Color(0xFF40D876),
                              ),
                              image: const DecorationImage(
                                image: AssetImage("assets/images/elel.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 30, left: 20, right: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              "Order your car ",
                              style: GoogleFonts.lato(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                //letterSpacing: 1.9,
                                color: appColor,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            // Text(
                            //   "Votre lieux de départ est: ",
                            //   style: GoogleFonts.lato(
                            //     fontSize: 23,
                            //     fontWeight: FontWeight.bold,
                            //     //letterSpacing: 1.9,
                            //     color: appColor,
                            //   ),
                            // ),
                            Container(
                              width: 180,
                              margin: const EdgeInsets.only(left: 15),
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFD4EEF3),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    "assets/images/d.png",
                                    height: 100,
                                    width: 100,
                                  ),
                                  // const SizedBox(
                                  //   height: 5,
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        "Disney",
                                        style: GoogleFonts.laila(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          // color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // MyInputField(
                            //   title: "Date",
                            //   hint: DateFormat.yMd().format(_selectedDate),
                            //   controller: _dateController,
                            //   widget: IconButton(
                            //     icon: const Icon(
                            //       Icons.calendar_today_outlined,
                            //       color: Colors.grey,
                            //     ),
                            //     onPressed: () {
                            //       _getDateFromUser();
                            //     },
                            //   ),
                            // ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              _selectedTime,
                            ),
                            MyInputField3(
                              title: "Where are you going?",
                              hint: _selectedTime,
                              widget: DropdownButton(
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.grey,
                                ),
                                iconSize: 32,
                                elevation: 4,
                                style: GoogleFonts.lato(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: appColor,
                                ),
                                underline: Container(
                                  height: 20,
                                ),
                                items: repeatList.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          style: const TextStyle(
                                              color: Colors.grey)));
                                }).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    _selectedTime = value!;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            MyInputField2(
                              title: "Price:",
                              hint: _selectedTime == ""
                                  ? "0€"
                                  : _selectedTime == "PARIS"
                                      ? "100€"
                                      : _selectedTime == "AÉROPORT ORLY"
                                          ? "110€"
                                          : _selectedTime ==
                                                  "AÉROPORT CHARLES DE GAULES"
                                              ? "120€"
                                              : "200€",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // Column(
                            //   children: [
                            //     Align(
                            //       alignment: Alignment.topLeft,
                            //       child: Text(
                            //         "NB: ",
                            //         style: GoogleFonts.lato(
                            //           fontSize: 19,
                            //           fontWeight: FontWeight.bold,
                            //           color: Colors.black,
                            //         ),
                            //       ),
                            //     ),
                            //     const SizedBox(
                            //       height: 8,
                            //     ),
                            //     Text(
                            //       "COURSE DANS PARIS OU BANLIEUE PROCHE (ATTENTE SUR PLACE AU LIEU DE DESTINATION ) : 60€ (+ FRAIS D’ATTENTE 10€ PAR/H)",
                            //       style: GoogleFonts.lato(
                            //         fontSize: 13,
                            //         fontWeight: FontWeight.w300,
                            //         color: Colors.black,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            // _colorPalette(),
                            MyInputField0(
                              title: "code:",
                              hint: same,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            MyButton1(
                              label: "Oder",
                              onTap: () => _validateDate(),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _validateDate() {
    if (_selectedTime == "") {
      showNotification(
        context,
        "Please enter your destination!",
      );
      // Get.snackbar("Requis", "Tout les champs sont requis!",
      // snackPosition: SnackPosition.BOTTOM,
      // backgroundColor: appColor,
      // icon: const Icon(Icons.warning_amber_rounded)
      // );
    } else {
      _cmd();
    }
  }

  _cmd() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      var currentUser = auth.currentUser;
      if (currentUser != null) {
        await notifyHelper.getDeviceToken().then((value) async {
        FirebaseFirestore.instance
            .collection("cmd")
            .doc("ePJw8GQh1egsiuJA8IaL")
            .collection("courseRapide")
            .doc(same)
            .set({
          "depart": "Dismeyland",
          "destination": _selectedTime,
          "price": _selectedTime == ""
              ? "0€"
              : _selectedTime == "PARIS"
                  ? "100€"
                  : _selectedTime == "AÉROPORT ORLY"
                      ? "110€"
                      : _selectedTime == "AÉROPORT CHARLES DE GAULES"
                          ? "120€"
                          : "200€",
          "firstName": userName,
          "lastName": userName2,
          "email": userEmail,
          "number": userPhone,
          "uid": uid,
          "formule": 'Course Rapide',
          "date": DateFormat.yMMMMd().format(
            DateTime.now(),
          ),
          "same": same,
          "etat": "En Attente",
          "addtime": DateTime.now(),
          "token": value.toString(),
        }).asStream();
        });
      }
    } catch (error) {
      var message = "Veuillez vérifier votre connexion Internet";

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message.toString()),
        duration: const Duration(milliseconds: 600),
        backgroundColor: Theme.of(context).primaryColor,
      ));
    } 
    // await notifyHelper.getDeviceToken().then((value) async {
    //       await FirebaseFirestore.instance
    //           .collection("cmd")
    //           .doc("ePJw8GQh1egsiuJA8IaL")
    //           .collection("courseRapide")
    //           .doc(same)
    //           .update({
    //         "token": value,
    //       });
    //       print:('valeur $value');
    //     });
    Navigator.of(context).pop();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const QuickRacePage()));

    notifyHelper.displayNotification(
      title: "Quick Race",
      body: "Your order is waiting for validation",
    );

    // <Notification send to admin>
    notifyHelper.getDeviceToken().then((value) async {
      const postUrl = 'https://fcm.googleapis.com/fcm/send';

      final headers = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'key=AAAAz3te1S0:APA91bFXzYPGPY6qC5w2nCyeSn_QMsJOWkh8WLjfNliTuTZuCsln57ce9mJBFYiw5g-7Q3zpSQzI2A8zK4nnO8eM-Nk9jUxJphAKdjmatxM57ouMCUg6dumGXpft1gxQfmOmTN4Pt7QR', // Replace with your FCM server key
      };

      final message = {
        'to': tokenAdmin.toString(),
        'priority': 'high',
        'notification': {
          'title': 'Course Rapide(en)',
          'body': 'Une course depart Disneyland en attente de validation',
        },
      };

      final response = await http.post(
        Uri.parse(postUrl),
        headers: headers,
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        print('Push message sent successfully. to $tokenAdmin');
      } else {
        print('Error sending push message: ${response.statusCode}');
      }
    });
    // </Notification send to admin>
  }

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('admin')
          .doc("token")
          .get()
          .then((ds) {
        // userName = ds['firstName'];
        // userName2 = ds['lastName'];
        // userEmail = ds['email'];
        // userPhone = ds['number'];
        tokenAdmin = ds['token'];
      }).catchError((e) {});
    }
  }

  _fetchUser() async {
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
        uid = ds['uid'];
      }).catchError((e) {});
    }
  }

  // _showTimePicker() {
  //   return showTimePicker(
  //     initialEntryMode: TimePickerEntryMode.input,
  //     context: context,
  //     initialTime: TimeOfDay(
  //       hour: int.parse(_startTime.split(":")[0]),
  //       minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
  //     ),
  //   );
  // }
}
