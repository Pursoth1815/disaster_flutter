import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

class Bank {
  String bank_name;
  String branch_name;
  String ifsc_code;
  String account_no;
  String ben_app_id;
//Bank(this.bank_name, this.branch_name, this.ifsc_code, this.account_no, this.ben_app_id);
}

class BankService {
  static const _serviceUrl =
      'http://192.168.1.7:3002/save_bankdetails'; // Give full path name of URL
  //  static const _serviceUrl = 'http://10.170.105.22:3002/save_bankdetails'; // Give full path name of URL
  //static const _serviceUrl = 'http://localhost/save_bankdetails'; // Give full path name of URL
  //   static const _serviceUrl = 'http://landadmin.tn.gov.in/myPmb:3002/save_bankdetails'; // Give full path name of URL
  // static final _headers = {'Content-Type': 'application/json'};
  Map<String, String> _headers = {
    "Content-type": "application/x-www-form-urlencoded"
  };

  Future createBank(Bank bank) async {
    try {
      var json = _toJson(bank);
      print("Bank Service called");
      final response =
          await http.post(_serviceUrl, headers: _headers, body: json);
      // print(response.body);
      // print(response.headers);
      final Map<String, dynamic> res = jsonDecode(response.body);
      String token = res["name"];

      return token;
    } catch (e) {
      print('Server Exception!!!');
      print(e);
      return null;
    }
  }

//JSON Encoding
  _toJson(Bank bank) {
    var mapData = new Map();
    mapData["bank_name"] = bank.bank_name;
    mapData["branch_name"] = bank.branch_name;
    mapData["ifsc_code"] = bank.ifsc_code;
    mapData["account_no"] = bank.account_no;
    mapData["ben_app_id"] = bank.ben_app_id;
    //String json = jsonEncode(mapData);
    return mapData;
  }
}
