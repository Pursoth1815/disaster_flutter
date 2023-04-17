import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Damage {
  String ben_app_id;
  String ben_survno;
  String ben_subdivno;
  String ben_totarea_hect;
  String ben_totarea_ares;
  String ben_affectarea_hect;
  String ben_affectarea_ares;
  String ben_cropname;
  String ben_insured;
  String ben_insured_amt;
  String ben_amtclaimed;
  String ben_damage_photo;
  String ben_location;
 // String ben_location;
}

class DamageService {
  static const _serviceUrl = 'http://192.168.43.230:3002/save_damagedetails'; // Give full path name of URL
   // static const _serviceUrl = 'http://localhost:3002/save_damagedetails'; // Give full path name of URL
  //static final _headers = {'Content-Type': 'application/json'};
  Map<String, String> _headers = { "Content-type": "application/x-www-form-urlencoded" };
  Future createDamage(Damage damage) async {
    try {
      var json = _toJson(damage);
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
 _toJson(Damage damage) {
    var mapData = new Map();
    mapData["ben_app_id"] = damage.ben_app_id;
    mapData["ben_survno"] = damage.ben_survno;
    mapData["ben_subdivno"] = damage.ben_subdivno;
    mapData["ben_totarea_hect"] = damage.ben_totarea_hect;
    mapData["ben_totarea_ares"] = damage.ben_totarea_ares;
    mapData["ben_affectarea_hect"] = damage.ben_affectarea_hect;
    mapData["ben_affectarea_ares"] = damage.ben_affectarea_ares;
    mapData["ben_cropname"] = damage.ben_cropname;
    mapData["ben_insured"] = damage.ben_insured;
    mapData["ben_insured_amt"] = damage.ben_insured_amt;
    mapData["ben_amtclaimed"] = damage.ben_amtclaimed;
    mapData["ben_damage_photo"] = damage.ben_damage_photo;
    mapData["ben_location"] = damage.ben_location;
    //String json = jsonEncode(mapData);
    return mapData;
  }
}
