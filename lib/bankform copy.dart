
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:core';
import 'bankservices.dart';
import 'validation.dart';
import 'showalert.dart';


class BankForm extends StatefulWidget {
  BankForm({Key key}) : super(key: key);

  @override
  _BankFormState createState() => new _BankFormState();
}

class _BankFormState extends State<BankForm> {
  Bank newBank = new Bank();
  final BankService bankService = BankService();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
 
  double  iconSize = 25.0;
  double fontSize = 16.0;
  FontWeight fontWeight = FontWeight.w500;
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text('Bank Details'),
        centerTitle: true,
      ),
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              key: _formKey,
              // autovalidate: true,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  new TextFormField(
                    initialValue: "Indian Overseas Bank",
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_balance, size: iconSize),
                      hintText: 'Enter your Bank Name',
                      labelText: 'Bank Name',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                    inputFormatters: [new LengthLimitingTextInputFormatter(50)],
                    keyboardType: TextInputType.name,
                    validator:  validateName,
                    onSaved: (val) => newBank.bank_name = val,
                  ),
                  new TextFormField(
                    initialValue: "Rajaji Bhavan",
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_tree, size: iconSize),
                      hintText: 'Enter your Branch Name',
                      labelText: 'Branch Name',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                    inputFormatters: [new LengthLimitingTextInputFormatter(50)],
                    keyboardType: TextInputType.name,
                    validator:  validateName,
                    onSaved: (val) => newBank.branch_name = val,
                  ),

                  new TextFormField(
                    initialValue: "IOBR1234567",
                    decoration: InputDecoration(
                      icon: Icon(Icons.tag, size: iconSize),
                      hintText: 'Enter your Bank IFSC Code',
                      labelText: 'Bank IFSC Code',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                    inputFormatters: [new LengthLimitingTextInputFormatter(16)],
                    keyboardType: TextInputType.name,
                   validator:  validateIfsc,
                    onSaved: (val) => newBank.ifsc_code = val,
                  ),

                  new TextFormField(
                    initialValue: "12345678910",
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_balance_wallet, size: iconSize),
                      hintText: 'Enter your Account number',
                      labelText: 'Account No',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                    keyboardType: TextInputType.number,
                    validator: validateAccountNo,
                    onSaved: (val) => newBank.account_no = val,
                  ),
                  new TextFormField(
                    initialValue: "1234",
                    decoration: InputDecoration(
                      icon: Icon(Icons.confirmation_number, size: iconSize),
                      hintText: 'Application ID',
                      labelText: 'Application ID',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                    keyboardType: TextInputType.number,
                   // validator: validateMobile,
                    onSaved: (val) => newBank.ben_app_id = val,
                  ),

                 
                  new Container(
                      padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget> [
                            RaisedButton(
                              textColor: Colors.white,
                              color: Colors.green[900],
                              child: const Text('Submit'),
                              onPressed: () => _submitForm(),
                            ),
                            RaisedButton(
                                textColor: Colors.white,
                                color: Colors.red[900],
                                child: Text('Reset'),
                                onPressed: () {
                                  _formKey.currentState.reset();
                                }
                            ),
                          ])),
                ],
              ))),
    );
  }


//Snackbar Message
  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  void _submitForm() async {
    final FormState form = _formKey.currentState;
    

    if (!form.validate()) {
      showMessage('Form is not valid!  Please review and correct.');
    } else {
      form.save(); //This invokes each onSaved event
      //showMessage("Processing Data"); 
    
      print('Form save called...');
      print('Bank Name: ${newBank.bank_name}');
      print('Branch Name: ${newBank.branch_name}');
      print('IFSC Code : ${newBank.ifsc_code}');
      print('Account Number: ${newBank.account_no}');
      print('Application ID: ${newBank.ben_app_id}');
      print('========================================');
      print('Submitting to back end...');

//     Map<String,String> mapData = {"bank_name":"${newBank.bank_name}","branch_name":"${newBank.branch_name}","ifsc_code":"${newBank.ifsc_code}","account_no":"${newBank.account_no}","ben_app_id":"${newBank.ben_app_id}"};
//      print("something");
//      String url;
//     if (Platform.isAndroid) 
//     url = "http://10.0.2.2:3002/save_bankdetails";
//     else 
//     url ="http://localhost:3002/save_bankdetails";
   
//    Map<String, String> headers = {
//       "Content-type": "application/x-www-form-urlencoded"
//     };
//     String url1 = "http://10.0.2.2:3002/save_bankdetails";
//    // String url1 = "http://localhost:3002/save_bankdetails";

//   http.Response response = await http.post(url1, 
//   headers: headers, 
//   body : mapData,
//  //body: {"bank_name":"Indian Overseas Bank","branch_name":"Rajaji Bhavan","ifsc_code":"IOBR1234567","account_no":"12345678910","ben_app_id":"1234"}, // working code
//   );
 
//    print("response 1");
//     print("API Response ");
//     print(response.statusCode);
//     print(response.body);
  
  
 
      // bankService.createBank(mapData);
      bankService.createBank(newBank);

     // showAlertDialog(context, "Success", "Bank Details Submitted"); // Reusable alert Dialog
    }
    
  }
}
