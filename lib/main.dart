// import 'dart:html';

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:image_picker/image_picker.dart';

void main() async {
     WidgetsFlutterBinding.ensureInitialized();
  await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ruler Picker Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(title: '',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  // _MyHomePageState2 createState() => _MyHomePageState2();
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState2 extends State<MyHomePage> {

@override
  void initState() {
     SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SizedBox(
          height: height,
          width: width,
          child: ListView.builder(
            
              itemCount: 40000,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(100), child: Text("index:$index"));
              }),
        ));
  }
}

class _MyHomePageState extends State<MyHomePage> {
  RulerPickerController? _rulerPickerController;
   List<CameraDescription>? cameras;
   CameraController? cameraController;
  int direction = 0;
  int currentValue = 40000;
 var _image;
  var imagePicker;
  var type;

  @override
  void initState() {
    super.initState();
    _rulerPickerController = RulerPickerController(value: 0);
    startCamera(direction);
  }

  Widget _buildBtn(int value) {
    return InkWell(
      onTap: () {
        _rulerPickerController?.value = value;
      },
      child: Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          color: Colors.blue,
          child: Text(
            value.toString(),
            style: const TextStyle(color: Colors.white),
          )),
    );
  }

  void startCamera(int direction) async {
    cameras = await availableCameras();

    cameraController = CameraController(
    
      cameras![direction],
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.yuv420,

      
    );

    await cameraController?.initialize().then((value) {
      if(!mounted) {
        return;
      }
      setState(() {}); //To refresh widget
    }).catchError((e) {
      print(e);
    });
  }
  @override
  Widget build(BuildContext context) {
        double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: Text(currentValue.toString(), style: const TextStyle(color: Colors.black),),
      // ),
      body: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional.topStart,
            child: Text(currentValue.toString(), style: const TextStyle(color: Colors.black),),
          ),
          Expanded(child: Container(color: Colors.red,
          // child: GestureDetector(
          //     onTap: () async {
          //       ImageSourceType.camera;
          //        XFile image = await imagePicker.pickImage(
          //           source: ImageSource.camera, imageQuality: 50, preferredCameraDevice: CameraDevice.front);
          //       setState(() {
          //         _image = File(image.path);
          //       });
          //     },
          //     child: Container(
          //       width: 200,
          //       height: 200,
          //       decoration: BoxDecoration(
          //           color: Colors.red[200]),
          //       child: _image != null
          //           ? Image.file(
          //                 _image,
          //                 width: 200.0,
          //                 height: 200.0,
          //                 fit: BoxFit.fitHeight,
          //               )
          //           : Container(
          //               decoration: BoxDecoration(
          //                   color: Colors.red[200]),
          //               width: 200,
          //               height: 200,
          //               child: Icon(
          //                 Icons.camera_alt,
          //                 color: Colors.grey[800],
          //               ),
          //             ),
          //     ),
          //   ),
          )),
              //  Positioned(
              //   left: 25,
              //     right: 25,
              //     child: CameraPreview(cameraController!)),
          Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              // Text(
              //   currentValue.toString(),
              //   style: const TextStyle(
              //       color: Colors.black,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 40),
              // ),
              // const SizedBox(height: 110),
              RulerPicker(
                controller: _rulerPickerController!,
                beginValue: 0,
                endValue: 100,
                initValue: currentValue,
                scaleLineStyleList: const [
                  ScaleLineStyle(
                      color: Colors.grey, width: 1.5, height: 30, scale: 0),
                  ScaleLineStyle(
                      color: Colors.grey, width: 1, height: 25, scale: 5),
                  ScaleLineStyle(
                      color: Colors.grey, width: 1, height: 15, scale: -1)
                ],
                // onBuildRulerScalueText: (index, scaleValue) {
                //   return ''.toString();
                // },
                onValueChange: (value) {
                  setState(() {
                    currentValue = value;
                  });
                },
                width: MediaQuery.of(context).size.width,
                height: 50,
                rulerMarginTop: 8,
                // marker: Container(
                //     width: 8,
                //     height: 50,
                //     decoration: BoxDecoration(
                //         color: Colors.red.withAlpha(100),
                //         borderRadius: BorderRadius.circular(5))),
              ),
           
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     _buildBtn(30),
              //     SizedBox(width: 10),
              //     _buildBtn(50),
              //     SizedBox(width: 10),
              //     _buildBtn(100),
              //     SizedBox(width: 10),
              //     _buildBtn(40000),
              //     SizedBox(width: 10),
              //     _buildBtn(50000),
              //   ],
              // ),
            ],
          ),
        ),
        ],
      ),
    );
  }
}