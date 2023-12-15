import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kun_transport/en/formules/booking/add_booking_bar_en.dart';
import 'package:kun_transport/en/formules/direct_booking.dart';
import 'package:kun_transport/en/transition_en.dart';
import 'package:kun_transport/pages/formules/reservation/add_reserv_bar.dart';
import 'package:kun_transport/pages/transition.dart';
import 'package:provider/provider.dart';

import '../../../service/auth_service.dart';

class AuthBookingPage extends StatelessWidget {
  const AuthBookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
          create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<FirebaseAuthMethods>().authState,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'KunTransport Auth',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AuthWrapper(),
        // routes: {
        //  AddTaskPage.routeName: (context) =>
        //       const SignUpScreen(),
        //   AddTaskPage.routeName: (context) => const AddTaskPage(),

        // },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const BookingPage();
    }
    return TransitionPageEn();
  }
}
