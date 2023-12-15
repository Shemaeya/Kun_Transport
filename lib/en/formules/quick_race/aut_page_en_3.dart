import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kun_transport/en/formules/quick_race/beauvais_en.dart';
import 'package:kun_transport/en/formules/quick_race/disney_en.dart';
import 'package:kun_transport/en/formules/quick_race/paris_en.dart';
import 'package:kun_transport/en/transition_en.dart';

import 'package:provider/provider.dart';

import '../../../service/auth_service.dart';

class AuthPage3En extends StatelessWidget {
  const AuthPage3En({Key? key}) : super(key: key);

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
      return const BeauvaisPageEn();
    }
    return TransitionPageEn();
  }
}

class AuthPageDisEn extends StatelessWidget {
  const AuthPageDisEn({Key? key}) : super(key: key);

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
        home: const AuthWrapperDisEn(),
        // routes: {
        //  AddTaskPage.routeName: (context) =>
        //       const SignUpScreen(),
        //   AddTaskPage.routeName: (context) => const AddTaskPage(),

        // },
      ),
    );
  }
}

class AuthWrapperDisEn extends StatelessWidget {
  const AuthWrapperDisEn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const DisneyPageEn();
    }
    return TransitionPageEn();
  }
}

class AuthPageParisEn extends StatelessWidget {
  const AuthPageParisEn({Key? key}) : super(key: key);

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
        home: const AuthWrapperParisEn(),
      ),
    );
  }
}

class AuthWrapperParisEn extends StatelessWidget {
  const AuthWrapperParisEn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const ParisPageEn();
    }
    return TransitionPageEn();
  }
}
