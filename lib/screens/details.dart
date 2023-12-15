import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreen extends StatefulWidget {
  var item;
  DetailScreen(this.item, {super.key});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
                child: Column(
              children: [
                SizedBox(
                  height: size.width,
                  child: Image.network(
                    widget.item['image'].toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFecf0f1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  padding: const EdgeInsets.all(17),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.item['title'].toString(),
                            style: const TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(width: 12.0),
                          Container(
                              height: 30,
                              width: 80,
                              color: Colors.red,
                              child: Center(
                                child: Text(widget.item['sticker'].toString(),
                                    style: GoogleFonts.lato(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    )),
                              )),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(
                        height: 1,
                      ),
                      const SizedBox(height: 16),
                      const Text('Description',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700)),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Text(
                          widget.item['subTitle'].toString(),
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return AppBar(
      // key: _key,
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromARGB(255, 14, 9, 9),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          }),
    );
  }
}
