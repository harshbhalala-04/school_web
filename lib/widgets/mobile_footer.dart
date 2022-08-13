// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MobileFooter extends StatelessWidget {
  const MobileFooter({
    Key? key,
    required this.deviceSize,
  }) : super(key: key);

  final Size deviceSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
      width: deviceSize.width,
      // height: 400,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 75.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Flexible(
                      child: Text(
                        "St. Xaviers CMI Public School",
                        style: TextStyle(
                            fontFamily: "calibri",
                            fontSize: deviceSize.width > 1060 ? 32 : 26,
                            fontWeight: FontWeight.w700),
                      ),
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
                      fontSize: deviceSize.width > 1060 ? 22 : 16,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "Meru Baug, Ghogha Road \nBhavnagar 364 002, Gujarat",
                  style: TextStyle(
                      fontFamily: "calibri",
                      fontSize: deviceSize.width > 1060 ? 22 : 16,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Pages",
                  style: TextStyle(
                      fontFamily: "calibri",
                      fontSize: deviceSize.width > 1060 ? 32 : 26,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 10),
                Text("Courses",
                    style: TextStyle(
                        fontFamily: "calibri",
                        fontSize: deviceSize.width > 1060 ? 22 : 16,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w300)),
                SizedBox(
                  height: 5,
                ),
                Text("Test Generator",
                    style: TextStyle(
                        fontFamily: "calibri",
                        fontSize: deviceSize.width > 1060 ? 22 : 16,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w300)),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "About us",
                  style: TextStyle(
                      fontFamily: "calibri",
                      fontSize: deviceSize.width > 1060 ? 22 : 16,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Connect with us",
                  style: TextStyle(
                      fontFamily: "calibri",
                      fontSize: deviceSize.width > 1060 ? 32 : 22,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/insta.png",
                      width: deviceSize.width > 1060 ? 32 : 26,
                      height: deviceSize.width > 1060 ? 32 : 26,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Image.asset(
                      "assets/images/fb.png",
                      width: deviceSize.width > 1060 ? 32 : 26,
                      height: deviceSize.width > 1060 ? 32 : 26,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Image.asset(
                      "assets/images/yt.png",
                      width: deviceSize.width > 1060 ? 32 : 26,
                      height: deviceSize.width > 1060 ? 32 : 26,
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
