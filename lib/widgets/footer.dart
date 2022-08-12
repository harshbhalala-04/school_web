// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
      width: deviceSize.width,
      height: 400,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 75.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      width: 112,
                      height: 112,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "St. Xaviers CMI Public School",
                      style: TextStyle(
                          fontFamily: "calibri",
                          fontSize: 32,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Address:",
                  style: TextStyle(
                      fontFamily: "calibri",
                      fontSize: 22,
                      fontWeight: FontWeight.w700),
                ),
                Text("Meru Baug, Ghogha Road \nBhavnagar 364 002, Gujarat",
                    style: TextStyle(
                        fontFamily: "calibri",
                        fontSize: 22,
                        fontWeight: FontWeight.w300))
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Text(
                  "Pages",
                  style: TextStyle(
                      fontFamily: "calibri",
                      fontSize: 32,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 10),
                Text("Courses",
                    style: TextStyle(
                        fontFamily: "calibri",
                        fontSize: 22,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w300)),
                SizedBox(
                  height: 5,
                ),
                Text("Test Generator",
                    style: TextStyle(
                        fontFamily: "calibri",
                        fontSize: 22,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w300)),
                SizedBox(
                  height: 5,
                ),
                Text("About us",
                    style: TextStyle(
                        fontFamily: "calibri",
                        fontSize: 22,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w300)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                ),
                Text(
                  "Connect with us",
                  style: TextStyle(
                      fontFamily: "calibri",
                      fontSize: 32,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/insta.png",
                      width: 32,
                      height: 32,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Image.asset(
                      "assets/images/fb.png",
                      width: 32,
                      height: 32,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Image.asset(
                      "assets/images/yt.png",
                      width: 32,
                      height: 32,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
