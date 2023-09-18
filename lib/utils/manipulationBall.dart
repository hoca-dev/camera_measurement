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






class LengthIdentifier extends StatelessWidget {
  const LengthIdentifier({Key? key, this.height = 2, this.color = Colors.red})
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




class RangeSliderExample extends StatefulWidget {
  final ValueChanged<RangeValues> onChanged;

  const RangeSliderExample({Key? key, required this.onChanged}) : super(key: key);

  @override
  RangeSliderExampleState createState() => RangeSliderExampleState();
}

class RangeSliderExampleState extends State<RangeSliderExample> {
  RangeValues _currentRangeValues = const RangeValues(0, 100);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: RangeSlider(
        values: _currentRangeValues,
        min: 0,
        max: 100,
        divisions: 100,
        labels: RangeLabels(
          _currentRangeValues.start.round().toString(),
          _currentRangeValues.end.round().toString(),
        ),
        onChanged: (RangeValues values) {
          setState(() {
            _currentRangeValues = values;
          });
          widget.onChanged(values);
        },

      ),
    );
  }
}