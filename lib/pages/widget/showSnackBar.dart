import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kun_transport/constants.dart';

void showNotification(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: GoogleFonts.lato(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: appColor,
      showCloseIcon: true,
      closeIconColor: Colors.white,
    ),
  );
}
