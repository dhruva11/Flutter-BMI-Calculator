import 'package:flutter/material.dart';

void main() => runApp(BMICalculatorApp());

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('BMI Calculator'),
        ),
        body: Center(
          child: Container(
            color: Colors.white, // Set the background color here
            padding: EdgeInsets.all(16.0),
            child: BMICalculatorScreen(),
          ),
        ),
      ),
    );
  }
}

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  double _bmi = 0.0;
  String _category = '';
  Color _textColor = Colors.black;

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _calculateBMI() {
    double weight = double.tryParse(_weightController.text) ?? 0.0;
    double height = double.tryParse(_heightController.text) ?? 0.0;

    setState(() {
      _bmi = weight / ((height / 100) * (height / 100));

      if (_bmi < 18.5) {
        _category = 'Underweight';
        _textColor = Colors.blue;
      } else if (_bmi >= 18.5 && _bmi < 25.0) {
        _category = 'Normal Weight';
        _textColor = Colors.green;
      } else if (_bmi >= 25.0 && _bmi < 30.0) {
        _category = 'Overweight';
        _textColor = Colors.orange;
      } else if (_bmi >= 30.0 && _bmi < 40.0) {
        _category = 'Obese';
        _textColor = Colors.red;
      } else {
        _category = 'Extreme';
        _textColor = Colors.purple;
      }
    });
  }

  void _clearFields() {
    setState(() {
      _weightController.text = '';
      _heightController.text = '';
      _bmi = 0.0;
      _category = '';
      _textColor = Colors.black;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            controller: _weightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Weight (kg)',
            ),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: _heightController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Height (cm)',
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            child: Text('Calculate BMI'),
            onPressed: _calculateBMI,
          ),
          SizedBox(height: 16.0),
          Text(
            'BMI: ${_bmi.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 24.0),
          ),
          SizedBox(height: 16.0),
          Row(
            children: [
              Text(
                'Category: ',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Text(
                _category,
                style: TextStyle(
                  fontSize: 24.0,
                  color: _textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            child: Text('Clear'),
            onPressed: _clearFields,
          ),
        ],
      ),
    );
  }
}
