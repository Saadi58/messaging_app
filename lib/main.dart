import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messaging_app/Screens/login_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  MaterialColor mycolor = const MaterialColor(0xFFF2AE3B, <int, Color>{
    50: Color.fromRGBO(242, 174, 59, .1),
    100: Color.fromRGBO(242, 174, 59, .2),
    200: Color.fromRGBO(242, 174, 59, .3),
    300: Color.fromRGBO(242, 174, 59, .4),
    400: Color.fromRGBO(242, 174, 59, .5),
    500: Color.fromRGBO(242, 174, 59, .6),
    600: Color.fromRGBO(242, 174, 59, .7),
    700: Color.fromRGBO(242, 174, 59, .8),
    800: Color.fromRGBO(242, 174, 59, .9),
    900: Color.fromRGBO(242, 174, 59, 1),
  },
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Messaging App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: mycolor,
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const spinkit = SpinKitWave(
      color: Color(0xFFF2AE3B),
      size: 50.0,
    );
    return Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/logo.png",
              height: MediaQuery.of(context).size.height * 0.6,
              width: 350,
            ),
            const SizedBox(
              height: 25,
            ),
            spinkit,
          ],
        ));
  }
}
