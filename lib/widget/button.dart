import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kun_transport/constants.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const MyButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 120,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: appColor,
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.lato(
                  fontSize: 17,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}

class MyButton3 extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const MyButton3({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 120,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: secondApp,
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.lato(
                  fontSize: 17,
                  color: black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}

class MyButton2 extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const MyButton2({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 170,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: appColor,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                label,
                style: GoogleFonts.lato(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ));
  }
}

class MyButton1 extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const MyButton1({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 170,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: appColor,
          ),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.lato(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
