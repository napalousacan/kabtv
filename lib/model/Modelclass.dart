class ModelClass {
  String title;
  String desc;
  String sdimage;
  String type;
  String feedUrl;
  String streamUrl;

  ModelClass({required this.title,
    required this.desc,
    required this.sdimage,
    required this.type,
    required this.feedUrl,
    required this.streamUrl,});

  factory ModelClass.fromJson(Map<String, dynamic> json) => ModelClass(
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