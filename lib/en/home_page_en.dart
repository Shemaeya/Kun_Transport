import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kun_transport/en/actual_order/actual_orders_en_page.dart';
import 'package:kun_transport/en/contacts/contact_page_en.dart';
import 'package:kun_transport/en/formules/aut_page_en.dart';
import 'package:kun_transport/en/formules/booking/aut_page.dart';
import 'package:kun_transport/en/formules/direct_booking.dart';
import 'package:kun_transport/en/formules/long_distance.dart';
import 'package:kun_transport/en/formules/quick_race.dart';
import 'package:kun_transport/pages/formules/longue_distance.dart';

import 'package:kun_transport/screens/details.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:kun_transport/screens/welcom_view.dart';
import 'package:kun_transport/service/search_screen.dart';

import 'package:provider/provider.dart';

import '../constants.dart';

import '../pages/formules/course_rapide.dart';
import '../service/auth_service.dart';
import '../service/notification_services.dart';

class HomePageEn extends StatefulWidget {
  const HomePageEn({super.key});

  @override
  _HomePageEnState createState() => _HomePageEnState();
}

class _HomePageEnState extends State<HomePageEn> {
  late String userName;

  var notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    fetchProducts();
  }

  final List formule = ["Quick Run", "Long Distance", "Direct Bookings"];

