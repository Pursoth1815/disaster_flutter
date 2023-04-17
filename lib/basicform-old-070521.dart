
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/text.dart';
import 'dart:async';
import 'dart:convert';
import 'basicservices.dart';
import 'validation.dart';
import 'showalert.dart';


class BasicForm extends StatefulWidget {
  BasicForm({Key key}) : super(key: key);

  @override
  _BasicFormState createState() => new _BasicFormState();
}

class _BasicFormState extends State<BasicForm> {
  Basic newBasic = new Basic();
  final BasicService basicService = BasicService();

  List lstDistrict = List() ; 
  List lstTaluk = List();
  List lstVillage = List() ; 
  List lstGender = List();
  List lstCommunity = List();
  List lstFarmtype = List();
 
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  

  //For Material Design Datepicker
 // TextEditingController _ben_dobController = TextEditingController();
  //DateTime selectedben_dob = DateTime.now();

  //For Cupertino Date Picker
  TextEditingController _ben_doappController =  TextEditingController();
  DateTime selectedben_doapp = DateTime.now();

  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  
  double  iconSize = 25.0;
  double fontSize = 16.0;
  FontWeight fontWeight = FontWeight.w500;
  TextStyle textStyle = TextStyle(fontSize: 16, color: Colors.black);
  
  

   Future<String> getDistrict() async {
    // Starting Web API Call.
    final String url = "http://landadmin.tn.gov.in/dmapp_karur/getDistrict.php";
    // Store all data with Param Name.
    var data = {'language': '0', 'statecode': '33'};
    var res = await http.post(url, body: json.encode(data));
    var resBody = json.decode(res.body);
    setState(() {
      lstDistrict = resBody;
    });

    //print(resBody);

    return "Sucess";
  }

   Future<String> getTaluk(String districtcode) async {
    // Starting Web API Call.
    final String url = "http://landadmin.tn.gov.in/dmapp_karur/getTaluk.php";
    // Store all data with Param Name.
    var data = {
      'language': '0',
      'statecode': '33',
      'districtcode': districtcode,
    };
    var res = await http.post(url, body: json.encode(data));
    var resBody = json.decode(res.body);
    setState(() {
      lstTaluk = resBody;
    });

    //print(resBody);

    return "Sucess";
  }

  Future<String> getVillage( String districtcode, String talukcode) async {
    // Starting Web API Call.
    final String url = "http://landadmin.tn.gov.in/dmapp_karur/getVillage.php";
    // Store all data with Param Name.
    var data = {
      'language': '0',
      'statecode': '33',
      'districtcode': districtcode,
      'talukcode': talukcode
    };
    var res = await http.post(url, body: json.encode(data));
    var resBody = json.decode(res.body);
    setState(() {
      lstVillage = resBody;
    });

    //print(resBody);

    return "Sucess";
  }
  
 Future<String> getSelectData() async {
    // Starting Web API Call.
  //  final String url = "http://192.168.43.230:3002/get_select_data";
    final String url = "http://10.170.105.22:3002/get_select_data";
    var res = await http.get(url);
    var resBody = json.decode(res.body);
    setState(() {
      lstGender = resBody["gender"];
      lstCommunity = resBody["community"];
      lstFarmtype = resBody["farm_type"];
    });
    print("Select Data");
   // print(lstSelectdata);
    print(resBody["gender"]);
    print(resBody["community"]);
    print(resBody["farm_type"]);

    return "Sucess";
  }
 

   @override
  void initState() {
    super.initState();
    this.getDistrict();
    this.getSelectData();
  }

