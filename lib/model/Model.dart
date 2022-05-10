import 'dart:convert';
import 'package:get/get.dart';

List<Data> DataFromJson(String str) =>
    List<Data>.from(json.decode(str).map((x) => Data.fromJson(x)));

String DataToJson(List<Data> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Data {
  Data({
    required this.allitems
  });

  List<Dataitem> allitems;

  var isFavorite = false.obs;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    allitems: List<Dataitem>.from(
        json["allitems"].map((x) => Dataitem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "allitems": List<dynamic>.from(allitems.map((x) => x.toJson())),
  };
}

class Dataitem {
  Dataitem({
    required this.title,
    required this.desc,
    required this.sdimage,
    required this.type,
    required this.feedUrl,
    required this.streamUrl,
  });

  String title;
  String desc;
  String sdimage;
  String type;
  String feedUrl;
  String streamUrl;

  factory Dataitem.fromJson(Map<String, dynamic> json) => Dataitem(
    title : json["title"],
    desc : json["desc"],
    sdimage : json["sdimage"],
    type : json["type"],
    feedUrl : json["feed_url"],
    streamUrl : json["stream_url"],
  );

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = title;
    map["desc"] = desc;
    map["sdimage"] = sdimage;
    map["type"] = type;
    map["feed_url"] = feedUrl;
    map["stream_url"] = streamUrl;
    return map;
  }
}