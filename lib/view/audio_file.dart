import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:codefirst_progress_dialog/codefirst_progress_dialog.dart';
import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:audiotagger/audiotagger.dart';
import 'dart:io' as io;

class AudioFile extends StatefulWidget {
  final AudioPlayer advancedPlayer;
  final String audioPath;
  Color couleur;
  bool isradio;
   AudioFile({required this.advancedPlayer,required this.audioPath,required this.couleur,required this.isradio});

  @override
  _AudioFileState createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  bool isPlaying=false;
  bool isPaused=false;
  bool isRepeat=false;
  bool _isLoading=false;
  ReceivePort _port = ReceivePort();
  List audio_list = [];
  late String kUrl = "",
      checker,
      image = "",
      title = "",
      album = "",
      artist = "",
      lyrics,
      has_320,
      rawkUrl;
  late String progress;
  late double progres=0;
  late String _fileFullPath;
  Color color= Colors.black;
  late ProgressDialog pr;
  List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];
  late Dio dio;
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    // For your reference print the AppDoc directory
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.txt');
  }

  Future telecharger(String url) async{
    var status = await Permission.storage.request();
    print("entree telechargement");
    print(status.isGranted);
    if (status.isGranted) {
      print("boucle telechargement");
      print(url);
      final baseStorage=await p.getExternalStorageDirectory();
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: baseStorage!.path,
        showNotification: true, // show download progress in status bar (for Android)
        openFileFromNotification: true, // click on notification to open downloaded file (for Android)
      );
    }
  }



  void _listofFiles() async {
    String directory;
    directory = (await getApplicationDocumentsDirectory()).path;
    setState(() {
      audio_list = io.Directory("$directory/musics").listSync();  //use your folder name insted of resume.
    });
    print('liste audios');
    print(audio_list);
  }


  @override
  void initState(){
    dio=Dio();
    //pickFile();
    _localPath;
    //readcontent();
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      if(status==DownloadTaskStatus.complete){
        print("telechargement complet");
      }
      setState((){ });
    });

    FlutterDownloader.registerCallback(downloadCallback);
    //_listofFiles();
    super.initState();
    if(widget.isradio==false){
      this.widget.advancedPlayer.onDurationChanged.listen((d) {setState(() {
        _duration=d;
      });});
      this.widget.advancedPlayer.onAudioPositionChanged.listen((p) {setState(() {
        _position=p;
      });});
    }

    if(this.widget.audioPath!=""){
      this.widget.advancedPlayer.setUrl(this.widget.audioPath);
      this.widget.advancedPlayer.play(this.widget.audioPath);
      isPlaying=true;
      this.widget.advancedPlayer.onPlayerCompletion.listen((event) {
        setState(() {
          _position = Duration(seconds: 0);
          if(isRepeat==true){
            isPlaying=true;
          }else{

            isPlaying=false;
            isRepeat=false;
          }
        });
      });
    }

  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  Widget btnStart() {
    return IconButton(
      padding: const EdgeInsets.only(bottom: 10),
      icon:isPlaying==false?(new Image.asset('assets/images/player.png',color: widget.couleur,)):(new Image.asset('assets/images/pause.png',color: widget.couleur,)),
      onPressed: (){
        if(isPlaying==false) {
          this.widget.advancedPlayer.play(this.widget.audioPath);
          setState(() {
            isPlaying = true;
          });
        }else if(isPlaying==true){
          this.widget.advancedPlayer.pause();
          setState(() {
            isPlaying=false;
          });
        }
      },
    );
  }


  Future openFile(String url)async{
    final name= url.split("/").last;
    final file=await downloadfiles(url,name);

    //if(file==null) return;
    //print("path: ${file.path}");
    //OpenFile.open(file.path);
  }

  Future<String> readcontent() async {
    try {
      //final file = await _localFile;

      final directory = await getApplicationDocumentsDirectory();
      //final file=File('${directory.path}');
      //final raf=file.openSync(mode: FileMode.write);
      print("mp3");
      print(directory.path);
      //print(file);
      // Read the file
      //String contents = await file.readAsString();
      //return contents;
      return "";
    } catch (e) {
      // If there is an error reading, return a default String
      return 'Error';
    }
  }

  Future<File?> pickFile() async{
    final result=await FilePicker.platform.pickFiles();
    if(result==null) return null;
    return File(result.files.first.path!);
  }

  Future<File?> downloadfiles(String url,String name) async{
    final appstorage=await p.getApplicationDocumentsDirectory();
    String folderName="musics";
    final dirPath = '${appstorage.path}/musics' ;
    final Directory _appDocDirFolder =  Directory('${appstorage.path}/$folderName/');
    if(await _appDocDirFolder.exists()){
      print("dossier existe");
    }
    else{
      final Directory _appDocDirNewFolder=await _appDocDirFolder.create(recursive: true);
      print("j'ai cree dossier");
      print(_appDocDirNewFolder.path);
    }

    //pr = new ProgressDialog(context,ProgressDialogType.Download);
    //pr.show();
    try{
     // pr.update(progress: progres,message: "${progres}");
      //if(progres==100){
      //  pr.hide();
      //}
      final response=await Dio().get(url,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 0,
          ),
          onReceiveProgress: (rec,total){
          setState(() {
            _isLoading=true;
            progress=((rec/total)*100).toStringAsFixed(0);
            progres=((rec/total)*100);
            print(progres);

          });
        }
      );
      final file=File('${_appDocDirFolder.path}$name');
      //pr.update(message: progress);
      final raf=file.openSync(mode: FileMode.write);
      //print(raf);
      raf.writeFromSync(response.data);
      print(raf.path);
      await raf.close();
      return file;
    }catch(e){
      return null;
    }

  }

  Widget btnFast() {
    return
      IconButton(
        icon:   ImageIcon(
          AssetImage('assets/images/forward.png'),
          size: 15,
          color: widget.couleur,
        ),
        onPressed: () {
          //this.widget.advancedPlayer.setPlaybackRate(playbackRate: 1.5);
          this.widget.advancedPlayer.setPlaybackRate(1.5);
        },
      );
  }
  Widget btnSlow() {
    return IconButton(
      icon:   ImageIcon(
        AssetImage('assets/images/backword.png'),
        size: 15,
        color: widget.couleur,
      ),
      onPressed: () {
        this.widget.advancedPlayer.setPlaybackRate(0.5);
        //this.widget.advancedPlayer.setPlaybackRate(playbackRate: 0.5);

      },
    );
  }
  Widget btnLoop() {
    return IconButton(
        icon:   ImageIcon(
          AssetImage('assets/images/loop.png'),
          size: 15,
          color: widget.couleur,
        ), onPressed: () {
          //Share.share(text)
          //Share.share("text",{widget.audioPath,""});
          //Share.share(widget.audioPath);
    },
    );
  }
  Widget btnRepeat() {
    return IconButton(
      icon: ImageIcon(
        AssetImage('assets/images/repeat.png'),
        size: 15,
        color:widget.couleur,
      ),
      onPressed: () async{
        //openFile(widget.audioPath);
        telecharger(widget.audioPath);
        //_downloadAndSave(widget.audioPath,'audio.mp3');
        /*if(isRepeat==false){
          this.widget.advancedPlayer.setReleaseMode(ReleaseMode.LOOP);
          setState(() {
            isRepeat=true;
            color=widget.couleur;
          });
        }else if(isRepeat==true){
          this.widget.advancedPlayer.setReleaseMode(ReleaseMode.RELEASE);
          color=Colors.black;
          isRepeat=false;
        }*/
      },
    );
  }

  Widget slider() {
    return widget.isradio==false?
      Slider(
        activeColor: widget.couleur,
        inactiveColor: Colors.grey,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            changeToSecond(value.toInt());
            value = value;
          });})
        :Slider(
        activeColor: widget.couleur,
        inactiveColor: Colors.grey,
        value: 0,
        //min: 0.0,
        //max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            changeToSecond(value.toInt());
            value = value;
          });});
  }

  void changeToSecond(int second){
    Duration newDuration = Duration(seconds: second);
    this.widget.advancedPlayer.seek(newDuration);
  }

  Widget loadAsset() {
    return
      Container(
          child:Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                btnRepeat(),
                btnSlow(),
                btnStart(),
                btnFast(),
                btnLoop()
              ])
      );
  }
  @override
  Widget build(BuildContext context) {
    return
      Container(child:
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                widget.isradio==false?(
                Text(_position.toString().split(".")[0], style:
                TextStyle(fontSize: 16,color: widget.couleur),
                )
                ):Text(""),
                widget.isradio==false?(
                Text(_duration.toString().split(".")[0], style: TextStyle(fontSize: 16,color: widget.couleur))
              ):Text(""),
              ],
            ),
          ),

          slider(),
          loadAsset(),
        ],
      )

      );
  }
}
