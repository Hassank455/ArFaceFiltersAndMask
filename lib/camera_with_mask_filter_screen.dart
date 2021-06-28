import 'package:avatar_view/avatar_view.dart';
import 'package:camera_deep_ar/camera_deep_ar.dart';
import 'package:flutter/material.dart';
import 'dart:io' as Platform;

class CameraWithMaskFilterScreen extends StatefulWidget {
  @override
  _CameraWithMaskFilterScreenState createState() =>
      _CameraWithMaskFilterScreenState();
}

class _CameraWithMaskFilterScreenState
    extends State<CameraWithMaskFilterScreen> {
  CameraDeepArController cameraDeepArController;
  String platformVersion = "Unknown";
  int currentPage = 0;
  final vp = PageController(viewportFraction: .24);
  Effects currentEffect = Effects.none;
  Filters currentFilter = Filters.none;
  Masks currentMask = Masks.none;

  // bool isRecording = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            //Deep AR camera
            CameraDeepAr(
              onCameraReady: (isReady) {
                platformVersion = "Camera status $isReady";
                print(platformVersion);
                setState(() {});
              },
              onImageCaptured: (path) {
                platformVersion = "Image save at $path";
                print(platformVersion);
                setState(() {});
              },
              androidLicenceKey:
                  "422944563f43894166a1b9f26010fb7d706e39aa4abf68a84d5ab7a96d247a200a0b74514e37386a",
              cameraDeepArCallback: (c) async {
                cameraDeepArController = c;
                setState(() {});
              },
            ),

            //face mask filters - Image Button
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 28.0, right: 28.0),
                      child: Expanded(
                        child: FlatButton(
                          child: Icon(Icons.camera_enhance),
                          color: Colors.white54,
                          padding: EdgeInsets.all(15.0),
                          onPressed: () {
                            if(null == cameraDeepArController){
                              return;
                            }
                            cameraDeepArController.snapPhoto();
                          },
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(8, (page) {
                          bool active = currentPage == page;
                          return Platform.Platform.isIOS
                              // ios app view
                              ? GestureDetector(
                                  onTap: () {
                                    currentPage = page;
                                    cameraDeepArController.changeMask(page);
                                    setState(() {});
                                  },
                                  child: AvatarView(
                                    radius: active ? 65 : 30,
                                    borderColor: Colors.yellow,
                                    borderWidth: 2,
                                    isOnlyText: false,
                                    avatarType: AvatarType.CIRCLE,
                                    backgroundColor: Colors.red,
                                    imagePath:
                                        "assets/ios/${page.toString()}.jpg",
                                    placeHolder: Icon(
                                      Icons.person,
                                      size: 50,
                                    ),
                                    errorWidget: Container(
                                      child: Icon(
                                        Icons.error,
                                        size: 50,
                                      ),
                                    ),
                                  ),
                                )
                              // android app view
                              : GestureDetector(
                                  onTap: () {
                                    currentPage = page;
                                    cameraDeepArController.changeMask(page);
                                    setState(() {});
                                  },
                                  child: AvatarView(
                                    radius: active ? 45 : 25,
                                    borderColor: Colors.yellow,
                                    borderWidth: 2,
                                    isOnlyText: false,
                                    avatarType: AvatarType.CIRCLE,
                                    backgroundColor: Colors.red,
                                    imagePath:
                                        "assets/android/${page.toString()}.jpg",
                                    placeHolder: Icon(
                                      Icons.person,
                                      size: 50,
                                    ),
                                    errorWidget: Container(
                                      child: Icon(
                                        Icons.error,
                                        size: 50,
                                      ),
                                    ),
                                  ),
                                );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
