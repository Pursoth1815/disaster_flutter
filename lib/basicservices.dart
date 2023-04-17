import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
//import 'package:flutter_session/flutter_session.dart';

class Basic {
  String ben_aadhar = '';
  String ben_name;
  String ben_fname;
  String ben_dist_code = '';
  String ben_tlk_code = '';
  String ben_vill_code = '';
  String ben_gen_code;
  String ben_com_code = '';
  String ben_farm_type = '';
  String ben_dob;
  //DateTime ben_dob;
  String ben_email = '';
  String ben_phone = '';
  String ben_app_id = '';
  //String ben_dopapp;
  String ben_doapp;
}

class BasicService {
  //static const _serviceUrl = 'http://localhost:3002/save_basicdetails'; // Give full path name of URL
  // static const _serviceUrl = 'http://10.170.105.22:3002/save_basicdetails'; // Give full path name of URL
  // static const _serviceUrl = 'http://192.168.43.230:3002/save_basicdetails';
  static const _serviceUrl = 'http://192.168.1.7:3002/save_basicdetails';
  // static final _headers = {'Content-Type': 'application/json'};
  Map<String, String> _headers = {
    "Content-type": "application/x-www-form-urlencoded"
  };

  Future createBasic(Basic basic) async {
    try {
      var json = _toJson(basic);
      final response =
          await http.post(_serviceUrl, headers: _headers, body: json);
      var res = jsonDecode(response.body);
      return res;
    } catch (e) {
      print('Server Exception!!!');
      print(e);
      return null;
    }
  }

//JSON Encoding
  _toJson(Basic basic) {
    var mapData = new Map();
    mapData["ben_aadhar"] = basic.ben_aadhar;
    mapData["ben_name"] = basic.ben_name;
    mapData["ben_fname"] = basic.ben_fname;
    mapData["ben_dist_code"] = basic.ben_dist_code;
    mapData["ben_tlk_code"] = basic.ben_tlk_code;
    mapData["ben_vill_code"] = basic.ben_vill_code;
    mapData["ben_gen_code"] = basic.ben_gen_code;
    mapData["ben_com_code"] = basic.ben_com_code;
    mapData["ben_farm_type"] = basic.ben_farm_type;
    mapData["ben_dob"] = basic.ben_dob;
    mapData["ben_email"] = basic.ben_email;
    mapData["ben_phone"] = basic.ben_phone;
    mapData["ben_app_id"] = basic.ben_app_id;
    mapData["ben_doapp"] = basic.ben_doapp;
    //String json = jsonEncode(mapData);
    return mapData;
  }
}
