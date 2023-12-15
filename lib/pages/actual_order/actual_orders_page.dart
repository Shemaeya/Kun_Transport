import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:kun_transport/service/notification_services.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class ActualOrderPage extends StatefulWidget {
  const ActualOrderPage({super.key});

  @override
  _ActualOrderPageState createState() => _ActualOrderPageState();
}

class _ActualOrderPageState extends State<ActualOrderPage> {
  var notifyHelper;
  int selsctedIconIndex = 0;
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
            'Commande Actuelle',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
          backgroundColor: appColor,
        ),
        backgroundColor: appColor,
        body: FutureBuilder(
          future: _fetch(),
          builder: (context, snapshot) {
            return SafeArea(
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
                                          // SlidableAction(
                                          //   onPressed: ((context) async {
                                          //     await FirebaseFirestore.instance
                                          //         .collection("users")
                                          //         .doc(FirebaseAuth.instance.currentUser!.uid)
                                          //         .collection("courseRapide")
                                          //         .doc(documentSnapshot.id)
                                          //         .update({
                                          //       "etat": 'Course Terminée',
                                          //     }).asStream();

                                          //   }),
                                          //   backgroundColor: Colors.blue,
                                          //   icon: Icons.motion_photos_auto,
                                          //   label: 'Terminer',
                                          // ),

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
                                            label: 'Supprimer',
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
                                                      documentSnapshot[
                                                              "etat"] ??
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
                                                  "Départ: ${documentSnapshot['depart']} ",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Destination: ${documentSnapshot['destination']} ",
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Prix: ${documentSnapshot['price']} ",
                                                  style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                          // SlidableAction(
                                          //   onPressed: ((context) async {
                                          //     await FirebaseFirestore.instance
                                          //         .collection("users")
                                          //         .doc(FirebaseAuth.instance.currentUser!.uid)
                                          //         .collection("courseRapide")
                                          //         .doc(documentSnapshot.id)
                                          //         .update({
                                          //       "etat": 'Course Terminée',
                                          //     }).asStream();

                                          //   }),
                                          //   backgroundColor: Colors.blue,
                                          //   icon: Icons.motion_photos_auto,
                                          //   label: 'Terminer',
                                          // ),

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
                                                    "Veuillez vérifier votre connexion Internet";

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
                                                title: "Course Rapide",
                                                body:
                                                    "Votre commande a été annulée",
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
                                            label: 'Annuler',
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
                                                      documentSnapshot[
                                                              "etat"] ??
                                                          ''),
                                                  child: Center(
                                                    child: Text(
                                                        "${documentSnapshot['etat']} ",
                                                        style: const TextStyle(
                                                          // fontWeight: FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: 17,
                                                        )),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                    "Départ: ${documentSnapshot['depart']} ",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                    )),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                    "Destination: ${documentSnapshot['destination']} ",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                    )),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Prix: ${documentSnapshot['price']} ",
                                                  style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
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
                          },
                        );
                      },
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Column(
                        children: const [
                          Text(''),
                          Center(
                              child: Text(
                            'Vous n\'êtes pas connecté',
                            style: TextStyle(color: white, fontSize: 20),
                          )),
                        ],
                      ),
                    ),
            );
          },
        ),
        // bottomNavigationBar: CurvedNavigationBar(
        //   backgroundColor: appColor,
        //   index: selsctedIconIndex,
        //   buttonBackgroundColor: appColor,
        //   height: 60.0,
        //   color: white,
        //   onTap: (index) {
        //     setState(() {
        //       selsctedIconIndex = index;
        //     });
        //   },
        //   animationDuration: const Duration(
        //     milliseconds: 200,
        //   ),
        //   items: <Widget>[
        //     Icon(
        //       Icons.play_arrow_outlined,
        //       size: 30,
        //       color: selsctedIconIndex == 0 ? white : black,
        //     ),
        //     // Icon(Icons.search, size: 30,color: selsctedIconIndex == 1 ? white : black,),
        //     IconButton(
        //       icon: Icon(
        //         Icons.home_outlined,
        //         size: 30,
        //         color: selsctedIconIndex == 1 ? white : black,
        //       ),
        //       onPressed: () {
        //         Navigator.push(context,
        //             MaterialPageRoute(builder: (_) => const HomePage()));
        //       },
        //     ),
        //     // Icon(Icons.favorite_border_outlined, size: 30,color: selsctedIconIndex == 3 ? white : black,),
        //     IconButton(
        //       icon: Icon(
        //         Icons.person_outline,
        //         size: 30,
        //         color: selsctedIconIndex == 2 ? white : black,
        //       ),
        //       onPressed: () {
        //         Navigator.push(context,
        //             MaterialPageRoute(builder: (_) => const ContactPage()));
        //       },
        //     )
        //   ],
        // ),
     
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

