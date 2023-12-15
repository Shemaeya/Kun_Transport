import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kun_transport/en/formules/quick_race/aut_page_en_3.dart';
import 'package:kun_transport/en/home_page_en.dart';
import 'package:kun_transport/en/my_bottom_nav_bar_en.dart';
import 'package:kun_transport/pages/formules/course_rapide/aut_page%203.dart';

import '../../constants.dart';
import '../../screens/home_page.dart';

class QuickRacePage extends StatefulWidget {
  const QuickRacePage({super.key});

  @override
  State<QuickRacePage> createState() => _QuickRacePageState();
}

class _QuickRacePageState extends State<QuickRacePage> {
  String _selectedTime = "";
  List<String> depart = [
    "PARIS",
    "DISNEYLAND",
    "AÉROPORT DE BEAUVAIS",
  ];
  List image = [
    "p",
    "d",
    "a",
  ];
  List<Color> bgColors = [
    Color.fromARGB(255, 28, 121, 234),
    const Color(0xFFD4EEF3),
    const Color(0xFFFAE6D5),
  ];
  List pages = [
    const AuthPageParisEn(),
    const AuthPageDisEn(),
    const AuthPage3En(),
  ];
  int current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: appColor,
                          ),
                          onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const MyBottomNavBarEn())),
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
              SizedBox(
                height: 300,
                width: 300,
                child: Image.asset("assets/images/commandeCar.gif")),
              Text(
                "Departure Locations",
                style: GoogleFonts.bebasNeue(
                  fontSize: 32,
                  color: Colors.black,
                  letterSpacing: 1.8,
                ),
              ),

              // MyInputField(
              //   title: "Où allez vous?",
              //   hint: _selectedTime,
              //   widget: DropdownButton(
              //     icon: const Icon(
              //       Icons.keyboard_arrow_down,
              //       color: Colors.grey,
              //     ),
              //     iconSize: 32,
              //     elevation: 4,
              //     style: GoogleFonts.lato(
              //       fontSize: 17,
              //       fontWeight: FontWeight.bold,
              //       color: appColor,
              //     ),
              //     underline: Container(
              //       height: 20,
              //     ),
              //     items:
              //         repeatList.map<DropdownMenuItem<String>>((String value) {
              //       return DropdownMenuItem<String>(
              //           value: value,
              //           child: Text(value,
              //               style: const TextStyle(color: Colors.grey)));
              //     }).toList(),
              //     onChanged: (String? value) {
              //       setState(() {
              //         _selectedTime = value!;
              //       });
              //     },
              //   ),
              // ),

              SizedBox(
                height: 200,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: depart.length,
                  itemBuilder: (contex, index) {
                    return InkWell(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => pages[current])),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            current = index;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => pages[current]));
                        },
                        child: Container(
                          width: 180,
                          margin: const EdgeInsets.only(left: 15),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              color: bgColors[index],
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                "assets/images/${image[index]}.png",
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
                                    depart[index],
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
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
