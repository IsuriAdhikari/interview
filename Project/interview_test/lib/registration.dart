import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:interview_test/login.dart';
import 'package:interview_test/userProfile.dart';
import 'const.dart';
import 'package:image_picker/image_picker.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool showProgress = false;
  String firstName, lastName, email, password;
  File _image;
  String _imagepath = "";

  //Register new user
  _userRegistration() async {
    Dio _dio = new Dio();
    _dio.options.connectTimeout = 5000;
    _dio.options.receiveTimeout = 5000;
    _dio.options.receiveDataWhenStatusError = true;
    _dio.options.responseType = ResponseType.json;

    Response _res;

    if (_image != null) {
      _imagepath = _image.path;
    } else {}

    _res = await _dio.post(
      Const.userRegisration,
      data: {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
        "image": _imagepath
      },
    );

    final loginData = json.decode(_res.data);

    if (loginData['message'] == "Login Success") {
      //login success
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  UserProfile(firstName, lastName, email, "", _imagepath)));
    } else {
      //login fail
      _showMobileErrordialog(context);
    }
  }

//Error message
  void _showMobileErrordialog(BuildContext context) {
    showDialog(
        context: context,
        child: AlertDialog(
          content: Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 20, right: 10.0),
            child: Text('Error in regidtration!'),
          ),
          actions: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6.0)),
                border: Border.all(width: 0.5, color: AppColors.color_1),
                color: AppColors.color_1,
              ),
              height: 37,
              child: FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  "OK",
                  style: TextStyle(color: AppColors.white, fontSize: 17),
                ),
              ),
            ),
          ],
        ));
  }

//Get image from gallary
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: CommonData.deviceHeight,
          width: CommonData.deviceWidth,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Registration",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 30.0),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _image != null
                        ? FileImage(_image)
                        : AssetImage('assets/man.png'),
                  ),
                  RaisedButton(
                      child: Text("Pick Image"),
                      onPressed: () {
                        _pickImage();
                      }),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      firstName = value;
                    },
                    decoration: InputDecoration(
                        hintText: "Enter First Name",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)))),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      lastName = value;
                    },
                    decoration: InputDecoration(
                        hintText: "Enter your Last Name",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)))),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                        hintText: "Enter your Email",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)))),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(
                        hintText: "Enter your Password",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)))),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: 250,
                      height: 50,
                      child: RaisedButton(
                          child: Text('Register',
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.white)),
                          color: AppColors.color_1,
                          onPressed: () {
                            _userRegistration();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already Registred?',
                        style: TextStyle(fontSize: 16),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Text(
                          'Login Now',
                          style: TextStyle(color: AppColors.blue, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
