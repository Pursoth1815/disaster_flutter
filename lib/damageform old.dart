
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'validation.dart';
import 'showalert.dart';
import 'damageservices.dart';

class DamageForm extends StatefulWidget {
  DamageForm({Key key}) : super(key: key);

  @override
  _DamageFormState createState() => new _DamageFormState();
}

class _DamageFormState extends State<DamageForm> {
  Damage newDamage = new Damage();
  final DamageService damageService = DamageService();
  
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
        title: new Text('Damage Details'),
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
                    initialValue: "1234",
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, size: iconSize),
                      hintText: 'Enter your Application ID',
                      labelText: 'App ID',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    keyboardType: TextInputType.name,
                    //validator:  validateName,
                    onSaved: (val) => newDamage.ben_app_id = val,
                  ),

                  new TextFormField(
                    initialValue: "1234",
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, size: iconSize),
                      hintText: 'Enter Enter Survey No',
                      labelText: 'Survey No',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    keyboardType: TextInputType.name,
                    //validator:  validateName,
                    onSaved: (val) => newDamage.ben_survno = val,
                  ),

                  new TextFormField(
                    initialValue: "1234",
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, size: iconSize),
                      hintText: 'Enter Enter Subdivison  No',
                      labelText: 'Sub Division No',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    keyboardType: TextInputType.name,
                    //validator:  validateName,
                    onSaved: (val) => newDamage.ben_subdivno = val,
                  ),
                  new TextFormField(
                    initialValue: "1234",
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, size: iconSize),
                      hintText: 'Enter Total Extent in Hector',
                      labelText: 'Total Area Hector',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    keyboardType: TextInputType.name,
                    //validator:  validateName,
                    onSaved: (val) => newDamage.ben_totarea_hect = val,
                  ),

                  new TextFormField(
                    initialValue: "1234",
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, size: iconSize),
                      hintText: 'Enter Total Extent in Ares',
                      labelText: 'Total Area Ares',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    keyboardType: TextInputType.name,
                    //validator:  validateName,
                    onSaved: (val) => newDamage.ben_totarea_ares = val,
                  ),
                  new TextFormField(
                    initialValue: "1234",
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, size: iconSize),
                      hintText: 'Enter Affected area in Hector',
                      labelText: 'Affected Area Hector',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    keyboardType: TextInputType.name,
                    //validator:  validateName,
                    onSaved: (val) => newDamage.ben_affectarea_hect = val,
                  ),
                  new TextFormField(
                    initialValue: "1234",
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, size: iconSize),
                      hintText: 'Enter Affected area in Ares',
                      labelText: 'Affected Area Ares',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                    inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    keyboardType: TextInputType.name,
                    //validator:  validateName,
                    onSaved: (val) => newDamage.ben_affectarea_ares = val,
                  ),
                  new TextFormField(
                    initialValue: "1234",
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, size: iconSize),
                      hintText: 'Enter Crop Name',
                      labelText: 'Crop Name',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                    //inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    keyboardType: TextInputType.name,
                    //validator:  validateName,
                    onSaved: (val) => newDamage.ben_cropname = val,
                  ),

                  new TextFormField(
                    initialValue: "Y",
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, size: iconSize),
                      hintText: 'Enter Insured or not',
                      labelText: 'Insured (Y/N)',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                    //inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    keyboardType: TextInputType.name,
                   // validator:  validateName,
                    onSaved: (val) => newDamage.ben_insured = val,
                  ),

                  new TextFormField(
                    initialValue: "1234",
                    decoration: InputDecoration(
                      icon: Icon(Icons.phone, size: iconSize),
                      hintText: 'Enter insured Amount',
                      labelText: 'Insured Amount',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                    keyboardType: TextInputType.number,
                    //validator: validateMobile,
                    onSaved: (val) => newDamage.ben_insured_amt = val,
                  ),

                  new TextFormField(
                    initialValue: "1234",
                    decoration: InputDecoration(
                      icon: Icon(Icons.phone, size: iconSize),
                      hintText: 'Enter Amount Claimed',
                      labelText: 'Claimed Amount',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                    keyboardType: TextInputType.number,
                    //validator: validateMobile,
                    onSaved: (val) => newDamage.ben_amtclaimed = val,
                  ),
                  
                  SizedBox(height: 20),

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

  void _submitForm() {
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      showMessage('Form is not valid!  Please review and correct.');
    } else {
      form.save(); //This invokes each onSaved event

      print('Form save called...');
      print('Application ID: ${newDamage.ben_app_id}');
      print('Survey Number: ${newDamage.ben_survno}');
      print('Subdivison Number: ${newDamage.ben_subdivno}');
      print('Total Extend in Hector: ${newDamage.ben_totarea_hect}');
      print('Total Extend in Ares: ${newDamage.ben_totarea_ares}');
      print('Affected Area in Hector: ${newDamage.ben_affectarea_hect}');
      print('Affected Area in Ares: ${newDamage.ben_affectarea_ares}');
      print('Crop Name: ${newDamage.ben_cropname}');
      print('Insured or Not: ${newDamage.ben_insured}');
      print('Insured Amount: ${newDamage.ben_insured_amt}');
      print('Amount Claimed: ${newDamage.ben_amtclaimed}');
      print('========================================');
      print('Submitting to back end...');

      /// write code here for submission of record
      /// 
      final response = damageService.createDamage(newDamage);

      print("form response");
      print(response.toString());
      /// if success response
      showAlertDialog(context, "Success", "Damage Details Submitted"); // Reusable alert Dialog
    }
  }
}
