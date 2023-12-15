
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kun_transport/pages/login_page.dart';
import 'package:kun_transport/pages/widget/showSnackBar.dart';


import '../components/my_button.dart';
import '../components/my_textfield.dart';


class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});


  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
RegExp regExp = RegExp(p);
bool isLoading = false;

class _ResetPasswordState extends State<ResetPassword> {
  final  _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.grey[300],
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () =>  Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Réinitialisation",
          style: TextStyle(fontSize: 24,color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Container(
          
          // Place as the child widget of a scaffold
          width: double.infinity,
          height: double.infinity,
         
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 50),
       
                  const SizedBox(
                    height: 40,
                  ),
                   MyTextField(
                       controller: _emailController,
                  hintText: "Saisissez l'Email Id",
                  obscureText: false,),
                  const SizedBox(
                    height: 20,
                  ),
                  MyButtonRes(
                
                  onTap: 
                    () async { 
                           
    if ( _emailController.text.isEmpty){
      showNotification(context, "Le champ email est vide");
    } else if (!regExp.hasMatch(_emailController.text)) {
      showNotification(context, "Veuillez essayer un email valide");
    }else {

      try {
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(
                              email: _emailController.text)
                          .then((value) => Navigator.of(context).pop());
                           showCupertinoDialog(context: context, builder: createDialog);
                          } 
                          on PlatformException catch (error) {
      var message = "Please Check Your Internet Connection ";
      if (error.message != null) {
        message = error.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message.toString()),
        duration: const Duration(milliseconds: 600),
        backgroundColor: Theme.of(context).primaryColor,
      ));
      setState(() {
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.toString()),
        duration: const Duration(milliseconds: 600),
        backgroundColor: Theme.of(context).primaryColor,
      ));
    }
 
  }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
Widget createDialog(BuildContext context) => CupertinoAlertDialog(
      title: const Text('Un mail de réinitialisation de votre mot de passe vous a été envoyé. \n Veulliez consumter votre boite mail!'),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  LoginPage(),
                ),
              );
            },
          child: const Text('Fermer'),
        ),
      ],
    );
