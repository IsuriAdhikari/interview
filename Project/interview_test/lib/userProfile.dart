import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'const.dart';
import 'login.dart';

class UserProfile extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String image;
  final String saveImage;
  UserProfile(
      this.firstName, this.lastName, this.email, this.image, this.saveImage);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool isLoggedIn = false;

  var profileData;
  var facebookLogin = FacebookLogin();

  @override
  void initState() {
    super.initState();
  }

//logout
  _logout() async {
    await facebookLogin.logOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("loginStatus", "logOut");

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: (widget.image == null || widget.image == "")
                          ? (widget.saveImage == null || widget.saveImage == "")
                              ? AssetImage('assets/man.png')
                              : FileImage(File(widget.saveImage))
                          : NetworkImage(widget.image),
                    ),
                  ),
                ),
                SizedBox(height: 50.0),
                Row(
                  children: [
                    Container(
                      width: 130,
                      child: Text(
                        "First Name: ",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 180,
                      child: Text(
                        widget.firstName,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.0),
                Row(
                  children: [
                    Container(
                      width: 130,
                      child: Text(
                        "Last Name: ",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 180,
                      child: Text(
                        widget.lastName,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.0),
                Row(
                  children: [
                    Container(
                      width: 130,
                      child: Text(
                        "Email: ",
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 180,
                      child: Text(
                        widget.email,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 70.0),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 250,
                    height: 50,
                    child: RaisedButton(
                        child: Text('Log Out',
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.white)),
                        color: AppColors.color_1,
                        onPressed: () {
                          _logout();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black),
                        )),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
