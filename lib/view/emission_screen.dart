import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kabtv/controller/appcontroller.dart';
import 'package:kabtv/view/video_screen.dart';

class EmissionScreen extends StatefulWidget {
  const EmissionScreen({Key? key}) : super(key: key);

  @override
  _EmissionScreenState createState() => _EmissionScreenState();
}

class _EmissionScreenState extends State<EmissionScreen> {
  final AppDetailsController c = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("Replay",style: TextStyle(
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
                          "Replay",
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
                  return
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            Get.to(VideoScreen(
                              model: c.Emissions[position],
                              listmodels: c.Emissions,
                            ));
                          },
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
                                            imageUrl: c.Emissions[position].sdimage,
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
                                        c.Emissions[position].title,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontFamily: "CeraPro",
                                        ),
                                      ),
                                      Text(
                                        c.Emissions[position].desc,
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
                      );
                },
                itemCount: c.Emissions.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
