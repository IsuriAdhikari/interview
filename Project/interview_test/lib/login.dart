import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:interview_test/registration.dart';
import 'dart:convert';
import 'const.dart';
import 'package:dio/dio.dart';
import 'package:interview_test/userProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var profileData;
  var facebookLogin = FacebookLogin();

  String email, password;

  bool isLogin = false;

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  void initState() {
    _isLogin();
    super.initState();
  }

//check is usser already loged in
  _isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String loginStatus = prefs.getString('loginStatus');

    if (loginStatus == "logged") {
//emali account login
      setState(() {
        isLogin = true;
        email = prefs.getString('email');
        password = prefs.getString('password');
        _login();
      });
    } else if (loginStatus == "facebook") {
//facebook login

      setState(() {
        isLogin = true;
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String stringValue = prefs.getString('token');

      if (stringValue != null) {
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=$stringValue');

        var profile = json.decode(graphResponse.body);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserProfile(
                    profile['first_name'],
                    profile['last_name'],
                    profile['email'],
                    profile["picture"]['data']['url'],
                    "")));
      } else {}
    } else {
//not loged in
      setState(() {
        isLogin = false;
      });
    }
  }

//email account login
  _login() async {
    Dio _dio = new Dio();
    _dio.options.connectTimeout = 5000;
    _dio.options.receiveTimeout = 5000;
    _dio.options.receiveDataWhenStatusError = true;
    _dio.options.responseType = ResponseType.json;

    Response _res;

    _res = await _dio.post(
      Const.checkRegistration,
      data: {"email": email, "password": password},
    );

    final userData = json.decode(_res.data);

    emailController.text = "";
    passwordController.text = "";

    if (userData.length > 0) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("loginStatus", "logged");

      await prefs.setString("email", userData[0]['email']);
      await prefs.setString("password", userData[0]['password']);

//navigate to user profile
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserProfile(
                  userData[0]['first_name'],
                  userData[0]['last_name'],
                  userData[0]['email'],
                  "",
                  userData[0]['image'])));
    } else {
      _showMobileErrordialog(context, 'Invalid email or password!');
    }
  }

//Custom error messages
  void _showMobileErrordialog(BuildContext context, String message) {
    showDialog(
        context: context,
        child: AlertDialog(
          content: Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 20, right: 10.0),
            child: Text(message),
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

//facebook login
  void initiateFacebookLogin() async {
    var facebookLoginResult =
        await facebookLogin.logInWithReadPermissions(['email']);

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        _showMobileErrordialog(context, 'Error in facebook login');
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMobileErrordialog(context, 'Error in facebook login');
        break;
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult.accessToken.token}');

        var profile = json.decode(graphResponse.body);

        final token = facebookLoginResult.accessToken.token;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString("loginStatus", "facebook");

        _facebookLogin(profileData: profile);
        break;
    }
  }

  // facebook login navigate to user profile
  void _facebookLogin({profileData}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserProfile(
                profileData['first_name'],
                profileData['last_name'],
                profileData['email'],
                profileData["picture"]['data']['url'],
                "")));
  }

//loging build widget
  loginInterface() {
    return Container(
      height: CommonData.deviceHeight,
      width: CommonData.deviceWidth,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 70,
              ),
              Container(
                width: 100,
                height: 100,
                child: Image.asset(
                  'assets/login.png',
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'Welcom',
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.color_1),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                height: 50,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    suffixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onChanged: (value) {
                    email = value;
                  },
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 50,
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: Icon(Icons.vpn_key),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                ),
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
                      child: Text('Login',
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.white)),
                      color: AppColors.color_1,
                      onPressed: () {
                        _login();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.black),
                      )),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account',
                    style: TextStyle(fontSize: 16),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Registration()));
                    },
                    child: Text(
                      'Signup',
                      style: TextStyle(color: AppColors.blue, fontSize: 18),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'OR',
                style: TextStyle(color: AppColors.blue, fontSize: 16),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: 250,
                child: RaisedButton(
                  color: AppColors.blue,
                  child: Text(
                    "Login with Facebook",
                    style: TextStyle(color: AppColors.white, fontSize: 16),
                  ),
                  onPressed: () => initiateFacebookLogin(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Center(
            child: isLogin
                ? Container(
                    width: 40, height: 40, child: CircularProgressIndicator())
                : loginInterface(),
          ),
        ),
      ),
    );
  }
}
