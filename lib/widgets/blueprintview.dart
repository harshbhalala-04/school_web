import 'package:flutter/material.dart';
import 'package:school_web/theme.dart';
import 'package:school_web/widgets/side_layout.dart';

import 'desktop_appbar.dart';
import 'footer.dart';

class Blueprintview extends StatefulWidget {
  const Blueprintview({super.key});

  @override
  State<Blueprintview> createState() => _BlueprintviewState();
}

class _BlueprintviewState extends State<Blueprintview> {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    print(deviceSize);
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: themeColor),
      ),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: deviceSize.width > 768
              ? const PreferredSize(
                  child: DesktopAppBar(),
                  preferredSize: Size.fromHeight(70),
                )
              : AppBar(
                  backgroundColor: Colors.white,
                  iconTheme: const IconThemeData(color: Colors.black),
                ),
          drawer: deviceSize.width > 768
              ? Container()
              : Drawer(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: SideLayout(
                    pageIndex: 0,
                  ),
                ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(
                  height: 50,
                ),
                Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Blueprinttableview extends StatelessWidget {
  const Blueprinttableview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
