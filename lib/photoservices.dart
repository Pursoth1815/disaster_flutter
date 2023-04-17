
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Photo {
  String ben_app_id;
  String ben_damage_photo;
  String ben_location;
}

class PhotoService {
  static const _serviceUrl = 'https://'; // Give full path name of URL
  static final _headers = {'Content-Type': 'application/json'};

  Future<Photo> createPhoto(Photo photo) async {
    try {
      String json = _toJson(photo);
      final response =
      await http.post(_serviceUrl, headers: _headers, body: json);
      var res = _fromJson(response.body);
      return res;
    } catch (e) {
      print('Server Exception!!!');
      print(e);
      return null;
    }
  }

// JSON Decoding
  Photo _fromJson(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    var photo = new Photo();
    photo.ben_app_id = map['ben_app_id'];
    photo.ben_damage_photo = map['ben_damage_photo'];
    photo.ben_location = map['ben_location'];
    return photo;
  }

//JSON Encoding
  String _toJson(Photo photo) {
    var mapData = new Map();
    mapData["ben_app_id"] = photo.ben_app_id;
    mapData["ben_damage_photo"] = photo.ben_damage_photo;
    mapData["ben_location"] = photo.ben_location;
    String json = jsonEncode(mapData);
    return json;
  }
}
