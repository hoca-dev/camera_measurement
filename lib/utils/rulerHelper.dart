
import 'package:flutter/material.dart';
import 'package:test1/utils/manipulationBall.dart';

    double height = 200;
  double width = 100;
  double top = 100;
  double left = 320;
class RulerWidget extends StatefulWidget {
  @override
  _RulerWidgetState createState() => _RulerWidgetState();
}

class _RulerWidgetState extends State<RulerWidget> {
  double leftSliderValue = 0.0;
  double rightSliderValue = 70.0;

  @override
  Widget build(BuildContext context) {
    double length = rightSliderValue - leftSliderValue;
    double height = MediaQuery.of(context).size.height;
    double width =  MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(left: 8,),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '길이: ${length.toStringAsFixed(1)} 센티미터',
              style:const TextStyle(fontSize: 24, color: Colors.red),
            ),
         
            SizedBox(
              width: width,
              height: height / 1.5,
              child: Stack(
                children: [
                  Positioned(
                    left: (leftSliderValue / 70) * MediaQuery.of(context).size.width,
                    child: GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        setState(() {
                          leftSliderValue += (details.delta.dx / MediaQuery.of(context).size.width) * 70;
                          leftSliderValue = leftSliderValue.clamp(0.0, rightSliderValue);
                        });
                      },
                      child:  ManipulatingBall2(
            onDrag: (dx, dy) {
              var newWidth = width - dx;

              setState(() {
                width = newWidth > 0 ? newWidth : 0;
                left = left + dx;
              });
            }, customChild:  Row(
              children: [
              
               const LengthIdentifier(),
               //sensible container
              
                  //cardBox
            Padding(
              padding: const EdgeInsets.only(top: 60 ),
              child: SizedBox(
                height: 100,
                width: 99,
                child: Image.asset('assets/frame/cardHolder.png'),
              ),
            ),
           
                
              ],
            ),
            ),
                    ),
                  ),
                  Positioned(
                                
                    //left: (rightSliderValue / 73) * MediaQuery.of(context).size.width - 2, old value where it starts from 70cm
                    left: (rightSliderValue / 73) * MediaQuery.of(context).size.width - 2, // Adjust for line width.
                    child: GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        setState(() {
                          rightSliderValue += (details.delta.dx / MediaQuery.of(context).size.width) * 70;
                          rightSliderValue = rightSliderValue.clamp(leftSliderValue, 70.0);
                        });
                      },
                      child:  ManipulatingBall2(
                            onDrag: (dx, dy) {
                              var newWidth = width - dx;
                  
                              setState(() {
                                width = newWidth > 0 ? newWidth : 0;
                                left = left + dx;
                              });
                            }, customChild:  Row(
                              children: [
                  //sensible container part 
                               Container(
                                // color: Colors.red,
                                width: 15,
                               ),
                               const LengthIdentifier(),
                                //sensible container part 
                               Container(
                                // color: Colors.red,
                                width: 15,
                               ),
                              ],
                            ),),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
