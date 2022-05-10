import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kabtv/model/Model.dart';
import 'package:kabtv/model/Modelclass.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../constants.dart';

class VideoScreen extends StatefulWidget {
  Dataitem model;
  List<Dataitem> listmodels;
   VideoScreen({
    required this.model,
    required this.listmodels
});

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late YoutubePlayerController _controller;
  late Dataitem onPlay;

  @override
  void initState() {
    // TODO: implement initState
    onPlay=widget.model;
    setState(() {
      onPlay;
    });

    _controller = YoutubePlayerController(
        initialVideoId:
        onPlay.streamUrl.split("=")[1],
        flags: YoutubePlayerFlags(
          controlsVisibleAtStart: false,
          autoPlay: true,
          hideThumbnail: true,
          mute: false,
        ));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Vidéos",style: TextStyle(
          fontSize: 18,
          fontFamily: "CeraPro",
          fontWeight: FontWeight.bold,
        )),
        backgroundColor: Colors.green,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 230,
              width: double.infinity,
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressColors: ProgressBarColors(bufferedColor: colorPrimary),
                progressIndicatorColor: colorPrimary,
              ),
            ),
            Container(
              height: 60,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: colorPrimary)
              ),
              child: Row(
                children: <Widget>[
                  CachedNetworkImage(
                    width: 80,
                    height: 50,
                    imageUrl: onPlay.sdimage,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Image.asset(
                      "assets/images/logokourel.png",
                      fit: BoxFit.contain,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      "assets/images/logokourel.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Container(
                              child: Text(
                                onPlay.title,
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "CeraPro",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(top: 7),
                              child: Text(
                                onPlay.desc,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "CeraPro",
                                    fontWeight: FontWeight.normal,
                                    color: Colors.green),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 2,),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, position) {
                  return GestureDetector(
                    onTap: (){
                      onPlay=widget.listmodels[position];
                      setState(() {
                        onPlay;
                      });
                      _controller.load(onPlay.streamUrl.split("=")[1]);
                    },
                    child: PhysicalModel(
                      color: Colors.white,
                      elevation: 5,
                      child: Padding(
                        padding:  EdgeInsets.only(right: 8,left: 8,bottom: 2),
                        child: Container(
                          height: 80,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          4),
                                      child:
                                      Container(
                                        height: MediaQuery.of(context).size.height,
                                        width: 120,
                                        child: CachedNetworkImage(
                                          height:MediaQuery.of(context).size.height,
                                          width: 120,
                                          imageUrl: widget.listmodels[position].sdimage,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Image.asset(
                                                "assets/images/logokourel.png",
                                                fit: BoxFit.contain,
                                                height: 80,
                                                width: 120,
                                              ),
                                          errorWidget:
                                              (context, url, error) =>
                                              Image.asset(
                                                "assets/images/logokourel.png",
                                                fit: BoxFit.contain,
                                                height: 80,
                                                width: 120,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 120,
                                      width: 120,
                                      child: Center(
                                        child: Container(
                                          child: Image.asset(
                                            "assets/images/play.png",
                                            height: 30,
                                            width: 30,
                                            //color: Colors.orangeAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]
                              ),
                              SizedBox(width: 10,),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Container(child: Column(
                                  children: [
                                    Text(
                                      widget.listmodels[position].title,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontFamily: "CeraPro",
                                      ),
                                    ),
                                    Text(
                                      widget.listmodels[position].desc,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.green,
                                        fontFamily: "CeraPro",
                                      ),
                                    ),
                                  ],
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: widget.listmodels.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
