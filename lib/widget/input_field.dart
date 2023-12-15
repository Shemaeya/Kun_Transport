import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const MyInputField({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.lato(
                fontSize: 18,
                //  color: Colors.grey[500],
                fontWeight: FontWeight.bold),
          ),
          Container(
            height: 52,
            width: 410,
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.only(
              left: 14,
            ),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    cursorColor: Colors.grey[700],
                    controller: controller,
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: GoogleFonts.lato(
                        fontSize: 17,
                        color: Colors.grey[700],
                      ),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0)),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0)),
                    ),
                  ),
                ),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MyInputField3 extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const MyInputField3({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.lato(
                fontSize: 18,
                //  color: Colors.grey[500],
                fontWeight: FontWeight.bold),
          ),
          Container(
            height: 52,
            width: 600,
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.only(
              left: 14,
            ),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    cursorColor: Colors.grey[700],
                    controller: controller,
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: GoogleFonts.lato(
                        fontSize: 17,
                        color: Colors.grey[700],
                      ),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0)),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0)),
                    ),
                  ),
                ),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MyInputField1 extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const MyInputField1({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.lato(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 52,
            width: 100,
            // margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.only(
              left: 14,
            ),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    autofocus: false,
                    cursorColor: Colors.grey[700],
                    controller: controller,
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: GoogleFonts.lato(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0)),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0)),
                    ),
                  ),
                ),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MyInputField2 extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const MyInputField2({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.lato(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 52,
            width: 100,
            // margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.only(
              left: 14,
            ),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    autofocus: false,
                    cursorColor: Colors.grey[700],
                    controller: controller,
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: GoogleFonts.lato(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0)),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0)),
                    ),
                  ),
                ),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MyInputField0 extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const MyInputField0({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.lato(
                fontSize: 2, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 1,
            width: 1,
            // margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.only(
              left: 14,
            ),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.0),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    autofocus: false,
                    cursorColor: Colors.grey[700],
                    controller: controller,
                    style: GoogleFonts.lato(
                      fontSize: 1,
                      color: Colors.grey[600],
                    ),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: GoogleFonts.lato(
                        fontSize: 2,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0)),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0)),
                    ),
                  ),
                ),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
