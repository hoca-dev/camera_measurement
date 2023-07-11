import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ruler_picker/flutter_ruler_picker.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:test1/cameraPage.dart';
import 'package:test1/utils/manipulationBall.dart';


class PreviewPage extends StatefulWidget {

 const PreviewPage({Key? key, required this.picture}) : super(key: key);

  final XFile picture;

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}
const ballDiameter = 70.0;
class _PreviewPageState extends State<PreviewPage> {
RulerPickerController? _rulerPickerController;
  double height = 200;
  double width = 200;
  var currentValue = 4000;
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
  void initState()  {
    
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
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

 

  @override
  Widget build(BuildContext context) {
    const snackBarMessage = SnackBar(content:  Text('사진이 저장되었습니다'));
    return Scaffold(
      body: Stack(
        children: [  
        
          Padding(
            padding:const  EdgeInsets.only(left: 10, right: 10),
            child: Align(
              alignment: AlignmentDirectional.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black,),
            onPressed: (){
              circularProgressView();
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const CameraPage()));
            }
            
                  ),
                    MaterialButton(
              child: const Text('저장', style: TextStyle(color: Colors.blue, fontSize: 17, fontWeight: FontWeight.bold),),
              onPressed: (){
                //TODO => main page once the picture is saved 
                ScaffoldMessenger.of(context).showSnackBar(snackBarMessage);
                GallerySaver.saveImage(widget.picture.path);
              }),
          
                ],
              ),
            ),
          ),

          //preview picture
           Align(
          alignment: AlignmentDirectional.center,
          child:  Image.file(File(widget.picture.path,), fit: BoxFit.fitWidth,),
         ),
           //ruler
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: RulerPicker(
               controller: _rulerPickerController,
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
         // top left 
                  Positioned(
          top: top - ballDiameter / 2,
          left: left - ballDiameter / 2,
          child: ManipulatingBall( 
             customChild:Image.asset('assets/icons/topLeft.png', fit: BoxFit.contain,),
            onDrag: (dx, dy) {
              var mid = (dx + dy) / 2;
              var newHeight = height - 2 * mid;
              var newWidth = width - 2 * mid;

              setState(() {
                height = newHeight > 0 ? newHeight : 0;
                width = newWidth > 0 ? newWidth : 0;
                top = top + mid;
                left = left + mid;
              });
            },
          ),
        ),
        // top middle
        Positioned(
          top: top - ballDiameter / 2,
          left: left + width / 2 - ballDiameter / 2,
          child: ManipulatingBall(
     customChild:const Icon(Icons.keyboard_arrow_up, size: 30,),
            onDrag: (dx, dy) {
              var newHeight = height - dy;

              setState(() {
                height = newHeight > 0 ? newHeight : 0;
                top = top + dy;
              });
            },
          ),
        ),
        // top right
        Positioned(
          top: top - ballDiameter / 2,
          left: left + width - ballDiameter / 2,
          child: ManipulatingBall(
             customChild:Image.asset('assets/icons/topRight.png', fit: BoxFit.contain,),
            onDrag: (dx, dy) {
              var mid = (dx + (dy * -1)) / 2;

              var newHeight = height + 2 * mid;
              var newWidth = width + 2 * mid;

              setState(() {
                height = newHeight > 0 ? newHeight : 0;
                width = newWidth > 0 ? newWidth : 0;
                top = top - mid;
                left = left - mid;
              });
            },
          ),
        ),
        // center right
        Positioned(
          top: top + height / 2 - ballDiameter / 2,
          left: left + width - ballDiameter / 2,
          child: ManipulatingBall(
             customChild:const Icon(Icons.keyboard_arrow_right, size: 30,),
            onDrag: (dx, dy) {
              var newWidth = width + dx;

              setState(() {
                width = newWidth > 0 ? newWidth : 0;
              });
            },
          ),
        ),
        // bottom right
        Positioned(
          top: top + height - ballDiameter / 2,
          left: left + width - ballDiameter / 2,
          child: ManipulatingBall(
              customChild:Image.asset('assets/icons/bottomRight.png', fit: BoxFit.contain,),
            onDrag: (dx, dy) {
              var mid = (dx + dy) / 2;

              var newHeight = height + 2 * mid;
              var newWidth = width + 2 * mid;

              setState(() {
                height = newHeight > 0 ? newHeight : 0;
                width = newWidth > 0 ? newWidth : 0;
                top = top - mid;
                left = left - mid;
              });
            },
          ),
        ),
        // bottom center
        Positioned(
          top: top + height - ballDiameter / 2,
          left: left + width / 2 - ballDiameter / 2,
          child: ManipulatingBall(
         customChild:const Icon(Icons.keyboard_arrow_down, size: 30,),
            onDrag: (dx, dy) {
              var newHeight = height + dy;

              setState(() {
                height = newHeight > 0 ? newHeight : 0;
              });
            },
          ),
        ),
        // bottom left
        Positioned(
          top: top + height - ballDiameter / 2,
          left: left - ballDiameter / 2,
          child: ManipulatingBall(
            // customChild: const Icon(Icons.remove, size: 50,),
            customChild:Image.asset('assets/icons/bottomLeft.png', fit: BoxFit.contain,),
            onDrag: (dx, dy) {
              var mid = ((dx * -1) + dy) / 2;

              var newHeight = height + 2 * mid;
              var newWidth = width + 2 * mid;

              setState(() {
                height = newHeight > 0 ? newHeight : 0;
                width = newWidth > 0 ? newWidth : 0;
                top = top - mid;
                left = left - mid;
              });
            },
          ),
        ),
        //left center
        Positioned(
          top: top + height / 2 - ballDiameter / 2,
          left: left - ballDiameter / 2,
          child: ManipulatingBall(
           customChild:const Icon(Icons.keyboard_arrow_left, size: 30,),
            onDrag: (dx, dy) {
              var newWidth = width - dx;

              setState(() {
                width = newWidth > 0 ? newWidth : 0;
                left = left + dx;
              });
            },
          ),
        ),
        // center center
        Positioned(
          top: top + height / 2 - ballDiameter / 2,
          left: left + width / 2 - ballDiameter / 2,
          child: ManipulatingBall(
            customChild: const Icon(Icons.open_with_outlined, size: 35,),
            onDrag: (dx, dy) {
              setState(() {
                top = top + dy;
                left = left + dx;
              });
            },
          ),),
       
        ],
      ),
    );
  }
}