  String selectedState = '33';
  String selectedDistrict;
  String selectedTaluk;
  String selectedVillage;
  String selectedGender;
  String selectedCommunity;
  String selectedFarmtype;


  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColorDark;
    return Scaffold(
      key: _scaffoldKey,
      appBar:  AppBar(
        title:  Text('Basic Details'),
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
                    initialValue: "123456789012",
                    decoration: InputDecoration(
                      icon:  Icon(Icons.fingerprint, size: iconSize,),
                      hintText: 'Enter beneficiary Aadhar No',
                      labelText: 'Aadhar Number',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                    inputFormatters: [ LengthLimitingTextInputFormatter(12)],
                    keyboardType: TextInputType.name,
                    //validator:  validateAadharNo,
                    onSaved: (val) => newBasic.ben_aadhar = val,
                  ),

                   TextFormField(
                    initialValue: "Name",
                    decoration: InputDecoration(
                      icon: Icon(Icons.account_circle, size: iconSize,),
                      hintText: 'Enter beneficiary name',
                      labelText: 'Name',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                    inputFormatters: [ LengthLimitingTextInputFormatter(50)],
                    keyboardType: TextInputType.name,
                    validator:  validateName,
                    onSaved: (val) => newBasic.ben_name = val,
                  ),

                   TextFormField(
                    initialValue: "Father Name",
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, size: iconSize),
                      hintText: 'Enter beneficiary Father name',
                      labelText: 'Father Name',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                    inputFormatters: [ LengthLimitingTextInputFormatter(50)],
                    keyboardType: TextInputType.name,
                    validator:  validateName,
                    onSaved: (val) => newBasic.ben_fname = val,
                  ),

                  //  TextFormField(
                  //   initialValue: "District Name",
                  //   decoration:  InputDecoration(
                  //     icon:  Icon(Icons.domain, size: iconSize),
                  //     hintText: 'Select District Name',
                  //     labelText: 'District Name',
                  //   ),
                  //   style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                  //   inputFormatters: [ LengthLimitingTextInputFormatter(50)],
                  //   keyboardType: TextInputType.name,
                  //   validator:  validateName,
                  //   onSaved: (val) => newBasic.ben_district = val,
                  // ),

                    SizedBox(height: 15,),

           Padding(
              padding: const EdgeInsets.fromLTRB(30, 15, 15, 10),
              child: DropdownButton(
                //icon: Icon(Icons.arrow_downward),
                // iconSize: 24,
                elevation: 16,
                style: textStyle,
                isExpanded: true,
                hint: Text(
                  "--Select District--",
                  style: textStyle,
                ),
                isDense: true,
                onChanged: (value) {
                  setState(() {
                    selectedDistrict = value;
                    selectedTaluk = null;
                    selectedVillage = null;
                    lstTaluk.clear();
                    lstVillage.clear();
                    this.getTaluk(selectedDistrict);
                  });
                  newBasic.ben_district = value;
                  print(value);
                },
                value: selectedDistrict,
                items: selectedState != null ?
                    lstDistrict.map((item) {
                  return new DropdownMenuItem(
                    child: new Text(item['districtname']),
                    value: item['districtcode'].toString(),
                  );
                }).toList()
                : [],
              ),
            ),

             SizedBox(height: 10,),

                  //  TextFormField(
                  //   initialValue: "Taluk Name",
                  //   decoration: InputDecoration(
                  //     icon: Icon(Icons.location_city, size: iconSize),
                  //     hintText: 'Select Taluk name',
                  //     labelText: 'Taluk Name',
                  //   ),
                  //   style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                  //   inputFormatters: [ LengthLimitingTextInputFormatter(30)],
                  //   keyboardType: TextInputType.name,
                  //   validator:  validateName,
                  //   onSaved: (val) => newBasic.ben_taluk = val,
                  // ),
                  
                  
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 15, 15, 10),
              child: DropdownButton(
                // icon: Icon(Icons.arrow_downward),
                // iconSize: 24,
                elevation: 16,
                style: textStyle,
                isExpanded: true,
                hint: Text(
                  "--Select Taluk--",
                  style: textStyle,
                ),
                isDense: true,
                onChanged: (value) {
                  setState(() {
                    selectedTaluk = value;
                    selectedVillage = null;
                    lstVillage.clear();
                    this.getVillage(
                       selectedDistrict, selectedTaluk);
                  });
                   newBasic.ben_taluk = value;
                  print(value);
                },
                value: selectedTaluk,
                items: selectedDistrict != null
                    ? lstTaluk.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item['talukname']),
                          value: item['talukcode'].toString(),
                        );
                      }).toList()
                    : [],
              ),
            ),

             SizedBox(height: 10,),

                  //  TextFormField(
                  //   initialValue: "Village Name",
                  //   decoration: InputDecoration(
                  //     icon:  Icon(Icons.home, size: iconSize),
                  //     hintText: 'Select Village name',
                  //     labelText: 'Village Name',
                  //   ),
                  //   style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                  //   inputFormatters: [ LengthLimitingTextInputFormatter(30)],
                  //   keyboardType: TextInputType.name,
                  //   validator:  validateName,
                  //   onSaved: (val) => newBasic.ben_village = val,
                  // ),
                  
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 15, 15, 10),
              child: DropdownButton(
                // icon: Icon(Icons.arrow_downward),
                // iconSize: 24,
                elevation: 16,
                style: textStyle,
                isExpanded: true,
                hint: Text(
                  "--Select Village--",
                  style: textStyle,
                ),
                isDense: true,
                onChanged: (value) {
                  setState(() {
                    selectedVillage = value;
                    print(value);
                  });
                  newBasic.ben_village = value;
                },
                value: selectedVillage,
                items: selectedTaluk != null
                    ? lstVillage.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item['villagename']),
                          value: item['villagecode'].toString(),
                        );
                      }).toList()
                    : [],
              ),
            ),

                 SizedBox(height: 10,),

             Padding(
              padding: const EdgeInsets.fromLTRB(30, 15, 15, 10),
              child: DropdownButton(
                // icon: Icon(Icons.arrow_downward),
                // iconSize: 24,
                elevation: 16,
                style: textStyle,
                isExpanded: true,
                hint: Text(
                  "--Select Gender--",
                  style: textStyle,
                ),
                isDense: true,
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                    print(value);
                  });
                  newBasic.ben_gender = value;
                },
                value: selectedGender,
                items:  lstGender.map((item) {
                  return new DropdownMenuItem(
                    child: new Text(item['g_data']),
                    value: item['g_code'].toString(),
                  );
                }).toList()
              ),
            ),

            
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 15, 15, 10),
              child: DropdownButton(
                // icon: Icon(Icons.arrow_downward),
                // iconSize: 24,
                elevation: 16,
                style: textStyle,
                isExpanded: true,
                hint: Text(
                  "--Select Community--",
                  style: textStyle,
                ),
                isDense: true,
                onChanged: (value) {
                  setState(() {
                    selectedCommunity = value;
                    print(value);
                  });
                  newBasic.ben_community = value;
                },
                value: selectedCommunity,
                items:  lstCommunity.map((item) {
                  return new DropdownMenuItem(
                    child: new Text(item['c_data']),
                    value: item['c_code'].toString(),
                  );
                }).toList()
              ),
            ),

            
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 15, 15, 10),
              child: DropdownButton(
                // icon: Icon(Icons.arrow_downward),
                // iconSize: 24,
                elevation: 16,
                style: textStyle,
                isExpanded: true,
                hint: Text(
                  "--Select Farm Type--",
                  style: textStyle,
                ),
                isDense: true,
                onChanged: (value) {
                  setState(() {
                    selectedFarmtype = value;
                    print(value);
                  });
                  newBasic.ben_farm_type = value;
                },
                value: selectedFarmtype,
                items:  lstFarmtype.map((item) {
                  return new DropdownMenuItem(
                    child: new Text(item['f_data']),
                    value: item['f_code'].toString(),
                  );
                }).toList()
              ),
            ),

                  TextFormField(
                    initialValue: "00-00-0000",
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, size: iconSize),
                      hintText: 'Enter Your Date of Birth',
                      labelText: 'Date of Birth',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                    inputFormatters: [ LengthLimitingTextInputFormatter(50)],
                    keyboardType: TextInputType.name,
                    //validator:  validateName,
                    onSaved: (val) => newBasic.ben_dob = val,
                  ),

                  //  TextFormField(
                  //   initialValue: "Gen",
                  //   decoration: InputDecoration(
                  //     icon: Icon(Icons.person, size: iconSize),
                  //     hintText: 'Enter beneficiary Gender',
                  //     labelText: 'Gender',
                  //   ),
                  //   style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                  //   inputFormatters: [ LengthLimitingTextInputFormatter(10)],
                  //   keyboardType: TextInputType.name,
                  //   validator:  validateName,
                  //   onSaved: (val) => newBasic.ben_gender = val,
                  // ),
                  //  TextFormField(
                  //   initialValue: "Com",
                  //   decoration: InputDecoration(
                  //     icon: Icon(Icons.person, size: iconSize),
                  //     hintText: 'Enter beneficiary Community',
                  //     labelText: 'Community',
                  //   ),
                  //   style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                  //   inputFormatters: [ LengthLimitingTextInputFormatter(30)],
                  //   keyboardType: TextInputType.name,
                  //   validator:  validateName,
                  //   onSaved: (val) => newBasic.ben_community = val,
                  // ),
                  //  TextFormField(
                  //   initialValue: "Farm",
                  //   decoration: InputDecoration(
                  //     icon: Icon(Icons.person, size: iconSize),
                  //     hintText: 'Enter Farmer Type',
                  //     labelText: 'Farmer Type',
                  //   ),
                  //   style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                  //   inputFormatters: [ LengthLimitingTextInputFormatter(30)],
                  //   keyboardType: TextInputType.name,
                  //   validator:  validateName,
                  //   onSaved: (val) => newBasic.ben_farm_type = val,
                  // ),

                  // GestureDetector(
                  //   onTap: () => _selectDate(context),
                  //   child: AbsorbPointer(
                  //       child: TextFormField(
                  //         onSaved: (val) {
                  //           newBasic.ben_dob= formatter.format(selectedben_dob);
                  //         },
                  //         controller: _ben_dobController,
                  //         decoration: InputDecoration(
                  //           labelText: "Date of Birth",
                  //           icon: Icon(Icons.calendar_today, size: 20),
                  //         ),
                  //         validator: (value) {
                  //           if (value.isEmpty)
                  //             return "Please enter a date";
                  //           return null;
                  //         },
                  //       )),
                  // ),

                   TextFormField(
                    initialValue: "test@nic.in",
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.email, size: 20.0),
                      hintText: 'Enter your email address',
                      labelText: 'Email',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                    keyboardType: TextInputType.emailAddress,
                    validator: validateEmail,
                    onSaved: (val) => newBasic.ben_email = val,
                  ),

                   TextFormField(
                    initialValue: "9876543210",
                    decoration: InputDecoration(
                      icon: Icon(Icons.phone, size: iconSize),
                      hintText: 'Enter your phone number',
                      labelText: 'Phone',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                    keyboardType: TextInputType.phone,
                    validator: validateMobile,
                    onSaved: (val) => newBasic.ben_phone = val,
                  ),

                   TextFormField(
                    initialValue: "1234",
                    decoration: InputDecoration(
                      icon: Icon(Icons.person, size: iconSize),
                      hintText: 'Beneficiary Application ID',
                      labelText: 'Application ID',
                    ),
                    style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
                    inputFormatters: [ LengthLimitingTextInputFormatter(30)],
                    keyboardType: TextInputType.name,
                    //validator:  validateName,
                    onSaved: (val) => newBasic.ben_app_id = val,
                  ),

                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                        child: TextFormField(
                          onSaved: (val) {
                            newBasic.ben_doapp= formatter.format(selectedben_doapp);
                            // newBasic.ben_doapp= selectedben_doapp;
                          },
                          controller: _ben_doappController,
                          decoration: InputDecoration(
                            labelText: "Date of Application",
                            icon: Icon(Icons.calendar_today, size: 20),
                          ),
                          validator: (value) {
                            if (value.isEmpty)
                              return "Please enter a date";
                            return null;
                          },
                        )),
                  ),


                  // GestureDetector(
                  //   onTap: () => _pickDate(context),
                  //   child: AbsorbPointer(
                  //       child: TextFormField(
                  //         onSaved: (val) {
                  //           newBasic.ben_doapp= formatter.format(selectedben_doapp);
                  //         },
                  //         controller: _ben_doappController,
                  //         decoration: InputDecoration(
                  //           labelText: "Date of Application",
                  //           icon: Icon(Icons.calendar_today, size: 20),
                  //         ),
                  //         validator: (value) {
                  //           if (value.isEmpty)
                  //             return "Please enter a date";
                  //           return null;
                  //         },
                  //       )),
                  // ),
                  //
                  
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
                          ]),),
                ],
              ),),),
    ),);
  }

  // Material Design DatePicker selected date Function
  // _selectDate(BuildContext context) async {
  //   // showDatePicker is a built-in function of Material library
  //   final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedben_dob,
  //       firstDate: DateTime(1900),
  //       lastDate: DateTime(2100));
  //   if (picked != null && picked != selectedben_dob)
  //     setState(() {
  //       selectedben_dob = picked;
  //       var date =
  //           "${picked.day}/${picked.month}/${picked.year}";
  //       _ben_dobController.text = date;
  //     });
  // }

  _selectDate(BuildContext context) async {
    // showDatePicker is a built-in function of Material library
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedben_doapp,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedben_doapp)
      setState(() {
        selectedben_doapp = picked;
        var date =
            "${picked.day}/${picked.month}/${picked.year}";
        _ben_doappController.text = date;
      });
  }


  //
  // _pickDate(BuildContext context) async {
  //   // showDatePicker is a built-in function of Material library
  //   final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedben_doapp,
  //       firstDate: DateTime(2021),
  //       lastDate: DateTime(2100));
  //   if (picked != null && picked != selectedben_doapp)
  //     setState(() {
  //       selectedben_doapp= picked;
  //       var date =
  //           "${picked.day}/${picked.month}/${picked.year}";
  //       _ben_doappController.text = date;
  //     });
  // }
  //

