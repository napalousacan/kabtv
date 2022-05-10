import 'dart:async';
import 'dart:math';

import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kabtv/controller/appcontroller.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kabtv/view/detail_replay_audio_screen.dart';
import 'package:kabtv/view/replay_audio_screen.dart';
import 'package:kabtv/view/replay_audios_screen.dart';
import 'package:kabtv/view/video_screen.dart';
/*import 'package:hardware_buttons/hardware_buttons.dart';
import 'package:hardware_buttons/hardware_buttons.dart' as HardwareButtons;*/
import 'package:logger/logger.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wakelock/wakelock.dart';

class DirectScreen extends StatefulWidget {
  const DirectScreen({Key? key}) : super(key: key);

  @override
  _DirectScreenState createState() => _DirectScreenState();
}

class _DirectScreenState extends State<DirectScreen> {
  final AppDetailsController c = Get.find();
  final _random = Random();
  final logger = Logger();
  late BetterPlayerController _betterPlayerController;

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
  ];
  //late StreamSubscription<HardwareButtons.HomeButtonEvent> _homeButtonSubscription;
  var betterPlayerConfiguration = BetterPlayerConfiguration(
    autoPlay: true,
    looping: true,
    fullScreenByDefault: false,
    allowedScreenSleep: false,
    //autoDetectFullscreenDeviceOrientation:true,

    translations: [
      BetterPlayerTranslations(
        languageCode: "fr",
        generalDefaultError: "Impossible de lire la vidéo",
        generalNone: "Rien",
        generalDefault: "Défaut",
        generalRetry: "Réessayez",
        playlistLoadingNextVideo: "Chargement de la vidéo suivante",
        controlsNextVideoIn: "Vidéo suivante dans",
        overflowMenuPlaybackSpeed: "Vitesse de lecture",
        overflowMenuSubtitles: "Sous-titres",
        overflowMenuQuality: "Qualité",
        overflowMenuAudioTracks: "Audio",
        qualityAuto: "Auto",
      ),
    ],
    deviceOrientationsAfterFullScreen: [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,

    ],
    //autoDispose: true,
    controlsConfiguration: BetterPlayerControlsConfiguration(
      iconsColor: Colors.white,
      controlBarColor: Colors.black12,
      liveTextColor: Colors.red,
      playIcon: Icons.play_arrow,
      enablePip: true,
      enableFullscreen: true,
      enableSubtitles: false,
      enablePlaybackSpeed: false,
      loadingColor: Colors.white,
      enableSkips: false,
      overflowMenuIconsColor:Colors.white,
      enableRetry: true,
      //enableOverflowMenu: false,
      //backgroundColor: Colors.white
    ),
  );
  GlobalKey _betterPlayerKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logger.i(c.Direct.streamUrl);
    Wakelock.enable();
    //betterPlayerConfiguration;
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      c.Direct.streamUrl,
      liveStream: true,
      asmsTrackNames: ["3G 360p", "SD 480p", "HD 1080p"],
    );

    _betterPlayerController.setupDataSource(dataSource)
        .then((response) {
    })
        .catchError((error) async {
    });
    _betterPlayerController.setBetterPlayerGlobalKey(_betterPlayerKey);
    _betterPlayerController.addEventsListener((error) => {
      if(error.betterPlayerEventType.index==9){
        logger.i(error.betterPlayerEventType.index,"index event"),
        Wakelock.enable(),
        _betterPlayerController.retryDataSource()
      }
    });
  }

  initPlayer(String directUrl){
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      directUrl,
      liveStream: true,
      asmsTrackNames: ["3G 360p", "SD 480p", "HD 1080p"],
    );
    if (_betterPlayerController != null) {
      _betterPlayerController.pause();
      _betterPlayerController.setupDataSource(betterPlayerDataSource);
    } else {
      _betterPlayerController = BetterPlayerController(betterPlayerConfiguration,
          betterPlayerDataSource: betterPlayerDataSource);
    }
    _betterPlayerController.setBetterPlayerGlobalKey(_betterPlayerKey);
  }

  @override
  void dispose() {
    super.dispose();
    Wakelock.enable();
    //_homeButtonSubscription?.cancel();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    _betterPlayerController?.dispose();
    Wakelock.enable();
    super.deactivate();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Kab TV",style: TextStyle(
          fontSize: 18,
          fontFamily: "CeraPro",
          fontWeight: FontWeight.bold,
        )),
        backgroundColor: Colors.green,
        actions: <Widget>[
          Image.asset("assets/images/logokourel.png")
        ],
      ),
      body: Container(
        child: Column(
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

            /// Playlists audios
            Padding(
              padding: EdgeInsets.only(right: 0,left: 0),
              child: Card(
                elevation: 5,
                child: Container(
                  height: 110,
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
                                          fontFamily: "CeraPro",
                                          ),)
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
                          "KAB TV en direct",
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
            _betterPlayerController!=null?
            AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer(
                controller: _betterPlayerController,
                key: _betterPlayerKey,
              ),
            ):Container(),
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
                          "Dernières vidéos",
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
            SizedBox(height: 2,),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, position) {
                  return GestureDetector(
                    onTap: (){
                      Get.to(VideoScreen(
                        model: c.Videotheques[position],
                        listmodels: c.Videotheques,
                      ));
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
                                    imageUrl: c.Videotheques[position].sdimage,
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
                                      c.Videotheques[position].title,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontFamily: "CeraPro",
                                          ),
                                    ),
                                    Text(
                                      c.Videotheques[position].desc,
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
                itemCount: c.Videotheques.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
