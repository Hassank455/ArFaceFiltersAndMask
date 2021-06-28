import 'package:ar_face_filters_app/camera_with_mask_filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      navigateAfterSeconds: CameraWithMaskFilterScreen(),
      seconds: 10,
      title: Text(
        'AR  Face  Filters  App',
        style: TextStyle(
            fontSize: 45,
            color: Colors.deepPurpleAccent,
            fontFamily: 'Signatra'),
      ),
      image: Image.asset("assets/images/icon.png"),
      backgroundColor: Colors.white,
      photoSize: 140,
      loaderColor: Colors.deepPurple,
      loadingText: Text(
        'from HK4',
        style: TextStyle(
          color: Colors.deepPurpleAccent,
          fontSize: 16.0,
          fontFamily: "Brand Bold",
        ),
      ),
    );
  }
}
