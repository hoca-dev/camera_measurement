import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:screenshot/screenshot.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:test1/cameraPicPriview.dart';
import 'package:test1/utils/rulerHelper.dart';

final ballDiameter = 90.0;
double height = 200;
double width = 100;
double top = 100;
double left = 320;

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
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

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
      if (!mounted) {
        return;
      }
      setState(() {}); //To refresh widget
    }).catchError((e) {
      print(e);
    });
  }

  waiting() {
    return const CircularProgressIndicator();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    cameraController?.dispose();
    super.dispose();
  }

  circularProgressView() {
    return showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: SimpleCircularProgressBar(
              size: 45,
              progressStrokeWidth: 9,
              progressColors: [Colors.red, Colors.blue],
              fullProgressColor: Colors.orange,
              animationDuration: 2,
            ),
          );
        });
  }

  void onDrag(double dx, double dy) {
    var newHeight = height + dy;
    var newWidth = width + dx;

    setState(() {
      height = newHeight > 0 ? newHeight : 0;
      width = newWidth > 0 ? newWidth : 0;
    });
  }

  double right = 100;
  int _centimeters = 0;

  @override
  Widget build(BuildContext context) {
    double bannerHeight = 200;

    var size = MediaQuery.of(context).size;
    double height = size.height;

    if (cameraController == null || !cameraController!.value.isInitialized) {
      return Screenshot(
        controller: screenshotController,
        child: const Scaffold(
            body: Center(
          child: SimpleCircularProgressBar(
            size: 45,
            progressStrokeWidth: 9,
            progressColors: [Colors.red, Colors.blue],
            fullProgressColor: Colors.orange,
            animationDuration: 2,
          ),
        )),
      );
    }
    return Screenshot(
      controller: screenshotController,
      child: Scaffold(
        body: Stack(
          children: [
            // camera
            Positioned(
                right: 1, left: 1, child: CameraPreview(cameraController!)),
            // ruler
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Container(
                padding: const EdgeInsets.only(left: 8, right: 10),
                height: 45,
                child: Image.asset(
                  'assets/frame/70ruler.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              bottom: height / 2.5,
              right: 13,
              child: GestureDetector(
                onTap: ()  {
                  circularProgressView();
                  screenshotController
                      .capture(delay: const Duration(milliseconds: 10))
                      .then((capturedImage) async {
                     Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PicturePreviewPage(
                                capturedImage: capturedImage!))).whenComplete(() {

                     });
                    // ShowCapturedWidget(context, capturedImage!);
                  }).catchError((onError) {
                    print(onError);
                  });
                },
                child: button(
                  Icons.camera_alt_outlined,
                  Alignment.bottomCenter,
                ),
              ),
            ),

            RulerWidget()
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
