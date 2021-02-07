import 'package:flutter/material.dart';

class AppTerms {
  // TERMS
  static const String projectName = "Sample Login";
  static const String projectDescription = "This is a sample login to ABC company.";
}



class AppColors {
  //MAIN COLORS

  static const color_1 = const Color(0xFF154360);
  static const color_2 = const Color(0xFF21618c);
  static const black = const Color(0xFF000000);
  static const white = const Color(0xFFFFFFFF);
  static const blue = const Color(0xFF015496);

  static const List<Color> colors = [
    Color(0xFFcc7a00),
    Color(0xFFff9900),
    Color(0xffffad33),
    Color(0xFFffc266)
  ];

}


class CommonData {
  static var deviceWidth = 0.0;
  static var deviceHeight = 0.0;
}


class Const {
  // ******* DATABASE DETAILS TO app *****
  //Server Address
  
  //chge  the local host according to you device
  static String localhost = "http://192.168.1.3:80";
  static String serverAddress = "$localhost/interview_sample";

// Access Path-----------
//login
  static String userRegisration = "$serverAddress/userRegisration.php";
  static String checkRegistration = "$serverAddress/checkRegistration.php";

}
