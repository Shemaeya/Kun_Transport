import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kun_transport/en/contacts/contact_page_en.dart';
import 'package:kun_transport/en/home_page_en.dart';
import 'package:kun_transport/screens/home_page.dart';
import 'package:kun_transport/service/notification_services.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class ActualOrderEnPage extends StatefulWidget {
  const ActualOrderEnPage({super.key});

  @override
  _ActualOrderEnPageState createState() => _ActualOrderEnPageState();
}

class _ActualOrderEnPageState extends State<ActualOrderEnPage> {
  int selsctedIconIndex = 0;
  var notifyHelper;

  late String token;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  _getBGClr(String no) {
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

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 2,
          title: const Text(
            'Current Ordering',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          backgroundColor: appColor,
        ),
        backgroundColor: appColor,
        body: SafeArea(
          child: (firebaseUser != null)
              ? StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("cmd")
                      .doc("ePJw8GQh1egsiuJA8IaL")
                      .collection("courseRapide")
                      .where('uid',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Quelque chose ne va pas"),
                      );
                    }

                    return ListView.builder(
                        itemCount: snapshot.data == null
                            ? 0
                            : snapshot.data!.docs.length,
                        itemBuilder: (_, index) {
                          DocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
                          if (documentSnapshot['etat'] == 'Course Annulée') {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              child: SlideAnimation(
                                child: FadeInAnimation(
                                  child: Slidable(
                                    endActionPane: ActionPane(
                                      motion: const StretchMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: ((context) async {
                                            await FirebaseFirestore.instance
                                                .collection("cmd")
                                                .doc("ePJw8GQh1egsiuJA8IaL")
                                                .collection("courseRapide")
                                                .doc(documentSnapshot.id)
                                                .delete();
                                          }),
                                          backgroundColor: Colors.red,
                                          icon: Icons.delete_forever,
                                          label: 'delete',
                                        )
                                      ],
                                    ),
                                    child: Card(
                                      elevation: 5,
                                      child: ListTile(
                                        title: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                height: 25,
                                                width: 150,
                                                color: _getBGClr(
                                                    documentSnapshot["etat"] ??
                                                        ''),
                                                child: Center(
                                                  child: Text(
                                                    "${documentSnapshot['etat']} ",
                                                    style: const TextStyle(
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                  "Starting: ${documentSnapshot['depart']} ",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                  )),
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                  "Destination: ${documentSnapshot['destination']} ",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                  )),
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "Price: ${documentSnapshot['price']} ",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  color: appColor,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        subtitle: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            "${documentSnapshot['date']}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black,
                                                fontSize: 13),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              child: SlideAnimation(
                                child: FadeInAnimation(
                                  child: Slidable(
                                    endActionPane: ActionPane(
                                      motion: const StretchMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: ((context) async {
                                            try {
                                              await FirebaseFirestore.instance
                                                  .collection("cmd")
                                                  .doc("ePJw8GQh1egsiuJA8IaL")
                                                  .collection("courseRapide")
                                                  .doc(documentSnapshot.id)
                                                  .update({
                                                "etat": 'Course Annulée',
                                              }).asStream();
                                            } catch (error) {
                                              var message =
                                                  "Please check your Internet connection";

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content:
                                                    Text(message.toString()),
                                                duration: const Duration(
                                                    milliseconds: 600),
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                              ));
                                            }
                                            notifyHelper.displayNotification(
                                              title: "Quick Race",
                                              body:
                                                  "Your order has been cancelled",
                                            );
                                            notifyHelper.sendPushMessage(
                                              deviceToken: token,
                                              title: 'Course Rapide',
                                              body:
                                                  'Une commande a été annulée',
                                            );
                                          }),
                                          backgroundColor: Colors.red,
                                          icon: Icons.delete_forever,
                                          label: 'Cancel',
                                        )
                                      ],
                                    ),
                                    child: Card(
                                      elevation: 5,
                                      child: ListTile(
                                        title: Column(
                                          children: [
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: Container(
                                                height: 25,
                                                width: 150,
                                                color: _getBGClr(
                                                    documentSnapshot["etat"] ??
                                                        ''),
                                                child: Center(
                                                  child: Text(
                                                    "${documentSnapshot['etat']} ",
                                                    style: const TextStyle(
                                                      // fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                  "Starting: ${documentSnapshot['depart']} ",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                  )),
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                  "Destination: ${documentSnapshot['destination']} ",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                  )),
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "Price: ${documentSnapshot['price']} ",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.normal,
                                                  color: appColor,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        subtitle: Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            "${documentSnapshot['date']}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black,
                                                fontSize: 13),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        });
                  },
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Column(
                    children: const [
                      Text(''),
                      Center(
                          child: Text(
                        'You are not connected',
                        style: TextStyle(color: white, fontSize: 20),
                      )),
                    ],
                  ),
                ),
        ),
        ),
    );
  }
}