//Snackbar Message
  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState
        .showSnackBar( SnackBar(backgroundColor: color, content:  Text(message)));
  }

  void _submitForm() {
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      showMessage('Form is not valid!  Please review and correct.');
    } else {
      form.save(); //This invokes each onSaved event

      print('Form save called...');
      print('Benificiary Aadhar No: ${newBasic.ben_aadhar}');
      print('Benificiary Name: ${newBasic.ben_name}');
      print('Father Name: ${newBasic.ben_fname}');
      print('District: ${newBasic.ben_district}');
      print('Taluk: ${newBasic.ben_taluk}');
      print('Village: ${newBasic.ben_village}');
      print('Gender: ${newBasic.ben_gender}');
      print('Community: ${newBasic.ben_community}');
      print('Farmer Type: ${newBasic.ben_farm_type}');
      print('DoB: ${newBasic.ben_dob}');
      print('Email: ${newBasic.ben_email}');
      print('Phone: ${newBasic.ben_phone}');
      print('Application ID: ${newBasic.ben_app_id}');
      print('Application Date: ${newBasic.ben_doapp}');

      print('========================================');
      print('Submitting to back end...');

      /// write code here for submission of record
      basicService.createBasic(newBasic);
      /// if success response
      // showAlertDialog(context, "Success", "Basic Details Submitted"); // Reusable alert Dialog
    }
  }
}
