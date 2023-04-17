
enum ValidationType {
  alphaStringWithSpace,
  mobile,
  email,
  acctno,
  aadhar,
}

const Map<ValidationType, String> ValRegex = {
  ValidationType.alphaStringWithSpace : "^[a-zA-Z ]*\$" , // hello world
  ValidationType.mobile : r'(^[0-9]*$)',  // PhoneNo 10-14 Digits
  ValidationType.email :  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+", // Email
  ValidationType.acctno : r'(^[0-9]*$)', //Account No 9-18 Digits
};

String validateName(String value) {
  RegExp regExp = new RegExp(ValRegex[ValidationType.alphaStringWithSpace]);
  if (value.length == 0) {
    return "Name is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Invalid Name";
  }
  return null;
}

String validateMobile(String value) {
  RegExp regExp = new RegExp(ValRegex[ValidationType.mobile]);
  if (value.length == 0) {
    return "Mobile Number is Required";
  } else if(value.length != 10){
    return "Mobile number must be 10 digits";
  }else if (!regExp.hasMatch(value)) {
    return "Invalid Mobile Number";
  }
  return null;
}

String validateAadharNo(String value) {
  RegExp regExp = new RegExp(ValRegex[ValidationType.aadhar]);
  if (value.length == 0) {
    return "Aadhar Number is Required";
  } else if(value.length != 12){
    return "Aadhar Number must be 12 digits";
  // }else if (!regExp.hasMatch(value)) {
  //   return "Invalid Mobile Number";
  }
  return null;
}


String validateAccountNo(String value) {
  RegExp regExp = new RegExp(ValRegex[ValidationType.acctno]);
  if (value.length == 0) {
    return "Account Number is Required";
  } else if(value.length < 9){
    return "Account Number must be Minimum 9 digits";
  }else if(value.length > 19) {
    return "Account Number must be below or equal to 18 digits";
  }else if (!regExp.hasMatch(value)) {
    return "Invalid Mobile Number";
  }
  return null;
}


String validateIfsc(String value) {
  RegExp regExp = new RegExp(ValRegex[ValidationType.alphaStringWithSpace]);
  if (value.length == 0) {
    return "IFSC Code is Required";
  } else if(value.length != 11){
    return "IFSC Code must be 11 digit";
  // }else if (!regExp.hasMatch(value)) {
  //   return "Invalid IFSC code";
  }
  return null;
}

String validateEmail(String value) {
  RegExp regExp = new RegExp(ValRegex[ValidationType.email]);
  if (value.length == 0) {
    return "Email is Required";
  } else if(!regExp.hasMatch(value)){
    return "Invalid Email";
  }else {
    return null;
  }
}

