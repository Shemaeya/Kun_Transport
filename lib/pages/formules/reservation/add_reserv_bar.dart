import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:kun_transport/pages/formules/longue_distance.dart';
import 'package:kun_transport/pages/formules/reservations.dart';
import 'package:random_string/random_string.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;

import '../../../service/notification_services.dart';
import '../../../widget/button.dart';
import '../../../constants.dart';
import '../../../widget/input_field.dart';
import '../../widget/showSnackBar.dart';

class AddTaskReservPage extends StatefulWidget {
  const AddTaskReservPage({super.key});

  @override
  State<AddTaskReservPage> createState() => _AddTaskReservPageState();
}

class _AddTaskReservPageState extends State<AddTaskReservPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  // final TextEditingController _endTimeController = TextEditingController();

  late String userName;
  late String userName2;
  late String userEmail;
  late String userPhone;
  late String uid;
  late String tokenAdmin;
  var same = randomAlphaNumeric(10);

  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now());
  // int _selectedRemind = 5;
  List<int> remindList = [
    800,
    400,
  ];
  String _selectedTime = "";

  List<String> repeatList = [
    "SEMAINE",
    "MOIS",
  ];

  // String repeatList = 0;

  int _selectedColor = 0;
  var notifyHelper;
  String mtoken = "";

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
  }

  String token1 =
      'cC6LyrfoTuyNzdGEmSs-hl:APA91bF8DpNCJVBIPW6XGep8ZRyeOwx86wugWkuZGx4sdUd-xB7a2XPxc55c03gMsGylTTCT0Bh5Jb-qraZVWRIv1mlbUiizXNX6hyUuQ5y--Pj2C4KgecD9KG7VU0JW6GaiciBkX6xi';

  // void getToken() async {
  //   await FirebaseMessaging.instance.getToken().then((token) {
  //     setState(() {
  //       mtoken = token!;
  //       print("My token is $mtoken ");
  //     });
  //     saveToken(token!);
  //   });
  // }

  // void saveToken(String token) async {
  //   await FirebaseFirestore.instance.collection("UserTokens").doc("user1").set({
  //     'token': token,
  //   });
  // }

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
            return SingleChildScrollView(
              child: FutureBuilder(
                  future: _fetch(),
                  builder: (context, snapshot) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 60.0,
                      ),
                      child: Column(
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
                                              builder: (_) =>
                                                  const ReservationPage())),
                                    ),
                                    Text(
                                      "Réservation ",
                                      style: GoogleFonts.bebasNeue(
                                        fontSize: 32,
                                        color: appColor,
                                        letterSpacing: 1.8,
                                      ),
                                    ),
                                    Text(
                                      "Direct",
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
                                      image:
                                          AssetImage("assets/images/elel.png"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 30, left: 20, right: 20),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Text(
                                    "RÉSERVEZ VOTRE VOITURE ",
                                    style: GoogleFonts.lato(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      //letterSpacing: 1.9,
                                      color: appColor,
                                    ),
                                  ),

                                  // Text(
                                  //   "PARIS OU BANLIEUE PROCHE",
                                  //   style: GoogleFonts.lato(
                                  //     fontSize: 23,
                                  //     fontWeight: FontWeight.bold,
                                  //     //letterSpacing: 1.9,
                                  //     color: appColor,
                                  //   ),
                                  // ),

                                  MyInputField(
                                    hint: 'Saisissez votre titre',
                                    title: 'Titre',
                                    controller: _titleController,
                                  ),

                                  MyInputField(
                                    hint: 'Saisissez une note',
                                    title: 'Note',
                                    controller: _noteController,
                                  ),

                                  MyInputField(
                                    title: "Date",
                                    hint:
                                        DateFormat.yMd().format(_selectedDate),
                                    controller: _dateController,
                                    widget: IconButton(
                                      icon: const Icon(
                                        Icons.calendar_today_outlined,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        _getDateFromUser();
                                      },
                                    ),
                                  ),
                                  MyInputField(
                                    title: "Temps",
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
                                      items: repeatList
                                          .map<DropdownMenuItem<String>>(
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

                                  // Row(
                                  //   children: [
                                  // Expanded(
                                  // child:
                                  MyInputField(
                                    title: 'Heure de départ',
                                    hint: _startTime,
                                    widget: IconButton(
                                        icon: const Icon(
                                          Icons.access_time_rounded,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {
                                          _getTimeFromUser(isStartTime: true);
                                        }),
                                  ),
                                  // ),

                                  // const SizedBox(width: 12,),

                                  //    Expanded(
                                  //       child: MyInputField(
                                  //       title: 'Heure de fin',
                                  //       hint: _endTime,
                                  //       controller: _endTimeController,
                                  //       widget: IconButton(
                                  //         icon: const Icon(
                                  //           Icons.access_time_rounded,
                                  //           color: Colors.grey,),
                                  //           onPressed: () {
                                  //              _getTimeFromUser(isStartTime: false);
                                  //           }),
                                  //       ),
                                  //       ),
                                  //   ],

                                  // ),

                                  const SizedBox(
                                    height: 10,
                                  ),
                                  MyInputField1(
                                    title: "Prix:",
                                    hint: _selectedTime == ""
                                        ? "0€"
                                        : _selectedTime == "SEMAINE"
                                            ? "1500€"
                                            : "6000€",
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "NB: ",
                                          style: GoogleFonts.lato(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        "COURSE DANS PARIS OU BANLIEUE PROCHE (ATTENTE SUR PLACE AU LIEU DE DESTINATION ) : 60€ (+ FRAIS D’ATTENTE 10€ PAR/H)",
                                        style: GoogleFonts.lato(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  MyInputField0(
                                    title: "code:",
                                    hint: same,
                                  ),
                                  _colorPalette(),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  MyButton1(
                                      label: "Commander",
                                      onTap: () {
                                        _validateDate();
                                      })
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            );
          }),
    );
  }

  _colorPalette() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Couleur",
          style: GoogleFonts.lato(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Wrap(
          children: List<Widget>.generate(3, (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index == 0
                      ? bluishClr
                      : index == 1
                          ? pinkClr
                          : secondApp,
                  child: _selectedColor == index
                      ? const Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 16,
                        )
                      : Container(),
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  _validateDate() {
    var _dating = DateFormat.yMd().format(_selectedDate);
    if (_titleController.text.isEmpty &&
        _noteController.text.isEmpty &&
        _dateController.text.isEmpty &&
        _selectedTime == "") {
      showNotification(
        context,
        "Tout les champs sont requis !",
      );
      // Get.snackbar("Requis", "Tout les champs sont requis!",
      // snackPosition: SnackPosition.BOTTOM,
      // backgroundColor: appColor,
      // icon: const Icon(Icons.warning_amber_rounded)
      // );
    } else if (_titleController.text.isEmpty) {
      showNotification(
        context,
        "Le champ titre est vide ",
      );
    } else if (_noteController.text.isEmpty) {
      showNotification(
        context,
        "Le champ note est vide ",
      );
    } else if (_selectedTime == "") {
      showNotification(
        context,
        "Veuillez choisir votre temps",
      );
//  }else if (_startTimeController.text.isEmpty){
//   showNotification( context, "Le champ heure de départ est vide",);
//  }else if (_endTimeController.text.isEmpty){
//   showNotification( context, "Le champ heure de fin est vide",);
    } else {
      _cmd();
    }
  }

  // _Cmd() async {
  //   try {
  //     final FirebaseAuth auth = FirebaseAuth.instance;
  //     var currentUser = auth.currentUser;
  //     if (currentUser != null) {
  //       FirebaseFirestore.instance
  //           .collection("users")
  //           .doc(currentUser.uid)
  //           .collection("reservation")
  //           .doc(same)
  //           .set({
  //         "title": _titleController.text,
  //         "note": _noteController.text,
  //         "date": DateFormat.yMd().format(_selectedDate),
  //         "time": _selectedTime,
  //         "price": _selectedTime == ""
  //             ? "0€"
  //             : _selectedTime == "SEMAINE"
  //                 ? "4800€"
  //                 : "19200€",
  //         "color": _selectedColor,
  //         "startTime": _startTime,
  //         "same": same,
  //         "etat": "En Attente",
  //       }).asStream();
  //     }
  //   } catch (error) {
  //     var message = "Veuillez vérifier votre connexion Internet";

  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(message.toString()),
  //       duration: const Duration(milliseconds: 600),
  //       backgroundColor: Theme.of(context).primaryColor,
  //     ));
  //   }
  //   _course();
  // }

  _cmd() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      var currentUser = auth.currentUser;
      if (currentUser != null) {
         await notifyHelper.getDeviceToken().then((value) async {
        FirebaseFirestore.instance
            .collection("cmd")
            .doc("ePJw8GQh1egsiuJA8IaL")
            .collection("reservation")
            .doc(same)
            .set({
          "title": _titleController.text,
          "note": _noteController.text,
          "color": _selectedColor,
          "date": DateFormat.yMd().format(_selectedDate),
          "time": _selectedTime,
          "price": _selectedTime == ""
              ? "0€"
              : _selectedTime == "SEMAINE"
                  ? "1500€"
                  : "6000€",
          "startTime": _startTime,
          "firstName": userName,
          "lastName": userName2,
          "email": userEmail,
          "number": userPhone,
          "formule": 'Résevation Direct',
          "same": same,
          "uid": uid,
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
    Navigator.of(context).pop();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ReservationPage()));

    //User notification
    notifyHelper.displayNotification(
      title: "Réservations Directes",
      body: "Votre commande est en attente de validation ",
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
          'title': 'Réservations Directes',
          'body': 'Vous venez de reçevoir une réservation',
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

    // notifyHelper.scheduledNotification();
    // setState(() {});
    //pop the loarding circle
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print("it's null or something is wrong");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();

    String _formatedTime = pickedTime.format(context);

    if (pickedTime == null) {
      print("Time canceld");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(_startTime.split(":")[0]),
        minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
      ),
    );
  }

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('admin')
          .doc("token")
          .get()
          .then((value) {
        // userName = ds['firstName'];
        // userName2 = ds['lastName'];
        // userEmail = ds['email'];
        // userPhone = ds['number'];
        tokenAdmin = value['token'];
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
}
