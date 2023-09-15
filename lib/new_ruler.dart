
/*
import 'package:flutter/material.dart';

void main() {
  runApp(const RulerApp());
}

class RulerApp extends StatelessWidget {
  const RulerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RulerScreen(),
    );
  }
}

class RulerScreen extends StatefulWidget {
  const RulerScreen({super.key});

  @override
  RulerScreenState createState() => RulerScreenState();
}

class RulerScreenState extends State<RulerScreen> {
  String _centimeters = '000';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ruler App'),
      ),
      body: Center(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return orientation == Orientation.portrait
                ? const Text('Please rotate to landscape mode')
                : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Length: ${_centimeters} cm',
                  style: const TextStyle(fontSize: 24.0),
                ),
                const SizedBox(height: 20.0),
                RangeSliderExample(
                  onChanged: (RangeValues values) {
                    setState(() {
                      _centimeters = ((values.end - values.start) * 70.0).toStringAsFixed(2); // Assuming each unit of the range represents 1 cm.
                    
                    });
                  },
                ),
              ],
            );
          },
        ),
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
  RangeValues _currentRangeValues = const RangeValues(0.0, 70.0);

  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      values: _currentRangeValues,
      min: 0.0,
      max: 70.0,
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
    );
  }
}
*/