import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';


class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
   late List<CameraDescription> cameras;
  //TODO error causing line 
   late CameraController cameraController;
  RulerPickerController? _rulerPickerController;
  var currentValue = 4000;
 int direction = 0;




  @override
  void initState() {
   _rulerPickerController = RulerPickerController(value: 0);
    super.initState();
        startCamera(direction);
  }


    void startCamera(int direction) async {
    cameras = await availableCameras();
// var cameraSpecs = const CameraDescription(name: 'photo ', lensDirection: CameraLensDirection.back, sensorOrientation: 180);
    cameraController = CameraController(
    
      cameras[direction],
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.yuv420,
   
      
    );

    await cameraController.initialize().then((value) {
      if(!mounted) {
        return;
      }
      setState(() {}); //To refresh widget
    }).catchError((e) {
      print(e);
    });
  }
 @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        children: [

//TODO camera 


Positioned(
                left: 25,
                  right: 25,
                  child: CameraPreview(cameraController)),









          //TODO ruler 
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
             onValueChange: (value) {
               setState(() {
                 currentValue = value;
               });
             },
             width: MediaQuery.of(context).size.width,
             height: 50,
             rulerMarginTop: 8,
           )
        ],
      ),
    );
  }
}