String validateName(String name) {
  if (name.length < 2) {
    return 'name must be greater than 2 characters';
  }
  return null;
}

String validateEmail(String email) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(email))
    return 'Enter Valid Email';
  else
    return null;
}

// String validateDob(String dob) {
//   Pattern pattern =
//       r'/^(?:0[1-9]|[12]\d|3[01])([\/.-])(?:0[1-9]|1[012])\1(?:19|20)\d\d$/i';
//   RegExp regex = new RegExp(pattern);
//   if (!regex.hasMatch(dob)) {
//     print('noooooooooooooo');
//     return 'Enter Valid Date of Birth';
//   } else
//     return null;
// }

String validatePassword(String name) {
  if (name.length < 6) {
    return 'Password must be greater than 6 characters';
  }
  return null;
}
String validateDob(String name) {
  if (name.length < 10) {
    return 'Enter valid DOB';
  }
  return null;
}

String validatePhoneNumber(String phone) {
  if (phone.length < 10) {
    return 'Phone number must be of 10 digit';
  }
  return null;
}
