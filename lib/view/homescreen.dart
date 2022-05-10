
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kabtv/view/audio.dart';
import 'package:kabtv/view/direct.dart';
import 'package:kabtv/view/emission_screen.dart';
import 'package:kabtv/view/replay_audio_screen.dart';
import 'package:wakelock/wakelock.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width*4/5,
          decoration: const BoxDecoration(
            image: DecorationImage(
            image: AssetImage('assets/images/img.png'),
            //fit: BoxFit.cover
            fit: BoxFit.fill),
          ),
          ),
          SizedBox(height: 25,),
          Padding(
            padding: const EdgeInsets.only(left: 20,),
            child: Container(
              color: Colors.white,
              height: 30,
              child: Row(
                children: [
                  Container(
                      height: 30,
                      width: 40,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/img1.png'),
                            fit: BoxFit.fill),)
                  ),
                  SizedBox(width: 10,),
                  Expanded(child: Text("Catégories",style: TextStyle(
                    fontSize: 18,
                    fontFamily: "CeraPro",
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),),
                  ),
                ],
              ),
            ),
          ),
          ///
          ///
          ///
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: GestureDetector(
                  onTap: (){
                    Get.to(DirectScreen());
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 7,bottom: 7),
                        child: Container(
                          width: 15,
                          height: 60,
                          decoration: new BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(7),bottomRight: Radius.circular(7)),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("KAB TV",style: TextStyle(
                                fontSize: 18,
                                fontFamily: "CeraPro",
                                fontWeight: FontWeight.bold,
                                  color: Colors.black
                              ),),
                              Text("En direct",style: TextStyle(
                                fontSize: 12,
                                fontFamily: "CeraPro",
                                fontWeight: FontWeight.bold,
                                  color: Colors.black
                              ),)
                            ],
                          ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: 150,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/img4.png'),
                                fit: BoxFit.fill),)
                      ),
                    ],
                  ),
                ),
              ),
          ),
          ///
          ///
          ///
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Container(
              color: Colors.green,
              height: 2,
            ),
          ),
          ///
          ///
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: GestureDetector(
                  onTap: (){
                    Get.to(AudioScreen());
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 7,bottom: 7),
                        child: Container(
                          width: 15,
                          height: 60,
                          decoration: new BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(7),bottomRight: Radius.circular(7)),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("KAB FM",style: TextStyle(
                              fontSize: 18,
                              fontFamily: "CeraPro",
                              fontWeight: FontWeight.bold,
                                color: Colors.black
                            ),),
                            Text("On Air",style: TextStyle(
                              fontSize: 12,
                              fontFamily: "CeraPro",
                              fontWeight: FontWeight.bold,
                                color: Colors.black
                            ),)
                          ],
                        ),
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height,
                          width: 150,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/img5.png'),
                                fit: BoxFit.fill),)
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Container(
              color: Colors.green,
              height: 2,
            ),
          ),
          GestureDetector(
            onTap: (){
              Get.to(EmissionScreen());
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 7,bottom: 7),
                      child: Container(
                        width: 15,
                        height: 60,
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(7),bottomRight: Radius.circular(7)),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("KAB Vidéos",style: TextStyle(
                            fontSize: 18,
                            fontFamily: "CeraPro",
                            fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),),
                          Text("En replay",style: TextStyle(
                            fontSize: 12,
                            fontFamily: "CeraPro",
                            fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),)
                        ],
                      ),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height,
                        width: 150,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/img6.png'),
                              fit: BoxFit.fill),)
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Container(
              color: Colors.green,
              height: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: GestureDetector(
              onTap: (){
                Get.to(ReplayAudio(
                  couleur: Colors.green,
                ));
              },
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 7,bottom: 7),
                      child: Container(
                        width: 15,
                        height: 60,
                        decoration: new BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(7),bottomRight: Radius.circular(7)),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("KAB Audios",style: TextStyle(
                            fontSize: 18,
                            fontFamily: "CeraPro",
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),),
                          Text("En MP3",style: TextStyle(
                            fontSize: 12,
                            fontFamily: "CeraPro",
                            fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),)
                        ],
                      ),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height,
                        width: 150,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/img7.png'),
                              fit: BoxFit.fill),)
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: Container(
              color: Colors.green,
              height: 2,
            ),
          ),
        ],
      ),
    );
  }
}
