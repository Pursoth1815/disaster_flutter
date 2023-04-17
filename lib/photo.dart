import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

String phot;
class PhotoService {
  static const _serviceUrl = 'http://10.0.2.2:3002/testimagedata'; // Give full path name of URL
  //static final _headers = {'Content-Type': 'application/json'};
  Map<String, String> _headers = { "Content-type": "application/x-www-form-urlencoded" };
  Future<String> getPhoto() async {
    try {
      final response = await http.get(_serviceUrl);
      var res = jsonDecode(response.body);
      print(res["data"]);
      phot = res["data"];
      return res["data"];
    } catch (e) {
      print('Server Exception!!!');
      print(e);
      return null;
    }
  }
}

class PhotoDemo extends StatelessWidget {
  final PhotoService photoService = PhotoService();
  String photstr;
  @override
  Widget build(BuildContext context) {
    print("first");
    print(phot);
    photoService.getPhoto().then((value) => 
     photstr = value
    );
    return Container(
child:
         
             FutureBuilder(
              future: photoService.getPhoto(),
              builder: (context, snapshot) {
                // not setstate here
                //
                if (snapshot.hasError) {
                  return Text('Error ${snapshot.error}');
                }
                //
                if (snapshot.hasData) {
               // photstr != null ?
                 // Text(photstr): 
                  Text("Text");
                }
              }));
//photstr != null ?
//Text(photstr): Text("Text"),
      
    
  }
}