import 'dart:async';
import 'package:flutter/material.dart';
import 'const.dart';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
//Route to Login page
    Timer(
        Duration(seconds: 2),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage())));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CommonData.deviceWidth = MediaQuery.of(context).size.width;
    CommonData.deviceHeight = MediaQuery.of(context).size.height;

    return MediaQuery(
      data: MediaQueryData(),
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.2),
                          child: Center(
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.3,
                              width: MediaQuery.of(context).size.height * 0.6,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: new DecorationImage(
                                  image: AssetImage('assets/log-in.png'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 100,
                            child: Text("ABC Company",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    height: 1.5,
                                    color: AppColors.color_1,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 25)),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width - 100,
                            child: Text(AppTerms.projectDescription,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    height: 1.5,
                                    color: AppColors.color_1,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18)),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: Container(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
