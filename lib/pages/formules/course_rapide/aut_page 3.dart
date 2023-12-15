import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kun_transport/pages/formules/course_rapide/beauvais.dart';
import 'package:kun_transport/pages/formules/course_rapide/disney.dart';
import 'package:kun_transport/pages/formules/course_rapide/paris.dart';
import 'package:kun_transport/pages/transition.dart';
import 'package:provider/provider.dart';

import '../../../service/auth_service.dart';

class AuthPage3 extends StatelessWidget {
  const AuthPage3({Key? key}) : super(key: key);

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
      return const BeauvaisPage();
    }
    return TransitionPage();
  }
}

class AuthPageDis extends StatelessWidget {
  const AuthPageDis({Key? key}) : super(key: key);

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
        home: const AuthWrapperDis(),
        // routes: {
        //  AddTaskPage.routeName: (context) =>
        //       const SignUpScreen(),
        //   AddTaskPage.routeName: (context) => const AddTaskPage(),

        // },
      ),
    );
  }
}

class AuthWrapperDis extends StatelessWidget {
  const AuthWrapperDis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const DisneyPage();
    }
    return TransitionPage();
  }
}

class AuthPageParis extends StatelessWidget {
  const AuthPageParis({Key? key}) : super(key: key);

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
        home: const AuthWrapperParis(),
      ),
    );
  }
}

class AuthWrapperParis extends StatelessWidget {
  const AuthWrapperParis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const ParisPage();
    }
    return TransitionPage();
  }
}
