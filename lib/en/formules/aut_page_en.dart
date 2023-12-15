
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kun_transport/en/formules/long_distance.dart';
import 'package:kun_transport/en/formules/long_distance/add_task_bar_en.dart';
import 'package:kun_transport/en/transition_en.dart';
import 'package:kun_transport/pages/transition.dart';
import 'package:kun_transport/service/auth_service.dart';
import 'package:provider/provider.dart';





class AuthPageEn extends StatelessWidget {
  const AuthPageEn({Key? key}) : super(key: key);

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
      return const LongDistancePage();
    }
    return  TransitionPageEn();
  }
}