// Widget fetchData(String collectionName) {
//   var notifyHelper;

//   @override
//   void initState() {
//       super.initState();
//     notifyHelper = NotifyHelper();
//     notifyHelper.initializeNotification();
//     notifyHelper.requestIOSPermissions();
//   }

//   _getBGClr(String no) {
//     switch (no) {
//       case 'Course Terminée':
//         return bluishClr;
//       case 'En Attente':
//         return orangeClr;
//       case 'Course Annulée':
//         return redClr;
//       case 'En Cours':
//         return greenClr;

//       default:
//         return black;
//     }
//   }

//   return StreamBuilder(
//     stream: FirebaseFirestore.instance
//         .collection("users")
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .collection("courseRapide")
//         .snapshots(),
//     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//       if (snapshot.hasError) {
//         return const Center(
//           child: Text("Quelque chose ne va pas"),
//         );
//       }

//       return ListView.builder(
//           itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length,
//           itemBuilder: (_, index) {
//             DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
//             if (documentSnapshot['etat'] == 'Course Annulée') {
//               return AnimationConfiguration.staggeredList(
//                 position: index,
//                 child: SlideAnimation(
//                   child: FadeInAnimation(
//                     child: Slidable(
//                       endActionPane: ActionPane(
//                         motion: const StretchMotion(),
//                         children: [
//                           // SlidableAction(
//                           //   onPressed: ((context) async {
//                           //     await FirebaseFirestore.instance
//                           //         .collection("users")
//                           //         .doc(FirebaseAuth.instance.currentUser!.uid)
//                           //         .collection("courseRapide")
//                           //         .doc(documentSnapshot.id)
//                           //         .update({
//                           //       "etat": 'Course Terminée',
//                           //     }).asStream();

//                           //   }),
//                           //   backgroundColor: Colors.blue,
//                           //   icon: Icons.motion_photos_auto,
//                           //   label: 'Terminer',
//                           // ),

