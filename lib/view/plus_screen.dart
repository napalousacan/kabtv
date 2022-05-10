import 'package:expandable_widgets/expandable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kabtv/view/audio.dart';
import 'package:kabtv/view/direct.dart';
import 'package:kabtv/view/homescreen.dart';
import 'package:kabtv/view/mestelechargements.dart';
import 'package:kabtv/view/replay_audio_screen.dart';
import 'package:kabtv/view/video_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class PlusScreen extends StatefulWidget {
  const PlusScreen({Key? key}) : super(key: key);

  @override
  _PlusScreenState createState() => _PlusScreenState();
}

class _PlusScreenState extends State<PlusScreen> {
  void _launchURL(_url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*1/4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight:Radius.circular(30)),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child:
              Center(
                child: Image.asset("assets/images/logokourel.png"),
              ),
              )
            ),
            Expandable(
              backgroundColor: Colors.green,
                primaryWidget: Container(
                  height: 24,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "$imageUri/detail.png",
                            width: 15,
                            height: 15,
                            color: Colors.white,
                          ),
                          SizedBox(width:3 ,),
                          Text("Plus",
                            style: TextStyle(
                                color: Colors.white,
                              fontSize: 14,
                              fontFamily: "CeraPro",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            height: 17,
                            width: 17,
                            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*3/4,bottom: 4),
                            child: IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.arrow_drop_down_circle), onPressed: () {
                                setState(() {

                                });
                            },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2,),
                      Divider(height: 1,color: Colors.white,)
                    ],
                  ),
                ),
              secondaryWidget: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  height: MediaQuery.of(context).size.height*0.238,
                  child:  Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.to(HomeScreen());
                          },
                          child: Container(
                            height: 40,
                              child:Row(
                                children: [
                                  Image.asset(
                                    "$imageUri/img2.png",
                                    width: 25,
                                    height: 25,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width:20 ,),
                                  Text("Accueil",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: "CeraPro",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                          ),
                        ),
                        Divider(height: 0,color: Colors.white,),
                        GestureDetector(
                          onTap: (){
                            Get.to(DirectScreen());
                          },
                          child: Container(
                            height: 40,
                            child:Row(
                              children: [
                                Image.asset(
                                  "$imageUri/img2.png",
                                  width: 25,
                                  height: 25,
                                  color: Colors.white,
                                ),
                                SizedBox(width:20 ,),
                                Text("KAB TV",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: "CeraPro",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(height: 0,color: Colors.white,),
                        GestureDetector(
                          onTap: (){
                            Get.to(AudioScreen());
                          },
                          child: Container(
                            height: 40,
                            child:Row(
                              children: [
                                Image.asset(
                                  "$imageUri/img2.png",
                                  width: 25,
                                  height: 25,
                                  color: Colors.white,
                                ),
                                SizedBox(width:20 ,),
                                Text("KAB Radio",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: "CeraPro",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(height: 0,color: Colors.white,),
                        GestureDetector(
                          onTap: (){
                            Get.to(ReplayAudio(
                              couleur: Colors.green,
                            ));
                          },
                          child: Container(
                            height: 40,
                            child:Row(
                              children: [
                                Image.asset(
                                  "$imageUri/img2.png",
                                  width: 25,
                                  height: 25,
                                  color: Colors.white,
                                ),
                                SizedBox(width:20 ,),
                                Text("Audiothèque",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: "CeraPro",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(height: 0,color: Colors.white,),
                        GestureDetector(
                          onTap: (){
                            Get.to(TelechargementPage());
                          },
                          child: Container(
                            height: 40,
                            child:Row(
                              children: [
                                Image.asset(
                                  "$imageUri/img2.png",
                                  width: 25,
                                  height: 25,
                                  color: Colors.white,
                                ),
                                SizedBox(width:20 ,),
                                Text("Mes téléchargements",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: "CeraPro",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(height: 0,color: Colors.white,),
                      ],
                    ),
                ),
              ),
            ),

            Expandable(
              backgroundColor: Colors.green,
              primaryWidget: Container(
                height: 24,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "$imageUri/view.png",
                          width: 15,
                          height: 15,
                          color: Colors.white,
                        ),
                        SizedBox(width:3 ,),
                        Text("Suivez-nous",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "CeraPro",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          height: 17,
                          width: 17,
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.60,bottom: 4),
                          child: IconButton(
                            color: Colors.white,
                            icon: Icon(Icons.arrow_drop_down_circle), onPressed: () {
                            setState(() {

                            });
                          },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2,),
                    Divider(height: 1,color: Colors.white,)
                  ],
                ),
              ),
              secondaryWidget: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Container(
                  height: MediaQuery.of(context).size.height*0.15,
                  child:  Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          _launchURL('www.facebook.com');
                        },
                        child: Container(
                          height: 40,
                          child:Row(
                            children: [
                              Image.asset(
                                "$imageUri/facebook.png",
                                width: 25,
                                height: 25,
                              ),
                              SizedBox(width:20 ,),
                              Text("Facebook",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "CeraPro",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(height: 0,color: Colors.white,),
                      GestureDetector(
                        onTap: (){
                          _launchURL('www.facebook.com');
                        },
                        child: Container(
                          height: 40,
                          child:Row(
                            children: [
                              Image.asset(
                                "$imageUri/instagram.png",
                                width: 20,
                                height: 20,
                                color: Colors.white,
                              ),
                              SizedBox(width:25 ,),
                              Text("Instagram",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "CeraPro",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(height: 0,color: Colors.white,),
                      GestureDetector(
                        onTap: (){
                          _launchURL('www.facebook.com');
                        },
                        child: Container(
                          height: 40,
                          child:Row(
                            children: [
                              Image.asset(
                                "$imageUri/twitter.png",
                                width: 25,
                                height: 25,
                                color: Colors.white,
                              ),
                              SizedBox(width:20 ,),
                              Text("Twitter",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "CeraPro",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(height: 0,color: Colors.white,),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
