import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;


class Counter {
  String year;
  String count;
}


class CounterService {
  static const _serviceUrl = 'http://192.168.43.230:3002/save_counterdetails'; // Give full path name of URL
  //  static const _serviceUrl = 'http://10.170.105.22:3002/save_counterdetails'; // Give full path name of URL
  //static const _serviceUrl = 'http://localhost/save_counterdetails'; // Give full path name of URL
  //   static const _serviceUrl = 'http://landadmin.tn.gov.in/myPmb:3002/save_counterdetails'; // Give full path name of URL
  // static final _headers = {'Content-Type': 'application/json'};
  Map<String, String> _headers = { "Content-type": "application/x-www-form-urlencoded" };

  Future createCounter(Counter counter) async {

    try {
      var json = _toJson(counter);
      print("Counter Service called");
      final response =
      await http.post(_serviceUrl, headers: _headers, body: json);
      // print(response.body);
      // print(response.headers);
      final res = jsonDecode(response.body);
      return res;
    } catch (e) {
      print('Server Exception!!!');
      print(e);
      return null;
    }
  }


//JSON Encoding
  _toJson(Counter counter) {
    var mapData = new Map();
    mapData["year"] = counter.year;
    mapData["count"] = counter.count;
    return mapData;
  }
}
