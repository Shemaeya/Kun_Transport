import 'package:flutter/material.dart';
import 'package:kun_transport/pages/login_page.dart';
import 'package:kun_transport/pages/signUp_page.dart';
import 'package:kun_transport/screens/home_page.dart';
import 'package:kun_transport/screens/my_bottom_nav_bar.dart';

import '../components/my_button.dart';


class TransitionPage extends StatelessWidget {
  TransitionPage({super.key});

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
        
                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
        
                const SizedBox(height: 50),
        
                // welcome back, you've been missed!
                Padding(
                  padding: const EdgeInsets.only(left:20.0, right: 20.0),
                  child: Text(
                    'Désolé, vous devez vous connecter pour accéder à cette page',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
                ),
        
          
        
                // username textfield
           
        
                const SizedBox(height: 10),
        
              
        
                const SizedBox(height: 25),
        
                // sign in button
                MyButton(
                  onTap: (){
                    Navigator.push(
                      context, MaterialPageRoute(builder: (_) =>  LoginPage()));
                  },
                ),
                 const SizedBox(height: 20),
                   Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Ou ',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

               const SizedBox(height: 30),
       
                 MyButtonSingUp(
                  onTap: (){
                    Navigator.push(
                      context, MaterialPageRoute(builder: (_) =>  SignUpPage()));
                  },
                ),
        
                const SizedBox(height: 20),
        
                // or continue with
    
        
                // google + apple sign in buttons
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                       onPressed: () {   Navigator.push(
                        context, MaterialPageRoute(builder: (_) =>  const MyBottomNavBar())); },
                      child: const Text("Accueil>>",
                      style: TextStyle(
                        color: Colors.black26,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                ),
                const SizedBox(height: 50),
        
                // not a member? register now
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
