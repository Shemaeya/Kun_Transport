import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kun_transport/constants.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late String userCode;
  var inputText = "";
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    var size = MediaQuery.of(context).size;
    setState(() {
      firebaseUser;
    });
    return Scaffold(
      body: FutureBuilder(
        future: _fetch(),
        builder: (context, snapshot) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    // margin: const EdgeInsets.all(3),

                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 16,
                              spreadRadius: 1,
                              offset: const Offset(0, 4))
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoSearchTextField(
                        onChanged: (val) {
                          setState(() {
                            inputText = val;
                          });
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Annuler',
                          style: TextStyle(color: Colors.red, fontSize: 17),
                        )),
                  ),
                  // const SizedBox(height: 20),
                  Expanded(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("cmd")
                            .doc("ePJw8GQh1egsiuJA8IaL")
                            .collection("courseLongue")
                            .where('uid',
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser!.uid)
                            .where("title", isGreaterThanOrEqualTo: inputText)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text("Something went wrong"),
                            );
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: Text("Chargement..."),
                            );
                          }

                          return ListView.builder(
                              itemCount: snapshot.data == null
                                  ? 0
                                  : snapshot.data!.docs.length,
                              itemBuilder: (_, index) {
                                DocumentSnapshot documentSnapshot =
                                    snapshot.data!.docs[index];
                                if (firebaseUser != null) {
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
                                                  FirebaseFirestore.instance
                                                      .collection("commande")
                                                      .doc(FirebaseAuth.instance
                                                          .currentUser!.email)
                                                      .collection("all")
                                                      .doc(documentSnapshot.id)
                                                      .delete();
                                                }),
                                                backgroundColor: Colors.red,
                                                icon: Icons.delete_forever,
                                                label: 'Supprimer',
                                              )
                                            ],
                                          ),

                                          // endActionPane: ,

                                          child: Card(
                                            child: Container(
                                              height: 80,
                                              color: Colors.grey[100],
                                              child: ListTile(
                                                title: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(documentSnapshot[
                                                          'title']),
                                                      Text(
                                                        '${documentSnapshot["price"]}'
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontSize: 19,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: appColor,
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        child: Text(
                                                          '${documentSnapshot["etat"]}'
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                leading: Text(
                                                  '${documentSnapshot["formule"]}'
                                                      .toString(),
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.lightBlue,
                                                  ),
                                                ),
                                                onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            showBottomSheet(
                                                                documentSnapshot))),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              });
                        }),
                  ),
                ],
              ),
            ),
          );
        },
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
        userCode = ds['CodeMark'];
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

  deleted(id) async {
    FirebaseFirestore.instance
        .collection("commande")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("courseLongue")
        .doc(id)
        .delete();
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
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 70),
                      //   child: ElevatedButton(
                      //     style: ElevatedButton.styleFrom(
                      //         backgroundColor: Colors.red),
                      //     onPressed: () {
                      //       deleted(widget.item.id);
                      //       Navigator.pop(context);
                      //     },
                      //     child: const Text('Annuler la commande'),
                      //   ),
                      // )
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
