import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:resizable_draggable_widget/resizable_draggable_widget.dart';
import 'package:test1/previewPage.dart';


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
 double containerWidth = 0;




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
     
    var size =MediaQuery.of(context).size;
    double height = size.height;
    return Scaffold(
      body: Stack(
        children: [





//TODO camera 


Positioned(
                left: 25,
                  right: 25,
                  child: CameraPreview(cameraController)),









          //TODO ruler 
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: RulerPicker(
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
             ),
          ),
           Positioned(
                bottom: height /2.7,
                right: 13,
                child: GestureDetector(
                  onTap: () {
                    cameraController.takePicture().then((XFile? file) {
                      if(mounted) {
                        if(file != null) {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> PreviewPage(picture: file,)));
                        }
                      }
                    });
                  },
                  child: button(Icons.camera_alt_outlined, Alignment.bottomCenter,),
                ),
              ),
            
           //TODO draggable Container 
 Align(
  alignment: AlignmentDirectional.center,
   child: ResizableDraggableWidget(
            initHeight: 300,
            initWidth: 300,
            showSquare: true,
            draggable: true,
            bgColor: Colors.transparent,
            squareColor: Colors.green,
            changed: (width, height, tranformOffset) {
            
            
              print(
                  "width: ${width.toStringAsFixed(2)}, height: $height, tranformOffset: $tranformOffset");
            },
            child:  const Center(
              child: Text('슬라이드하여 크그 변경 가능'),
            ),
          ),
 ),
            
        ],
      ),
    );
  }


Widget button(IconData icon, Alignment alignment) {
  return Align(
    alignment: alignment,
    child: Container(
      margin: const EdgeInsets.only(
        left: 20,
        bottom: 20,
      ),
      height: 60,
      width: 60,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(2, 2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Center(
        child: Icon(
          icon,
          color: Colors.black54,
        ),
      ),
    ),
  );
}
}