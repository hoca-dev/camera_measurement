import 'package:flutter/material.dart';


class ManipulatingBall extends StatefulWidget {
  const ManipulatingBall({super.key,  required this.onDrag, required this.customChild});

  final Function onDrag;
final Widget customChild;
  @override
  _ManipulatingBallState createState() => _ManipulatingBallState();
}
const ballDiameter = 70.0;

class _ManipulatingBallState extends State<ManipulatingBall> {
  double? initX;
  double? initY;

  _handleDrag(details) {
    setState(() {
      initX = details.globalPosition.dx;
      initY = details.globalPosition.dy;
    });
  }


  _handleUpdate(details) {
    var dx = details.globalPosition.dx - initX;
    var dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _handleDrag,
      onPanUpdate: _handleUpdate,
      child: Container(

        width: 50,
        height: 200,
        decoration:  BoxDecoration(
          border: Border.all(color: Colors.transparent, width: 0.0),

        ),
        child: widget.customChild,
      ),
    );
  }
}