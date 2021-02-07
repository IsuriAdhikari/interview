import 'package:flutter/material.dart';
import 'package:interview_test/splash.dart';

import 'const.dart';

import 'package:flutter/widgets.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppTerms.projectName,
      theme: ThemeData(
          appBarTheme: AppBarTheme(color: AppColors.color_2),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Roboto',
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w600),
            bodyText1: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto'),
          )),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
