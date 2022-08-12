// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class AboutUsSection extends StatefulWidget {
  const AboutUsSection({Key? key}) : super(key: key);

  @override
  State<AboutUsSection> createState() => _AboutUsSectionState();
}

class _AboutUsSectionState extends State<AboutUsSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 75.0, right: 75),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: Text(
              "St. Xaviers CMI Public School is an avant-garde educational institution of Bhavnagar, Gujarat, India. It has an experienced academic ensemble of teaching staff. Xaviers is focusing to achieve pristine perfection through its abundant academic quests. Our creative and constructive contributions to the society have carved us a niche in the society. Thanks to its diligent efforts, St. Xaviers CMI Public School has become a leading light and pacemaker for other academic institutions to emulate. It is managed by the dedicated Carmelites of Mary Immaculate fathers.",
              // maxLines: 6,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  fontFamily: "calibri"),
            ),
          ),
          SizedBox(
            width: 25,
          ),
          Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/hero.JPG")))),
        ],
      ),
    );
  }
}
