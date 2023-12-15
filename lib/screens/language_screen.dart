import 'package:flutter/material.dart';
import 'package:kun_transport/screens/my_bottom_nav_bar.dart';

import 'home_page.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: Center(
              child: Scrollbar(
                  child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(5),
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child:
                              Image.asset("assets/images/kunt.png", width: 280),
                        ),
                        // const SizedBox(height: 5),
                        // Center(child: Image.asset("assets/images/kun.png", width: 200),),
                        const SizedBox(
                          height: 30,
                        ),

                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Sélectionner la langue / Select language',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        // GridView.builder(
                        //   gridDelegate:
                        // const SliverGridDelegateWithFixedCrossAxisCount(
                        //   crossAxisCount: 2,
                        //   childAspectRatio: 1,
                        //   ),
                        //   itemCount: 2,
                        //   physics: const NeverScrollableScrollPhysics(),
                        //   shrinkWrap: true,
                        //   itemBuilder: (context, index) =>
                        //    Container(width: 300, height: 300,
                        //    color: index== 0?Colors.red:Colors.blueGrey,)
                        //   ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const MyBottomNavBar())),
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color.fromARGB(255, 41, 148, 241),
                                        Color.fromARGB(255, 5, 113, 202),
                                      ]),
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    const Text(
                                      "Français",
                                      style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Container(
                                        height: 50,
                                        width: 50,
                                        padding: const EdgeInsets.all(8.0),
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white),
                                        child: const Image(
                                          image: AssetImage(
                                            "assets/images/fr.jpeg",
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.orange,
                                      Color.fromARGB(255, 208, 54, 7),
                                    ]),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Text(
                                    "English",
                                    style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  Container(
                                      height: 50,
                                      width: 50,
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: const Image(
                                        image: AssetImage(
                                          "assets/images/us.jpeg",
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        const Text(
                            'Vous pouvez changer de langue \n You can change your language',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              )),
            ))
          ],
        ),
      ),
    );
  }
}
