import 'dart:convert';

import 'package:disapp/damageform%20old.dart';
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
  _BankFormState createState() => _BankFormState();
}

class _BankFormState extends State<BankForm> {
  Bank newBank = Bank();
  final BankService bankService = BankService();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  double iconSize = 25.0;
  double fontSize = 16.0;
  FontWeight fontWeight = FontWeight.w500;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Bank Details'),
        centerTitle: true,
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Form(
          key: _formKey,
          // autovalidate: true,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: "Indian Overseas Bank",
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_balance, size: iconSize),
                    hintText: 'Enter your Bank Name',
                    labelText: 'Bank Name',
                  ),
                  style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                  inputFormatters: [LengthLimitingTextInputFormatter(50)],
                  keyboardType: TextInputType.name,
                  validator: validateName,
                  onSaved: (val) => newBank.bank_name = val,
                ),
                TextFormField(
                  initialValue: "Rajaji Bhavan",
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_tree, size: iconSize),
                    hintText: 'Enter your Branch Name',
                    labelText: 'Branch Name',
                  ),
                  style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                  inputFormatters: [LengthLimitingTextInputFormatter(50)],
                  keyboardType: TextInputType.name,
                  validator: validateName,
                  onSaved: (val) => newBank.branch_name = val,
                ),
                TextFormField(
                  initialValue: "IOBR1234567",
                  decoration: InputDecoration(
                    icon: Icon(Icons.tag, size: iconSize),
                    hintText: 'Enter your Bank IFSC Code',
                    labelText: 'Bank IFSC Code',
                  ),
                  style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                  inputFormatters: [LengthLimitingTextInputFormatter(16)],
                  keyboardType: TextInputType.name,
                  validator: validateIfsc,
                  onSaved: (val) => newBank.ifsc_code = val,
                ),
                TextFormField(
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
                TextFormField(
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
                Container(
                  padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
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
                            }),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//Snackbar Message
  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(backgroundColor: color, content: Text(message)));
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

      final response = await bankService.createBank(newBank);

      print(response);

      if (response == 'success') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DamageForm()));
      } else {
        print("Error While Inserting the record....");
      }
      // type: Restaurant

      // showAlertDialog(context, "Success", "Bank Details Submitted"); // Reusable alert Dialog
    }
  }
}
