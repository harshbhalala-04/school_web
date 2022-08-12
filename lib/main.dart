import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_web/routes.dart';
import 'package:url_strategy/url_strategy.dart';
import 'firebase_options.dart';

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    // TODO: implement initState
    Flurorouter.setUpRouter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      title: 'SXCMI',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Flurorouter.router.generator,
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
    );
  }
}


