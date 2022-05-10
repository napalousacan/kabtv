import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kabtv/controller/appcontroller.dart';
import 'package:kabtv/model/Model.dart';
import 'package:kabtv/view/audio_file.dart';
import 'package:kabtv/view/detail_replay_audio_screen.dart';
import 'package:http/http.dart' as http;

class ReplayAudios extends StatefulWidget {
  Dataitem audio;
  Color couleur;
   ReplayAudios({required this.audio,required this.couleur});

  @override
  _ReplayAudiosState createState() => _ReplayAudiosState();
}

class _ReplayAudiosState extends State<ReplayAudios> {
  final AppDetailsController c = Get.find();
  late Data audios;

  late Dataitem audio;
  late AudioPlayer advancedPlayer;
  late Color couleur;
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

  fetchDataAll(String url) async{
    var client = http.Client();
    var response = await client.get(Uri.parse(url));
    if(response.statusCode==200){
      Data jsonString = Data.fromJson(json.decode(response.body));
      if(jsonString.allitems !=null){
        audios=jsonString;
        audio=jsonString.allitems[0];
        setState(() {
          audios;
          audio;
        });

      }
      else{
        setState(() {
          audios;
          audio;
        });
      }
    }
    else{
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    fetchDataAll(widget.audio.feedUrl);
    advancedPlayer= AudioPlayer();
    print(widget.couleur);
    if(widget.couleur!=null){
      couleur=widget.couleur;
      setState(() {
        couleur;
      });
    }
    else{
      couleur=colors[0];
      setState(() {
        couleur;
      });
    }
    super.initState();
  }

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
      title: Text("KAB Audios",style: TextStyle(
        fontSize: 18,
        fontFamily: "CeraPro",
        fontWeight: FontWeight.bold,
      )),
      backgroundColor: Colors.green,
    ),
      body: Container(
          padding: EdgeInsets.all(0.0),
          child:Column(
            children: [
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
                  ],
                ),
              ),
              SizedBox(height: 3,),
              Container(
                height: MediaQuery.of(context).size.height*2/3,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height*2/3,
                      width: 110,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(9),bottomRight: Radius.circular(9)),
                        boxShadow: kElevationToShadow[4],
                      ),
                        child: Container(
                          height: 105,
                          child: Obx(() {
                            if (c.isLoading.value)
                              return Center(child: CircularProgressIndicator());
                            else {
                              return ListView.separated(
                                scrollDirection: Axis.vertical,
                                itemCount: c.Audiotheques.length,
                                separatorBuilder: (context, _) =>
                                    SizedBox(width: 8,),
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                      onTap: (){
                                        print(c.Audiotheques[index].feedUrl);
                                        fetchDataAll(c.Audiotheques[index].feedUrl);
                                        advancedPlayer.stop();
                                        advancedPlayer.setUrl(audio.streamUrl);
                                        advancedPlayer.play(audio.streamUrl);
                                        couleur=colors[index];
                                        setState(() {
                                          couleur;
                                        });
                                        /*Get.to(DetailScreen(
                                          dataitem: c.Audiotheques[index],
                                        ));*/
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

                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        color: Colors.green,
                        height: MediaQuery.of(context).size.height*2/3,
                        width: MediaQuery.of(context).size.width-125,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, position) {
                            return GestureDetector(
                            onTap: () {
                              audio.title = this.audios.allitems[position].title;
                              audio.feedUrl = this.audios.allitems[position].feedUrl;
                              audio.sdimage = this.audios.allitems[position].sdimage;
                              audio.streamUrl =
                                  this.audios.allitems[position].streamUrl;
                              audio.desc = this.audios.allitems[position].desc;
                              audio.type = this.audios.allitems[position].type;
                              advancedPlayer.stop();
                              advancedPlayer.setUrl(audio.streamUrl);
                              advancedPlayer.play(audio.streamUrl);
                              setState(() {
                                audio;
                              });
                            },
                              child: PhysicalModel(
                                color: Colors.white,
                                elevation: 5,
                                  child: Container(
                                    height: 80,
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      children: [
                                                Container(
                                                  height: MediaQuery.of(context).size.height,
                                                  width: 80,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(12.0),
                                                    child: Image.asset('assets/images/microphone.png',height: 20,width: 20,),
                                                  )
                                                ),


                                        Padding(
                                          padding: const EdgeInsets.only(top: 5,left: 0),
                                          child: Container(
                                              alignment: Alignment.centerRight,
                                              child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(top: 10),
                                                child: Text(
                                                  this.audios.allitems[position].title.length>13?
                                                  this.audios.allitems[position].title.substring(0,13)+'...':this.audios.allitems[position].title,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: "CeraPro",
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                this.audios.allitems[position].desc,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontFamily: "CeraPro",
                                                ),
                                              ),
                                            ],
                                          )),
                                        ),
                                        Expanded(
                                            child: Container(
                                              alignment: Alignment.centerRight,
                                              child: Padding(
                                                padding: const EdgeInsets.all(12.0),
                                                child: Image.asset('assets/images/play.png',height: 20,width: 20,),
                                              ),
                                            )
                                        ),
                                      ],
                                    ),
                                  ),
                              ),
                            );
                          },
                          itemCount: this.audios.allitems.length,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2,),
              Container(
                height: MediaQuery.of(context).size.height*1/4-46,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  boxShadow: kElevationToShadow[4],
                ),
                  child: Column(
                    children: [
                      Center(child: Text(audio.title,style: TextStyle(
                          fontSize: 18,
                          color: Colors.green,
                          fontFamily: "CeraPro",
                          fontWeight:
                          FontWeight.bold),),),
                      AudioFile(advancedPlayer:advancedPlayer, audioPath: audio.streamUrl,couleur: couleur,isradio: false,),
                    ],
                  ),
              ),

            ],
          )),
    );
  }
}
