// import 'package:flutter/material.dart';
// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:kun_transport/screens/welcom_view.dart';
// import 'package:lottie/lottie.dart';
// import 'package:page_transition/page_transition.dart';




// class SplashScreen extends StatelessWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: AnimatedSplashScreen(
//           backgroundColor: const Color(0xFF232441),
//           splash: Lottie.asset('assets/images/car.json'),
//           splashIconSize: 400,
//           duration: 2000,
//           // backgroundColor: Colors.grey
//           pageTransitionType: PageTransitionType.rightToLeftWithFade,
//           nextScreen:  const WelcomView(),
//           ),
//     );
//   }
// }