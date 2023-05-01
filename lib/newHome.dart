import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? _machineType = 'M';
  double _airTemp = 0;
  double _processTemp = 0;
  double _rotationalSpeed = 0;
  double _torque = 0;
  double _toolWear = 0;

  void _submitForm() {
    // Calculate results
    // For example:
    double result = _airTemp + _processTemp + _rotationalSpeed - _torque - _toolWear;

    // Display result
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Result'),
        content: Text('The result is: $result'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Machine Type'),
              Row(
                children: [
                  Radio(
                    value: 'M',
                    groupValue: _machineType,
                    onChanged: (value) {
                      setState(() {
                        _machineType = value;
                      });
                    },
                  ),
                  Text('M'),
                  Radio(
                    value: 'L',
                    groupValue: _machineType,
                    onChanged: (value) {
                      setState(() {
                        _machineType = value;
                      });
                    },
                  ),
                  Text('L'),
                  Radio(
                    value: 'H',
                    groupValue: _machineType,
                    onChanged: (value) {
                      setState(() {
                        _machineType = value;
                      });
                    },
                  ),
                  Text('H'),
                ],
              ),
              SizedBox(height: 16),
              Text('Air Temperature'),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _airTemp = double.parse(value);
                  });
                },
              ),
              SizedBox(height: 16),
              Text('Process Temperature'),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _processTemp = double.parse(value);
                  });
                },
              ),
              SizedBox(height: 16),
              Text('Rotational Speed'),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _rotationalSpeed = double.parse(value);
                  });
                },
              ),
              SizedBox(height: 16),
              Text('Torque'),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _torque = double.parse(value);
                  });
                },
              ),
              SizedBox(height: 16),
              Text('Tool Wear'),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _toolWear = double.parse(value);
                  });
                },
              ),
              SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
