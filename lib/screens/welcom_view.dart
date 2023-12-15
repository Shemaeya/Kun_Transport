import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kun_transport/en/aut_page_w_e.dart';
import 'package:kun_transport/screens/aut_page_w.dart';
import 'package:connectivity_plus/connectivity_plus.dart';


class WelcomView extends StatefulWidget {
  const WelcomView({super.key});

  @override
  _WelcomViewState createState() => _WelcomViewState();
}

class _WelcomViewState extends State<WelcomView> {
  final List language = [
    "Français",
    "English",
  ];
  List flag = [
    "fr",
    "en",
  ];
  List pages = [const AuthPageW(), const AuthPageWE()];
  int current = 0;
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/imagecar2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder(
          stream: Connectivity().onConnectivityChanged,
          builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
            // sometimes the stream builder doesn't work with simulator so you can check this on real devices to get the right result
            print(snapshot.toString());
            if (snapshot.hasData) {
              ConnectivityResult? result = snapshot.data;
              if (result == ConnectivityResult.mobile) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 70.0),
                          child: Container(
                            height: 80,
                            width: 365,
                            decoration: BoxDecoration(
                              color: const Color(0xFF232441),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Image.asset(
                              "assets/images/kunt.png",
                              height: 100,
                              width: 150,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome",
                            style: GoogleFonts.lato(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Sélectionner la langue / Select language",
                            style: GoogleFonts.lato(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: SizedBox(
                              height: 206,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: language.length,
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
                                        width: 195,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF232441),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
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
                                              Text(
                                                language[index],
                                                style: GoogleFonts.lato(
                                                  fontSize: 40,
                                                  color: const Color.fromARGB(
                                                      255, 250, 179, 80),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "(${flag[index]})",
                                                style: GoogleFonts.lato(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15.0,
                                              ),
                                              Container(
                                                height: 50,
                                                width: 50,
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white),
                                                child: Image.asset(
                                                    "assets/images/${flag[index]}.png"),
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
                            padding: const EdgeInsets.only(
                                right: 40.0, top: 40, bottom: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "",
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white30,
                                  ),
                                ),
                                // GestureDetector(
                                //   onTap: () {
                                //     Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: (context) => const HomePage()));
                                //   },
                                //   child: Container(
                                //     width: 139,
                                //     height: 39,
                                //     decoration: BoxDecoration(
                                //       color: const Color(0xFF40D876),
                                //       borderRadius: BorderRadius.circular(5.0),
                                //     ),
                                //     child: Center(
                                //       child: Text(
                                //         "Next",
                                //         style: GoogleFonts.lato(
                                //           fontSize: 16,
                                //           fontWeight: FontWeight.w400,
                                //           color: Colors.white,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              } else if (result == ConnectivityResult.wifi) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 70.0),
                          child: Container(
                            height: 80,
                            width: 365,
                            decoration: BoxDecoration(
                              color: const Color(0xFF232441),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Image.asset(
                              "assets/images/kunt.png",
                              height: 100,
                              width: 150,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome",
                            style: GoogleFonts.lato(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Sélectionner la langue / Select language",
                            style: GoogleFonts.lato(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: SizedBox(
                              height: 206,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: language.length,
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
                                        width: 195,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF232441),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
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
                                              Text(
                                                language[index],
                                                style: GoogleFonts.lato(
                                                  fontSize: 40,
                                                  color: const Color.fromARGB(
                                                      255, 250, 179, 80),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "(${flag[index]})",
                                                style: GoogleFonts.lato(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15.0,
                                              ),
                                              Container(
                                                height: 50,
                                                width: 50,
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white),
                                                child: Image.asset(
                                                    "assets/images/${flag[index]}.png"),
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
                            padding: const EdgeInsets.only(
                                right: 40.0, top: 40, bottom: 40),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "",
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white30,
                                  ),
                                ),
                                // GestureDetector(
                                //   onTap: () {
                                //     Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: (context) => const HomePage()));
                                //   },
                                //   child: Container(
                                //     width: 139,
                                //     height: 39,
                                //     decoration: BoxDecoration(
                                //       color: const Color(0xFF40D876),
                                //       borderRadius: BorderRadius.circular(5.0),
                                //     ),
                                //     child: Center(
                                //       child: Text(
                                //         "Next",
                                //         style: GoogleFonts.lato(
                                //           fontSize: 16,
                                //           fontWeight: FontWeight.w400,
                                //           color: Colors.white,
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              } else {
                return noInternet();
              }
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 70.0),
                        child: Container(
                          height: 80,
                          width: 365,
                          decoration: BoxDecoration(
                            color: const Color(0xFF232441),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Image.asset(
                            "assets/images/kunt.png",
                            height: 100,
                            width: 150,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome",
                          style: GoogleFonts.lato(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Sélectionner la langue / Select language",
                          style: GoogleFonts.lato(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: SizedBox(
                            height: 206,
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: language.length,
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
                                      width: 195,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF232441),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
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
                                            Text(
                                              language[index],
                                              style: GoogleFonts.lato(
                                                fontSize: 40,
                                                color: const Color.fromARGB(
                                                    255, 250, 179, 80),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "(${flag[index]})",
                                              style: GoogleFonts.lato(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15.0,
                                            ),
                                            Container(
                                              height: 50,
                                              width: 50,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white),
                                              child: Image.asset(
                                                  "assets/images/${flag[index]}.png"),
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
                          padding: const EdgeInsets.only(
                              right: 40.0, top: 40, bottom: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "",
                                style: GoogleFonts.lato(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white30,
                                ),
                              ),
                              // GestureDetector(
                              //   onTap: () {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) => const HomePage()));
                              //   },
                              //   child: Container(
                              //     width: 139,
                              //     height: 39,
                              //     decoration: BoxDecoration(
                              //       color: const Color(0xFF40D876),
                              //       borderRadius: BorderRadius.circular(5.0),
                              //     ),
                              //     child: Center(
                              //       child: Text(
                              //         "Next",
                              //         style: GoogleFonts.lato(
                              //           fontSize: 16,
                              //           fontWeight: FontWeight.w400,
                              //           color: Colors.white,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget loading() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
      ),
    );
  }

  Widget noInternet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/no_internet.png',
          color: Colors.red,
          height: 100,
        ),
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 10),
          child: const Text(
            "No Internet connection",
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: const Text(
            "Check your connection, then refresh the page.",
            style: TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
          onPressed: () async {
            // You can also check the internet connection through this below function as well
            ConnectivityResult result =
                await Connectivity().checkConnectivity();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WelcomView(),
              ),
            );

            print(result.toString());
          },
          child: const Text("Refresh"),
        ),
      ],
    );
  }
}
