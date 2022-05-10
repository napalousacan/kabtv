import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kabtv/controller/appcontroller.dart';
import 'package:kabtv/model/Model.dart';
import 'package:kabtv/view/audio_file.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class DetailScreen extends StatefulWidget {
  Dataitem dataitem;
   DetailScreen({required this.dataitem});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final AppDetailsController c = Get.find();
  late Data audios;

  late Dataitem audio;
  late AudioPlayer advancedPlayer;


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
    advancedPlayer= AudioPlayer();
    c.fetchAllAudios(widget.dataitem.feedUrl);
    fetchDataAll(widget.dataitem.feedUrl);
    //logger.i(audios.allitems[0].title,'mon titre');
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
        title: Text("Audios",style: TextStyle(
          fontSize: 18,
          fontFamily: "CeraPro",
          fontWeight: FontWeight.bold,
        )),
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: Column(
          children: [
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
            Center(child: Text(audio.title,style: TextStyle(
                fontSize: 18,
                color: Colors.green,
                fontFamily: "CeraPro",
                fontWeight:
                FontWeight.bold),),),
            Container(
              height: 120,
              child: AudioFile(advancedPlayer:advancedPlayer, audioPath: audio.streamUrl,couleur: Colors.green,isradio: false,),
            ),
            SizedBox(height: 5,),
          ],
        ),
      ),
    );
  }
}
