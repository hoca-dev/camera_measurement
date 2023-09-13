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
        height: 300,
        decoration:  BoxDecoration(
          border: Border.all(color: Colors.transparent, width: 0.0),

        ),
        child: widget.customChild,
      ),
    );
  }
}




class ManipulatingBall2 extends StatefulWidget {
  const ManipulatingBall2({super.key,  required this.onDrag, required this.customChild});

  final Function onDrag;
final Widget customChild;
  @override
  _ManipulatingBall2State createState() => _ManipulatingBall2State();
}


class _ManipulatingBall2State extends State<ManipulatingBall2> {
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
      double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onPanStart: _handleDrag,
      onPanUpdate: _handleUpdate,
      child: Container(

        width: 102,
        height: height,
        decoration:  BoxDecoration(
          border: Border.all(color: Colors.transparent, width: 0.0),

        ),
        child: widget.customChild,
      ),
    );
  }
}