import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart' as p;

import 'audio_file.dart';

class TelechargementPage extends StatefulWidget {
  const TelechargementPage({Key? key}) : super(key: key);

  @override
  _TelechargementPageState createState() => _TelechargementPageState();
}

class _TelechargementPageState extends State<TelechargementPage> {
  List audio_list = [];
  late AudioPlayer advancedPlayer;
  late String title="";
  late String url="";
  late File music;

  void _listofFiles() async {
    final appstorage=await p.getApplicationDocumentsDirectory();
    print('create musics');
    String folderName="musics";
    final dirPath = '${appstorage.path}/musics';
    final Directory _appDocDirFolder =  Directory('${appstorage.path}/$folderName/');
    if(await _appDocDirFolder.exists()){
      setState(() {
        audio_list = io.Directory('${appstorage.path}/$folderName/').listSync();  //use your folder name insted of resume.
        title=audio_list[0].toString().split("musics/")[1].split('.mp3')[0].replaceAll("_", " ").length>20?
        audio_list[0].toString().split("musics/")[1].split('.mp3')[0].replaceAll("_", " ").substring(0,25)+'...'
            :audio_list[0].toString().split("musics/")[1].split('.mp3')[0].replaceAll("_", " ");
        url=audio_list[0].toString();
        music=File(url);
        if (music.existsSync()) {
          music;
        }
      });
    }
    else{
      setState(() {
        audio_list=[];
      });
    }
    print("repertoire");
    print(dirPath);
    print('la taille des telechargements');
    print(audio_list.length);
    print('liste audios 1');
    print(url);
    print("file");
    print(music);
  }
  @override
  void initState() {
    // TODO: implement initState
    _listofFiles();
    advancedPlayer= AudioPlayer();
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
          title: Text("Mes téléchargements",style: TextStyle(
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
              color: Colors.green,
              height: MediaQuery.of(context).size.height*2/3,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, position) {
                  return GestureDetector(
                    onTap: () {
                      /*audio.title = this.audios.allitems[position].title;
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
                      });*/
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
                                  child: Image.asset('assets/images/microphone.png',height: 20,width: 20,color: Colors.green,),
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
                                          this.audio_list[position].toString().split("musics/")[1].split('.mp3')[0].replaceAll("_", " ").length>20?
                                          this.audio_list[position].toString().split("musics/")[1].split('.mp3')[0].replaceAll("_", " ").substring(0,25)+'...'
                                              :this.audio_list[position].toString().split("musics/")[1].split('.mp3')[0].replaceAll("_", " "),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontFamily: "CeraPro",
                                              fontWeight: FontWeight.bold
                                          ),
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
                                    child: Image.asset('assets/images/play.png',height: 20,width: 20,color: Colors.green,),
                                  ),
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: this.audio_list.length,
              ),
            ),
            SizedBox(height: 2,),
            Container(
              height: MediaQuery.of(context).size.height*1/3-93,
              decoration: new BoxDecoration(
                color: Colors.white,
                boxShadow: kElevationToShadow[4],
              ),
              child: Column(
                children: [
                  SizedBox(height: 5,),
                  Center(child: Text(this.title,style: TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontFamily: "CeraPro",
                      fontWeight:
                      FontWeight.bold),),),
                  AudioFile(advancedPlayer:advancedPlayer, audioPath: this.music.path,couleur: Colors.green,isradio: false,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
