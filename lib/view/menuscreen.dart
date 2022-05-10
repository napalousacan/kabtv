import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kabtv/view/audio.dart';
import 'package:kabtv/view/direct.dart';
import 'package:kabtv/view/plus_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wakelock/wakelock.dart';

import '../constants.dart';
import 'homescreen.dart';
class MenuScreen extends StatefulWidget {
  static int idpage = 0;

  @override
  _MenuState createState() => _MenuState();
}

enum AppState { idle, connected, mediaLoaded, error }
const int maxFailedLoadAttempts = 3;
class _MenuState extends State<MenuScreen>
    with AutomaticKeepAliveClientMixin<MenuScreen> {
  @override
  bool get wantKeepAlive => true;
  String title = "Accueil";
  int isShow = 0;
  @override
  void initState() {
    super.initState();
    Wakelock.enable();
  }

  void _launchURL(_url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  @override
  void dispose() {
    super.dispose();
  }

  void pageChanged(int index) {
    setState(() {
      _page = index;
    });
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
        MenuScreen.idpage = index;
        /*if (index == 0) {
          title = "Accueil";
        } else*/
        if (index == 0) {
          title = "Accueil";
        } else if (index == 1) {
          title = "Vidéos";
        } else if (index == 2) {
          title = "Audios";
        }else if (index == 3) {
          title = "Plus";
        }
      },
      children: <Widget>[
        new HomeScreen(),
        new DirectScreen(),
        new AudioScreen(),
        new PlusScreen(),
        /*new YoutubeChannelScreen(
          apiKey: widget.apiResponse.api[2].apiKey,
          channelId: widget.apiResponse.api[2].feedUrl,
        ),*/
      ],
    );
  }

  int _page = 0;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        key: _scaffoldKey,
        /*appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    fontFamily: 'CeraPro',
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              SizedBox(width: 50,)
            ],
          ),
          actions: [
          ],
          centerTitle: true,
          flexibleSpace: Container(
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),*/
        body: buildPageView(),
        bottomNavigationBar: salomonBottomNavigation(),
        backgroundColor: Colors.white,
      ),
    );
  }


  Widget salomonBottomNavigation() {
    return PhysicalModel(
      color: Colors.white,
      elevation: 20,
      child: SalomonBottomBar(
        currentIndex: _page,
        curve: Curves.ease,
        onTap: (i) => setState((){
          _page= i;
          pageController.animateToPage(i,
              duration: Duration(milliseconds: 300), curve: Curves.ease);
        }),
        unselectedItemColor: Colors.white,
        items: [
          SalomonBottomBarItem(
            icon: Image.asset("$imageUri/home.png",
              width: 20,
              height: 20,),
            title: Text(" Accueil",
              style: TextStyle(
            color: Colors.green
            ),),
            selectedColor: Colors.grey,
          ),

          SalomonBottomBarItem(
            icon: Image.asset(
              "$imageUri/jouer.png",
                width: 20,
                height: 20,),
            title: Text("Vidéos",style: TextStyle(
                color: Colors.green
            ),),
            selectedColor: Colors.grey,
          ),

          SalomonBottomBarItem(
            icon: Image.asset(
              "$imageUri/musical.png",
              width: 20,
              height: 20,),
            title: Text("Audios",style: TextStyle(
                color: Colors.green
            ),),
            selectedColor: Colors.grey,
          ),

          SalomonBottomBarItem(
            icon: Image.asset(
              "$imageUri/detail.png",
              width: 20,
              height: 20,),
            title: Text("Plus",
              style: TextStyle(
                color: Colors.green
              ),
            ),
            selectedColor: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget appBar() {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontFamily: 'CeraPro',
                fontWeight: FontWeight.bold,
                fontSize: 22),
          ),
          SizedBox(width: 50,)
        ],
      ),
      actions: [
      ],
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorPrimary, colorPrimary],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
          /*borderRadius:
                  BorderRadius.circular(10.0)*/
        ),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
    );
  }
}