//  final List infos = [
//     "Course Rapide",
//     "Longue Distance",
//     "Réservations es"
//   ];
//    final List infosText = [
//     "Profitez d'une réduction sur vos chaussures klnfin cierhnv fevnkdn dnvi  erhv ervoei nvkren viern guhhi bknikn, konn knk ion oinnopopo niopjo  ",
//     "knfoijin efz efer er fef rvnr nkn zofne nv ergern rj, zefenf ejfef erfer fjer ferf eferf  jef",
//     "Réservations Direcn  r,nporé kn kln nv dsv v kodnv df vdnj d v   v,sxv snv,s kssdj s,f sd fsd f  d s sf d dstes"
//   ];
//   final List sticker = [
//     "Promo",
//     "Promo",
//     "Réserv"
//   ];

  List images = [
    "28721",
    "07001",
    "20065",
  ];

  List pages = [
    const QuickRacePage(),
    const AuthPageEn(),
    const AuthBookingPage(),
  ];
  int current = 0;

  int selsctedIconIndex = 1;
  String mtoken = "";

  Future<void> _handleRefresh() async {
    return await Future.delayed(const Duration(seconds: 2));
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        mtoken = token!;
        // print("My token is $mtoken ");
      });
      saveToken(token!);
    });
  }

  void saveToken(String token) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    var currentUser = auth.currentUser;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser!.uid)
        .update({
      'token': token,
    });
    // print(token);
  }

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
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/image33.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0, left: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Hello,",
                                style: GoogleFonts.bebasNeue(
                                  fontSize: 32,
                                  color: Colors.white,
                                  letterSpacing: 1.8,
                                ),
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
                                            fontSize: 32,
                                            color: const Color(0xFF40D876),
                                            letterSpacing: 1.8,
                                          ),
                                        );
                                      }
                                      return Text(
                                        userName,
                                        style: GoogleFonts.bebasNeue(
                                          fontSize: 32,
                                          color: const Color(0xFF40D876),
                                          letterSpacing: 1.8,
                                        ),
                                      );
                                    }
                                    return const Text("");
                                  }),
                            ],
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const WelcomView())),
                            child: Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.0),
                                border: Border.all(
                                  width: 2,
                                  color: const Color(0xFF40D876),
                                ),
                                image: const DecorationImage(
                                  image: AssetImage("assets/images/en.png"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.1),
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        child: Center(
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: const Color(0xFF40D876),
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            child: Center(
                                child: Image.asset(
                              "assets/images/elel.png",
                              height: 800,
                              width: 800,
                            )),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, top: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Book ",
                                style: GoogleFonts.lato(
                                  fontSize: 26,
                                  color: const Color(0xFF40D876),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "your car",
                                style: GoogleFonts.lato(
                                  fontSize: 26,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.filter_alt_outlined,
                            size: 40,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        width: 353,
                        height: 46,
                        decoration: BoxDecoration(
                          color: const Color(0xFF232441),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextFormField(
                            readOnly: firebaseUser != null ? true : false,
                            onTap: () => firebaseUser != null
                                ? Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (_) => SearchScreen()))
                                : null,
                            decoration: const InputDecoration(
                              hintText: "SEARCH",
                              hintStyle: TextStyle(
                                color: Colors.white54,
                              ),
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.search,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 20),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //     children: [
                    //       Text(
                    //         "Professionalisme",
                    //         style: GoogleFonts.lato(
                    //           fontSize: 16,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //       Text(
                    //         "Confort",
                    //         style: GoogleFonts.lato(
                    //           fontSize: 16,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //       Text(
                    //         "Sécurité",
                    //         style: GoogleFonts.lato(
                    //           fontSize: 16,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //       Text(
                    //         "Expérience",
                    //         style: GoogleFonts.lato(
                    //           fontSize: 16,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Text(
                            "Our Packages",
                            style: GoogleFonts.lato(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: SizedBox(
                        height: 226,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: formule.length,
                          itemBuilder: (BuildContext context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  current = index;
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => pages[current]));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  height: 226,
                                  width: 260,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(20.0),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/${images[index]}.jpg"),
                                        fit: BoxFit.cover,
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, top: 30.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Align(
                                          child: Text(
                                            formule[index],
                                            style: GoogleFonts.lato(
                                              fontSize: 40,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "",
                                          style: GoogleFonts.lato(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            // padding: const EdgeInsets.all(0.0),

                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white),

                                            child: Align(
                                                alignment: Alignment.center,
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.play_arrow,
                                                    size: 30,
                                                  ),
                                                  onPressed: () {},
                                                )),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        // Text(
                                        //   "I have never trained",
                                        //   style: GoogleFonts.lato(
                                        //     fontSize: 12,
                                        //     fontWeight: FontWeight.w400,
                                        //     color: Colors.white,
                                        // ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Container(
                        height: 160,
                        color: const Color.fromARGB(255, 16, 16, 35),
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: infos.length,
                          itemBuilder: (BuildContext context, index) {
                            var item = infos[index];
                            return GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   current = index;
                                // });

                                // notifyHelper.displayNotification(
                                //   title: "Commande de voiture",
                                //   body: "Vous venez de commander une voiture",
                                // );
                                // notifyHelper.scheduledNotification();

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => DetailScreen(item)));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Center(
                                  child: Container(
                                    height: 130,
                                    width: 370,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, top: 10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 100,
                                                width: 90,
                                                child: Image.network(
                                                  item['image'].toString(),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, top: 10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    item["title"].toString(),
                                                    style: GoogleFonts.lato(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 60.0),
                                                    child: Container(
                                                      height: 20,
                                                      width: 60,
                                                      color: Colors.red,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10.0,
                                                                top: 2),
                                                        child: Text(
                                                            item["sticker"]
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .lato(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            )),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Expanded(
                                                child: SizedBox(
                                                  // height: 100,
                                                  width: 250,
                                                  child: SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    child: Text(
                                                      item["subTitle"]
                                                          .toString(),
                                                      style: GoogleFonts.lato(
                                                        fontSize: 14,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                      maxLines: 4,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: appColor,
            index: selsctedIconIndex,
            buttonBackgroundColor: appColor,
            height: 60.0,
            color: white,
            onTap: (index) {
              setState(() {
                selsctedIconIndex = index;
              });
            },
            animationDuration: const Duration(
              milliseconds: 200,
            ),
            items: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.play_arrow_outlined,
                  size: 30,
                  color: selsctedIconIndex == 0 ? white : black,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ActualOrderEnPage()));
                },
              ),
              // Icon(Icons.search, size: 30,color: selsctedIconIndex == 1 ? white : black,),
              Icon(
                Icons.home_outlined,
                size: 30,
                color: selsctedIconIndex == 1 ? white : black,
              ),
              // Icon(Icons.favorite_border_outlined, size: 30,color: selsctedIconIndex == 3 ? white : black,),
              IconButton(
                icon: Icon(
                  Icons.person_outline,
                  size: 30,
                  color: selsctedIconIndex == 2 ? white : black,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ContactPageEn()));
                },
              )
            ],
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
      }).catchError((e) {});
    }
  }

  final List infos = [];
  final _firestoreInstance = FirebaseFirestore.instance;
  fetchProducts() async {
    QuerySnapshot qn = await _firestoreInstance.collection("infosEn").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        infos.add({
          "title": qn.docs[i]["title"],
          "subTitle": qn.docs[i]["subTitle"],
          "sticker": qn.docs[i]["sticker"],
          "image": qn.docs[i]["image"],
        });
      }
    });

    return qn.docs;
  }
}
