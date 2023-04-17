
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:typed_data';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'validation.dart';
import 'showalert.dart';
import 'damageservices.dart';

class DamageForm extends StatefulWidget {
  DamageForm({Key key}) : super(key: key);

  @override
  _DamageFormState createState() => new _DamageFormState();
}

class _DamageFormState extends State<DamageForm> {
  Damage newDamage =  Damage();
  final DamageService damageService = DamageService();

  File _imageFile;
  ImageSource cam = ImageSource.camera;
  ImageSource gal = ImageSource.gallery;

  Geolocator geolocator = Geolocator();
  Position userLocation;
  
  final GlobalKey<ScaffoldState> _scaffoldKey =  GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  double  iconSize = 25.0;
  double fontSize = 16.0;
  FontWeight fontWeight = FontWeight.w500;

  @override
  void initState() {
    super.initState();
    _getLocation().then((position) {
      userLocation = position;
    });
  }

    void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child:  Wrap(
              children: <Widget>[
                 ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                        gradient: SweepGradient(
                          colors: [
                            Colors.purple,
                            Colors.indigo,
                            Colors.blue,
                            Colors.green,
                            Colors.yellow,
                            Colors.orange,
                            Colors.red
                          ],
                        ),
                        shape: BoxShape.circle),
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.photo_camera,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),

                  title:  Text('Camera'),
                  onTap: () {
                    _imgFromSource(cam);
                    Navigator.of(context).pop();
                  },
                ),
                 ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                          color: Colors.purple, shape: BoxShape.circle),
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.photo_library,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    title:  Text('Gallery'),
                    onTap: () {
                      _imgFromSource(gal);
                      Navigator.of(context).pop();
                    }),
                 ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      width: 40,
                      height: 40,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    title: Text('Remove Photo',),
                    onTap: () {
                      _clearImage();
                      Navigator.of(context).pop();
                    }),
              ],
              //)],
            ),
            // ),
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: _scaffoldKey,
      appBar:  AppBar(
        title:  Text('Damage Details'),
        centerTitle: true,
      ),
      body:  SafeArea(
          top: false,
          bottom: false,
          child:  Form(
              key: _formKey,
              // autovalidate: true,
              child:  SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                children: <Widget>[
                   TextFormField(
                    initialValue: "1234",
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, size: iconSize),
                      hintText: 'Enter your Application ID',
                      labelText: 'App ID',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                   // inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    keyboardType: TextInputType.name,
                    //validator:  validateName,
                    onSaved: (val) => newDamage.ben_app_id = val,
                  ),

                   TextFormField(
                   initialValue: "1234",
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, size: iconSize),
                      hintText: 'Enter Enter Survey No',
                      labelText: 'Survey No',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                   // inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    keyboardType: TextInputType.name,
                    //validator:  validateName,
                    onSaved: (val) => newDamage.ben_survno = val,
                  ),

                   TextFormField(
                   initialValue: "1234",
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, size: iconSize),
                      hintText: 'Enter Enter Subdivison  No',
                      labelText: 'Sub Division No',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                   // inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    keyboardType: TextInputType.name,
                    //validator:  validateName,
                    onSaved: (val) => newDamage.ben_subdivno = val,
                  ),
                   TextFormField(
                    initialValue: "00",
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, size: iconSize),
                      hintText: 'Enter Total Extent in Hector',
                      labelText: 'Total Area Hector',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                   // inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    keyboardType: TextInputType.name,
                    //validator:  validateName,
                    onSaved: (val) => newDamage.ben_totarea_hect = val,
                  ),

                   TextFormField(
                    initialValue: "00.00",
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, size: iconSize),
                      hintText: 'Enter Total Extent in Ares',
                      labelText: 'Total Area Ares',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                   // inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    keyboardType: TextInputType.name,
                    //validator:  validateName,
                    onSaved: (val) => newDamage.ben_totarea_ares = val,
                  ),
                   TextFormField(
                    initialValue: "00",
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, size: iconSize),
                      hintText: 'Enter Affected area in Hector',
                      labelText: 'Affected Area Hector',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                   // inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    keyboardType: TextInputType.name,
                    //validator:  validateName,
                    onSaved: (val) => newDamage.ben_affectarea_hect = val,
                  ),
                   TextFormField(
                    initialValue: "00.00",
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, size: iconSize),
                      hintText: 'Enter Affected area in Ares',
                      labelText: 'Affected Area Ares',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                   // inputFormatters: [new LengthLimitingTextInputFormatter(30)],
                    keyboardType: TextInputType.name,
                    //validator:  validateName,
                    onSaved: (val) => newDamage.ben_affectarea_ares = val,
                  ),
                   TextFormField(
                    initialValue: "Paddy",
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

                   TextFormField(
                    initialValue: "N",
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

                   TextFormField(
                    initialValue: "0",
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

                   TextFormField(
                    initialValue: "0",
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

              SizedBox(height: 20,),

              GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: ClipRect(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 1.0,
                    child: _imageFile != null
                        ? Stack (
                      children: [
                        Image.file(
                          _imageFile,
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.pink, shape: BoxShape.circle),
                            width: 50,
                            height: 50,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                        : Stack(children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          shape: BoxShape.rectangle,
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        padding: EdgeInsets.all(100),
                        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text("Upload an Image",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Positioned(
                        bottom: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.pink, shape: BoxShape.circle),
                          width: 50,
                          height: 50,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),

          SizedBox(height: 20,),

          userLocation != null
              ? Text("Latitude:     " +
              userLocation.latitude.toString() +
              "\nLongitude:  " +
              userLocation.longitude.toString())
              : Container(
            width: 50,
            height: 50,
            child: Icon(
              Icons.location_on,
              color: Colors.pink,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: RaisedButton(
          //     onPressed: () {
          //       _getLocation().then((value) {
          //         setState(() {
          //           userLocation = value;
          //         });
          //       });
          //     },
          //     color: Colors.blue,
          //     child: Text("Get Location",
          //       style: TextStyle(color: Colors.white),
          //     ),
          //   ),
          // ),
        
                  SizedBox(height: 20),

                   Container(
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
     ), );
  }


//Snackbar Message
  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(backgroundColor: color, content: new Text(message)));
  }

  void _submitForm() {
    final FormState form = _formKey.currentState;
   // List<int> imageBytes ;
      // imageBytes = _imageFile.readAsBytesSync();
        // String baseimage = base64Encode(imageBytes);
        // 
        String baseimage = base64Encode(_imageFile.readAsBytesSync());
        newDamage.ben_damage_photo = baseimage; 
       newDamage.ben_location = userLocation.latitude.toString() + "," + userLocation.longitude.toString();
        
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
      print('Location: ${newDamage.ben_location}');
      print('Image: ${newDamage.ben_damage_photo}');
      print('========================================');
      print('Submitting to back end...');

      /// write code here for submission of record
      /// 
      final response = damageService.createDamage(newDamage);

      print("form response");
      print(response.toString());
      /// if success response
     // showAlertDialog(context, "Success", "Damage Details Submitted"); // Reusable alert Dialog
    }
  }

 _imgFromSource(ImageSource img) async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: img,
      maxWidth: MediaQuery.of(context).size.width,
      maxHeight: MediaQuery.of(context).size.height,
    );
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  _clearImage() {
    setState(() {
      _imageFile = null;
    });
  }

  Future<Position> _getLocation() async {
    var currentLocation;
    try {
      currentLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }
}

