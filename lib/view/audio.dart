import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kabtv/controller/appcontroller.dart';
import 'package:kabtv/model/Modelclass.dart';
import 'package:kabtv/view/detail_replay_audio_screen.dart';
import 'package:kabtv/view/replay_audio_screen.dart';
import 'package:kabtv/view/replay_audios_screen.dart';
import 'package:logger/logger.dart';
import 'audio_file.dart';
import 'package:path_provider/path_provider.dart' as p;

class AudioScreen extends StatefulWidget {
  const AudioScreen({Key? key}) : super(key: key);

  @override
  _AudioScreenState createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final AppDetailsController c = Get.find();

  ModelClass OnTop=new ModelClass(title: '', feedUrl: '', sdimage: '', streamUrl: '', desc: '', type: '');

  late AudioPlayer advancedPlayer;

  Future <List<Directory>?> _getExternalStoragePath(){
    return p.getExternalStorageDirectories(type: p.StorageDirectory.documents);
  }
  bool isradio=false;

  initPlayer() async{
    final dirlist=await _getExternalStoragePath();
    final path = dirlist![0].path;
    //Directory(path).list(recursive: true, followLinks: false)
    await for (var entity in
    Directory(path).list(recursive: true, followLinks: false)) {
      print(entity.path);
      print("napal");
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    OnTop.title=c.Derniersaudios[0].title;
    OnTop.feedUrl=c.Derniersaudios[0].feedUrl;
    OnTop.sdimage=c.Derniersaudios[0].sdimage;
    OnTop.streamUrl=c.Derniersaudios[0].streamUrl;
    OnTop.desc=c.Derniersaudios[0].desc;
    OnTop.type=c.Derniersaudios[0].type;
    setState(() {
      OnTop;
    });

    advancedPlayer= AudioPlayer();
    initPlayer();
  }

  List colors=[
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.black,
    Colors.red,
    Colors.lightGreen,
    Colors.pinkAccent,
    Colors.lightBlueAccent,
    Colors.orangeAccent,
    Colors.brown,
    Colors.teal,
    Colors.blueAccent,
    Colors.deepPurple,
    Colors.lightBlueAccent,
    Colors.purple,
    Colors.teal,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.teal,
    Colors.orangeAccent,
    Colors.brown,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.black,
    Colors.red,
    Colors.lightGreen,
    Colors.pinkAccent,
    Colors.lightBlueAccent,
    Colors.orangeAccent,
    Colors.brown,
    Colors.teal,
    Colors.blueAccent,
    Colors.deepPurple,
    Colors.lightBlueAccent,
    Colors.purple,
    Colors.teal,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.teal,
    Colors.orangeAccent,
    Colors.brown,
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    advancedPlayer.stop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Audiothèque",style: TextStyle(
          fontSize: 18,
          fontFamily: "CeraPro",
          fontWeight: FontWeight.bold,
        )),
        backgroundColor: Colors.green,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 7),
            child: GestureDetector(
                onTap: (){
                  OnTop.title=c.Radio.title;
                  OnTop.feedUrl=c.Radio.feedUrl;
                  OnTop.sdimage=c.Radio.sdimage;
                  OnTop.streamUrl=c.Radio.streamUrl;
                  OnTop.desc=c.Radio.desc;
                  OnTop.type=c.Radio.type;
                  isradio=true;
                  advancedPlayer.stop();
                  advancedPlayer.setUrl(OnTop.streamUrl);
                  advancedPlayer.play(OnTop.streamUrl);
                  setState(() {
                    OnTop;
                    isradio;
                  });
                },
                child: Image.asset("assets/images/radio.png",height: 30,width: 30,)
            ),
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(children: [
            ///
            ///
            Container(
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8,left: 8),
                    child: Row(
                      children: [
                        Container(
                          decoration: new BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          width: 5,
                          height: 15,
                        ),
                        SizedBox(width: 5,),
                        Text(
                          "Playlists audios",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.green,
                              fontFamily: "CeraPro",
                              fontWeight:
                              FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(ReplayAudio(
                        couleur: Colors.green,
                      ));
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 8,left: 8),
                      child: Icon(
                        Icons.playlist_add,
                        size: 26,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 0,left: 0),
              child: Card(
                elevation: 5,
                child: Container(
                  height: 105,
                  child: Obx(() {
                    if (c.isLoading.value)
                      return Center(child: CircularProgressIndicator());
                    else {
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: c.Audiotheques.length,
                        separatorBuilder: (context, _) =>
                            SizedBox(width: 8,),
                        itemBuilder: (context, index) =>
                            GestureDetector(
                              onTap: (){
                                advancedPlayer.dispose();
                                Get.to(ReplayAudios(
                                  audio: c.Audiotheques[index],
                                  couleur: colors[index],
                                ));
                              },
                              child: Container(
                                child: Center(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5,left: 2),
                                        child: Container(
                                          height: 70,
                                          width: 70,
                                          decoration: new BoxDecoration(
                                            color:colors[index],
                                            //color: Colors.primaries[_random.nextInt(Colors.primaries.length)]
                                            //[_random.nextInt(9) * 100],
                                            shape: BoxShape.circle,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                            child: Image.asset('assets/images/musical.png',color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Text(c.Audiotheques[index].title,style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontFamily: "CeraPro"),)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      );
                    }
                  }),
                ),
              ),
            ),
            Obx((){
    if (c.isLoading.value)
    return Center(child: CircularProgressIndicator());
    else {
      return
          CarouselSlider(
            options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: false,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
            ),
            items: c.Membres.map((element) => Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                child: Container(
                  margin: EdgeInsets.only(top: 4,bottom: 4),
                  width: MediaQuery.of(context).size.width-120,
                  child: Stack(
                    children:
                    [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        imageUrl: element.sdimage,
                        fit: BoxFit.cover,
                        width: Get.width,
                        placeholder: (context, url) =>
                            Image.asset(
                              "assets/images/logokourel.png",
                              fit: BoxFit.cover,
                              width: Get.width,
                            ),
                        errorWidget:
                            (context, url, error) =>
                            Image.asset(
                              "assets/images/logokourel.png",
                              fit: BoxFit.cover,
                              width: Get.width,
                            ),
                      ),

                    ),
                      Positioned(
                        // The Positioned widget is used to position the text inside the Stack widget
                        bottom: 0,
                        child: Container(
                          width: Get.width,
                          color: Colors.white70,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                element.title,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.green,
                                    fontFamily: "CeraPro",
                                    fontWeight:
                                    FontWeight.bold),
                              ),
                              Text(
                                element.desc,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.green,
                                    fontFamily: "CeraPro",
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]
                  ),
                ),
              ),
            )).toList(),
          );
    }
            }),
            Center(child: Text(OnTop.title,style: TextStyle(
                fontSize: 18,
                color: Colors.green,
                fontFamily: "CeraPro",
                fontWeight:
                FontWeight.bold),),),
            Container(
              height: 120,
              child: AudioFile(advancedPlayer:advancedPlayer, audioPath: OnTop.streamUrl,couleur: Colors.green,isradio: isradio,),
            ),
            SizedBox(height: 5,),
            Container(
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8,left: 8),
                    child: Row(
                      children: [
                        Container(
                          decoration: new BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          width: 5,
                          height: 15,
                        ),
                        SizedBox(width: 5,),
                        Text(
                          "Derniers audios",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.green,
                              fontFamily: "CeraPro",
                              fontWeight:
                              FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              height: 170,
                child: Obx(() {
              if (c.isLoading.value)
                return Center(child: CircularProgressIndicator());
              else {
                return
                  ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: c.Derniersaudios.length,
                    separatorBuilder: (context, _) =>
                        SizedBox(width: 8,),
                    itemBuilder: (context, index) =>
                        GestureDetector(
                          onTap: (){
                            OnTop.title=c.Derniersaudios[index].title;
                            OnTop.feedUrl=c.Derniersaudios[index].feedUrl;
                            OnTop.sdimage=c.Derniersaudios[index].sdimage;
                            OnTop.streamUrl=c.Derniersaudios[index].streamUrl;
                            OnTop.desc=c.Derniersaudios[index].desc;
                            OnTop.type=c.Derniersaudios[index].type;
                            advancedPlayer.stop();
                            advancedPlayer.setUrl(OnTop.streamUrl);
                            advancedPlayer.play(OnTop.streamUrl);
                            isradio=false;
                            setState(() {
                              OnTop;
                              isradio;
                            });
                          },
                          child: Container(
                            height: 120,
                            width: 150,
                              decoration: new BoxDecoration(
                                color: colors[index],
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                              ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/musical.png",height: 70,width: 70,color: Colors.white,),
                                SizedBox(height: 8,),
                                Center(
                                  child: Text(
                                    c.Derniersaudios[index].title,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontFamily: "CeraPro",
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                  );
              }
            })),
            SizedBox(height: 10,),
            ///
            ///
            /// liste audio
          ],
          
          ),
        ),
      ),
    );
  }
}
