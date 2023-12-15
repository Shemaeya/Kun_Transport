import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kun_transport/pages/formules/reservation/add_reserv_bar.dart';
import 'package:kun_transport/screens/my_bottom_nav_bar.dart';
import 'package:kun_transport/service/notification_services.dart';

import '../../constants.dart';
import '../../widget/button.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final List reservation = [];
  DateTime _selectedDate = DateTime.now();
  var notifyHelper;
  late String token;

  final _firestoreInstance = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    // _controller = CalendarController();
    fetchProducts();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  _getBGCl(String no) {
    switch (no) {
      case 'Course Terminée':
        return bluishClr;
      case 'En Attente':
        return orangeClr;
      case 'Course Annulée':
        return redClr;
      case 'Refusé':
        return redClr;
      case 'En Cours':
        return greenClr;
      case 'Validé':
        return greenClr;

      default:
        return black;
    }
  }

  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance
        .collection("commande")
        .doc(auth.currentUser!.email)
        .collection("reservation")
        .get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        reservation.add({
          "title": qn.docs[i]["title"],
          "note": qn.docs[i]["note"],
          "date": qn.docs[i]["date"],
          "time": qn.docs[i]["time"],
          "startTime": qn.docs[i]["startTime"],
          "price": qn.docs[i]["price"],
          "color": qn.docs[i]["color"],
        });
      }
    });

    return qn.docs;
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return secondApp;
      default:
        return bluishClr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColor,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: appColor,
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const MyBottomNavBar())),
              ),
            ],
          ),
          title: Row(children: [
            Text(
              "Réservations ",
              style: GoogleFonts.bebasNeue(
                fontSize: 27,
                color: Colors.white,
                letterSpacing: 1.8,
              ),
            ),
            Text(
              "Directes",
              style: GoogleFonts.bebasNeue(
                fontSize: 27,
                color: const Color(0xFF40D876),
                letterSpacing: 1.8,
              ),
            ),
          ]),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
          ]),
      body: FutureBuilder(
        future: _fetch(),
        builder: (context, snapshot) {
          return Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        left: 20,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: Text(
                          DateFormat.yMMMMd().format(
                            DateTime.now(),
                          ),
                          style: GoogleFonts.lato(
                              fontSize: 18,
                              color: Colors.grey[100],
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Aujourd'hui",
                                style: GoogleFonts.lato(
                                    color: white,
                                    fontSize: 27,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          MyButton3(
                              label: "+ Commander",
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const AddTaskReservPage())))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: DatePicker(
                        DateTime.now(),
                        height: 100,
                        width: 80,
                        initialSelectedDate: DateTime.now(),
                        selectionColor: secondApp,
                        selectedTextColor: Colors.white,
                        deactivatedColor: Colors.white,
                        dateTextStyle: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                        onDateChange: (date) {
                          setState(() {
                            _selectedDate = date;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Builder(
                    builder: (context) {
                      return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("cmd")
                            .doc("ePJw8GQh1egsiuJA8IaL")
                            .collection("reservation")
                            .where('uid',
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text("Something is wrong"),
                            );
                          }

                          return ListView.builder(
                            itemCount: snapshot.data == null
                                ? 0
                                : snapshot.data!.docs.length,
                            itemBuilder: (_, index) {
                              DocumentSnapshot documentSnapshot =
                                  snapshot.data!.docs[index];
                              // var item = commande[index];
                              if (documentSnapshot['date'] ==
                                  DateFormat.yMd().format(_selectedDate)) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  child: SlideAnimation(
                                    child: FadeInAnimation(
                                      child: Slidable(
                                        // startActionPane: ActionPane(
                                        //   motion: const StretchMotion(),
                                        //   children: [
                                        //     SlidableAction(
                                        //       onPressed: ((context) async {
                                        //         await FirebaseFirestore.instance
                                        //             .collection("course")
                                        //             .doc("ePJw8GQh1egsiuJA8IaL")
                                        //             .collection("reservation")
                                        //             .doc(documentSnapshot.id)
                                        //             .update({
                                        //           "etat": 'Course Terminée',
                                        //         }).asStream();
                                        //         await FirebaseFirestore.instance
                                        //             .collection("commande")
                                        //             .doc(FirebaseAuth.instance
                                        //                 .currentUser!.email)
                                        //             .collection("all")
                                        //             .doc(documentSnapshot.id)
                                        //             .update({
                                        //           "etat": 'Course Terminée',
                                        //         }).asStream();
                                        //         FirebaseFirestore.instance
                                        //             .collection("commande")
                                        //             .doc(FirebaseAuth.instance
                                        //                 .currentUser!.email)
                                        //             .collection("reservation")
                                        //             .doc(documentSnapshot.id)
                                        //             .delete();
                                        //       }),
                                        //       backgroundColor: Colors.blue,
                                        //       icon: Icons.motion_photos_auto,
                                        //       label: 'Terminer',
                                        //     ),
                                        //   ],
                                        // ),

                                        endActionPane: ActionPane(
                                          motion: const StretchMotion(),
                                          children: [
                                            SlidableAction(
                                              onPressed: ((context) async {
                                                await FirebaseFirestore.instance
                                                    .collection("cmd")
                                                    .doc("ePJw8GQh1egsiuJA8IaL")
                                                    .collection("reservation")
                                                    .doc(documentSnapshot.id)
                                                    .update({
                                                  "etat": 'Course Annulée',
                                                }).asStream();

                                                notifyHelper
                                                    .displayNotification(
                                                  title:
                                                      "Réservations Directes",
                                                  body:
                                                      "Votre commande a été annulée",
                                                );
                                                notifyHelper.sendPushMessage(
                                                  deviceToken: token,
                                                  title:
                                                      'Réservations Directes',
                                                  body:
                                                      'Une commande a été annulée',
                                                );
                                              }),
                                              backgroundColor: Colors.red,
                                              icon: Icons.delete_forever,
                                              label: 'Annuler',
                                            )
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                // Navigator.push(
                                                //     context,
                                                //     MaterialPageRoute(
                                                //         builder: (_) =>
                                                //             showBottomSheet(
                                                //                 documentSnapshot)));
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                margin: const EdgeInsets.only(
                                                    bottom: 12),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  //  width: SizeConfig.screenWidth * 0.78,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    color: _getBGClr(
                                                        documentSnapshot[
                                                                "color"] ??
                                                            0),
                                                  ),
                                                  child: Row(children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: Container(
                                                              height: 20,
                                                              width: 150,
                                                              color: white,
                                                              child: Center(
                                                                child: Text(
                                                                  documentSnapshot[
                                                                          'etat'] ??
                                                                      "",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    color: _getBGCl(
                                                                        documentSnapshot["etat"] ??
                                                                            ""),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            documentSnapshot[
                                                                    'title'] ??
                                                                "",
                                                            style: GoogleFonts
                                                                .bebasNeue(
                                                              textStyle: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  letterSpacing:
                                                                      1.9,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 12,
                                                          ),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .access_time_rounded,
                                                                color: Colors
                                                                    .grey[200],
                                                                size: 18,
                                                              ),
                                                              const SizedBox(
                                                                  width: 4),
                                                              Text(
                                                                "${documentSnapshot['date']}",
                                                                style:
                                                                    GoogleFonts
                                                                        .lato(
                                                                  textStyle: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                              .grey[
                                                                          100]),
                                                                ),
                                                              ),
                                                              Text(
                                                                "  à  ${documentSnapshot['startTime']}",
                                                                style:
                                                                    GoogleFonts
                                                                        .lato(
                                                                  textStyle: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                              .grey[
                                                                          100]),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  width: 12),
                                                              Text(
                                                                "${documentSnapshot['price']}",
                                                                style:
                                                                    GoogleFonts
                                                                        .lato(
                                                                  textStyle: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                              .grey[
                                                                          100]),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 12),
                                                          Text(
                                                            documentSnapshot[
                                                                    'note'] ??
                                                                "",
                                                            style: GoogleFonts
                                                                .lato(
                                                              textStyle: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                          .grey[
                                                                      100]),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10),
                                                      height: 60,
                                                      width: 0.5,
                                                      color: Colors.grey[200]!
                                                          .withOpacity(0.7),
                                                    ),
                                                    RotatedBox(
                                                      quarterTurns: 3,
                                                      child: Text(
                                                        documentSnapshot[
                                                                'time'] ??
                                                            "",
                                                        style: GoogleFonts.lato(
                                                          textStyle:
                                                              const TextStyle(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
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
          .then((ds) {
        // userName = ds['firstName'];
        // userName2 = ds['lastName'];
        // userEmail = ds['email'];
        // userPhone = ds['number'];
        token = ds['token'];
      }).catchError((e) {});
    }
  }
}

class showBottomSheet extends StatefulWidget {
  var item;
  showBottomSheet(this.item, {super.key});

  @override
  _showBottomSheetState createState() => _showBottomSheetState();
}

class _showBottomSheetState extends State<showBottomSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
                child: Column(
              children: [
                // SizedBox(
                //   height: size.width,
                //   child: Image.network(
                //     widget.item['image'].toString(),
                //     fit: BoxFit.cover,
                //   ),
                // ),

                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFecf0f1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  padding: const EdgeInsets.all(17),
                  height: 1000,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.item['title'].toString(),
                            style: const TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(width: 16.0),
                          Center(
                            child: Text(widget.item['price'].toString(),
                                style: GoogleFonts.lato(
                                  fontSize: 25,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                      Text(
                        widget.item['time'].toString(),
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        widget.item['date'].toString(),
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(
                        height: 1,
                      ),
                      const SizedBox(height: 16),
                      const Text('Note',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700)),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(widget.item['note'].toString(),
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey[600],
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return AppBar(
      // key: _key,
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 14, 9, 9),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          }),
    );
  }
}
