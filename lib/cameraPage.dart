

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:resizable_draggable_widget/resizable_draggable_widget.dart';
import 'package:screenshot/screenshot.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:test1/cameraPicPriview.dart';
import 'package:test1/utils/manipulationBall.dart';


class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
   late List<CameraDescription> cameras;
    CameraController? cameraController;
  ScreenshotController screenshotController = ScreenshotController();
  var currentValue = 4000;
 int direction = 0;
 double containerWidth = 0;


  @override
  void initState() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);

  
    super.initState();
        startCamera(direction);
       
  }

    void startCamera(int direction) async {
    cameras = await availableCameras();
    cameraController = CameraController(
    
      cameras[direction],
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

 waiting (){
return const CircularProgressIndicator();
}
 @override
  void dispose() {
      SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp
  ]);
    cameraController?.dispose();
    super.dispose();
  }

  circularProgressView(){
    return  showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child:  SimpleCircularProgressBar(
                size: 45,
                progressStrokeWidth: 9,
                progressColors: [Colors.red, Colors.blue],
                fullProgressColor: Colors.orange,
                animationDuration: 2,
              ),
            );
          });
  }
final ballDiameter = 90.0;
    double height = 200;
  double width = 100;
  double top = 100;
  double left = 320;
    void onDrag(double dx, double dy) {
    var newHeight = height + dy;
    var newWidth = width + dx;

    setState(() {
      height = newHeight > 0 ? newHeight : 0;
      width = newWidth > 0 ? newWidth : 0;
    });
  }
  @override
  Widget build(BuildContext context) {
double bannerHeight = 200;

    var size =MediaQuery.of(context).size;
    double height = size.height;

    if (cameraController == null || !cameraController!.value.isInitialized){
      return Screenshot(
        controller: screenshotController,
        child: const Scaffold(
          body: Center(
                child:  SimpleCircularProgressBar(
                  size: 45,
                  progressStrokeWidth: 9,
                  progressColors: [Colors.red, Colors.blue],
                  fullProgressColor: Colors.orange,
                  animationDuration: 2,
                ),
              )
        ),
      );
    }
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
        body: Stack(
          children: [
    // camera 
          Positioned(
            right: 1,
            left: 1,
                    child: CameraPreview(cameraController!)),
            // ruler 
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Container(
                padding: const EdgeInsets.only(left: 8, right: 10),
                height: 45,
                child: Image.asset('assets/frame/70ruler.png',
                fit: BoxFit.fill,
                  ),
              ),
            ),
            //cardBox
            Positioned(
                  top: height /1.6,
                
                  left: 10,
                  child: SizedBox(
                    height: 100,
                    width: 99,
                    child: Image.asset('assets/frame/cardHolder.png'),
                  ),
                ),
             Positioned(
                  bottom: height /2.5,
                
                  right: 13,
                  child: GestureDetector(
                    onTap: ()   {
                       circularProgressView();
                     screenshotController
                      .capture(delay: const Duration(milliseconds: 10))
                      .then((capturedImage) async {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> PicturePreviewPage(capturedImage: capturedImage!)));
                    // ShowCapturedWidget(context, capturedImage!);
                  }).catchError((onError) {
                    print(onError);
                  });
                    },
                    child: button(Icons.camera_alt_outlined, Alignment.bottomCenter,),
                  ),
                ),
              const Positioned(
                left: 8,
                child: LengthIdentifier()
              ),
             //TODO draggable Container 
    //  Align(
    //   alignment: AlignmentDirectional.center,
    //    child: ResizableDraggableWidget(
    //           initHeight: 300,
    //           initWidth: 300,
    //           showSquare: true,
    //           draggable: true,
    //           bgColor: Colors.transparent,
    //           squareColor: Colors.green,
    //           changed: (width, height, tranformOffset) {
              
              
    //             print(
    //                 "width: ${width.toStringAsFixed(2)}, height: $height, tranformOffset: $tranformOffset");
    //           },
    //         ),
    //  ),
               
       //center right
         Positioned(
          top: top + height / 2 - ballDiameter / 0.55,
          left: left + width - ballDiameter / 0.4,
          child: ManipulatingBall(
            onDrag: (dx, dy) {
              var newWidth = width + dx;

              setState(() {
                width = newWidth > 0 ? newWidth : 0;
              });
            }, customChild: const LengthIdentifier(),
          ),
        ),
        
        //  Positioned(
        //   top: top + height / 2 - ballDiameter / 0.55,
        //   left: left - ballDiameter / 2,
        //   child: ManipulatingBall(
        //     onDrag: (dx, dy) {
        //       var newWidth = width - dx;

        //       setState(() {
        //         width = newWidth > 0 ? newWidth : 0;
        //         left = left + dx;
        //       });
        //     }, customChild: Image.asset('assets/icons/vertical.png', fit: BoxFit.fitHeight,),),
        //   ),

        ],
      ),
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






class LengthIdentifier extends StatelessWidget {
  const LengthIdentifier({Key? key, this.height = 2, this.color = Colors.white})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: width,
   
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxHeight = constraints.constrainHeight();
          const dashWidth = 5.0;
          final dashHeight = height;
          final dashCount = (boxHeight / (2 * dashWidth)).floor();
          return Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
         
            direction: Axis.vertical,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashHeight,
                height: dashWidth,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}