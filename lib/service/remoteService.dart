import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kabtv/model/Model.dart';
import 'package:logger/logger.dart';

import '../constants.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<List<Dataitem>?> fetchDataAll(String url) async{
    var response = await client.get(Uri.parse(url));
    if(response.statusCode==200){
      Data jsonString = Data.fromJson(json.decode(response.body));
      return jsonString.allitems;
    }
    else{
      return null;
    }
  }
}

