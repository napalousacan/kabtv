import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kabtv/controller/appcontroller.dart';
import 'package:kabtv/view/menuscreen.dart';
import 'package:logger/logger.dart';
import 'package:wakelock/wakelock.dart';

import '../constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final logger = Logger();
  @override
  void initState() {
    // TODO: implement initState
    Wakelock.enable();
    super.initState();
    //logger.i(appdetailcontroller.connectionType);
    //logger.i(appdetailcontroller.isLoading,'napal');
    final AppDetailsController appdetailcontroller = Get.put(AppDetailsController());
    startTime();
    //logger.i(appdetailcontroller.AppDetailsList[0]);
  }

  startTime() async {
    var _duration = new Duration(seconds: 5);
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return new Timer(_duration, navigationPage);
      }
    } on SocketException catch (_) {
      showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0))),
          title: new Text('Destiny Tv',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 26,
                  fontFamily: "CeraPro",
                  fontWeight: FontWeight.bold,
                  color: colorPrimary)),
          content: new Text(
            "Problème d\'accès à Internet, veuillez vérifier votre connexion et réessayez !!!",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18,
                fontFamily: "CeraPro",
                fontWeight: FontWeight.normal,
                color: Colors.black),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => SplashScreen()));
                  },
                  child: Container(
                    width: 120,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [colorPrimary, colorPrimaryDark],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                        ),
                        borderRadius: BorderRadius.circular(35)),
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    child: Text(
                      "Réessayer",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "CeraPro",
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }

  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/kab.gif"),
            fit: BoxFit.cover,    // -> 02
          ),
        ),
      ),
    );
  }


  void navigationPage() {
    //Get.to(HomeScreen());
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => MenuScreen(
        )));
  }
}