//                           SlidableAction(
//                             onPressed: ((context) async {
//                               await FirebaseFirestore.instance
//                                   .collection("users")
//                                   .doc(FirebaseAuth.instance.currentUser!.uid)
//                                   .collection("courseRapide")
//                                   .doc(documentSnapshot.id)
//                                   .delete();
//                             }),
//                             backgroundColor: Colors.red,
//                             icon: Icons.delete_forever,
//                             label: 'Supprimer',
//                           )
//                         ],
//                       ),
//                       child: Card(
//                         elevation: 5,
//                         child: ListTile(
//                           title: Column(
//                             children: [
//                               Align(
//                                 alignment: Alignment.topRight,
//                                 child: Container(
//                                   height: 25,
//                                   width: 150,
//                                   color:
//                                       _getBGClr(documentSnapshot["etat"] ?? ''),
//                                   child: Center(
//                                     child: Text("${documentSnapshot['etat']} ",
//                                         style: const TextStyle(
//                                           // fontWeight: FontWeight.bold,
//                                           color: Colors.white,
//                                           fontSize: 17,
//                                         )),
//                                   ),
//                                 ),
//                               ),
//                               Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                     "Départ: ${documentSnapshot['depart']} ",
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black,
//                                       fontSize: 20,
//                                     )),
//                               ),
//                               Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                     "Destination: ${documentSnapshot['destination']} ",
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black,
//                                       fontSize: 20,
//                                     )),
//                               ),
//                               Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                   "Prix: ${documentSnapshot['price']} ",
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.normal,
//                                     color: appColor,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           subtitle: Align(
//                             alignment: Alignment.topRight,
//                             child: Text(
//                               "${documentSnapshot['date']}",
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.w300,
//                                   color: Colors.black,
//                                   fontSize: 13),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             } else {
//               return AnimationConfiguration.staggeredList(
//                 position: index,
//                 child: SlideAnimation(
//                   child: FadeInAnimation(
//                     child: Slidable(
//                       endActionPane: ActionPane(
//                         motion: const StretchMotion(),
//                         children: [
//                           // SlidableAction(
//                           //   onPressed: ((context) async {
//                           //     await FirebaseFirestore.instance
//                           //         .collection("users")
//                           //         .doc(FirebaseAuth.instance.currentUser!.uid)
//                           //         .collection("courseRapide")
//                           //         .doc(documentSnapshot.id)
//                           //         .update({
//                           //       "etat": 'Course Terminée',
//                           //     }).asStream();

//                           //   }),
//                           //   backgroundColor: Colors.blue,
//                           //   icon: Icons.motion_photos_auto,
//                           //   label: 'Terminer',
//                           // ),

//                           SlidableAction(
//                             onPressed: ((context) async {
//                               try {
//                                 await FirebaseFirestore.instance
//                                     .collection("users")
//                                     .doc(FirebaseAuth.instance.currentUser!.uid)
//                                     .collection("courseRapide")
//                                     .doc(documentSnapshot.id)
//                                     .update({
//                                   "etat": 'Course Annulée',
//                                 }).asStream();
//                               } catch (error) {
//                                 var message =
//                                     "Veuillez vérifier votre connexion Internet";

//                                 ScaffoldMessenger.of(context)
//                                     .showSnackBar(SnackBar(
//                                   content: Text(message.toString()),
//                                   duration: const Duration(milliseconds: 600),
//                                   backgroundColor:
//                                       Theme.of(context).primaryColor,
//                                 ));
//                               }
//                               notifyHelper.displayNotification(
//                                 title: "Course Rapide",
//                                 body: "Votre commande à été annulée",
//                               );
//                             }),
//                             backgroundColor: Colors.red,
//                             icon: Icons.delete_forever,
//                             label: 'Annuler',
//                           )
//                         ],
//                       ),
//                       child: Card(
//                         elevation: 5,
//                         child: ListTile(
//                           title: Column(
//                             children: [
//                               Align(
//                                 alignment: Alignment.topRight,
//                                 child: Container(
//                                   height: 25,
//                                   width: 150,
//                                   color:
//                                       _getBGClr(documentSnapshot["etat"] ?? ''),
//                                   child: Center(
//                                     child: Text("${documentSnapshot['etat']} ",
//                                         style: const TextStyle(
//                                           // fontWeight: FontWeight.bold,
//                                           color: Colors.white,
//                                           fontSize: 17,
//                                         )),
//                                   ),
//                                 ),
//                               ),
//                               Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                     "Départ: ${documentSnapshot['depart']} ",
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black,
//                                       fontSize: 20,
//                                     )),
//                               ),
//                               Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                     "Destination: ${documentSnapshot['destination']} ",
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.black,
//                                       fontSize: 20,
//                                     )),
//                               ),
//                               Align(
//                                 alignment: Alignment.topLeft,
//                                 child: Text(
//                                   "Prix: ${documentSnapshot['price']} ",
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.normal,
//                                     color: appColor,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           subtitle: Align(
//                             alignment: Alignment.topRight,
//                             child: Text(
//                               "${documentSnapshot['date']}",
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.w300,
//                                   color: Colors.black,
//                                   fontSize: 13),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }
//           });
//     },
//   );

// }
