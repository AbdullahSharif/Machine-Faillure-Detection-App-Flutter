
import 'package:flutter/material.dart';
import 'package:ml_project/results.dart';
// Import tflite_flutter
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
// import './results.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  _HomePageState() {
    // implement initState
    _loadModel();
    super.initState();
  }
  // TensorFlow Lite Interpreter object
  late Interpreter _interpreter;

  Future _loadModel() async {
    
    // Creating the interpreter using Interpreter.fromAsset
    final modelFile = await rootBundle.load('assets/model.tflite');
    final modelBuffer = modelFile.buffer.asUint8List();
    _interpreter = await Interpreter.fromBuffer(modelBuffer);
    
    // _interpreter = await Interpreter.fromAsset(_modelFile);
    // print('Interpreter loaded successfully');
  }

  List<List<double>> getPredictions(machineType,List<double> input) {
    // List<dynamic> type= input.sublist(0,1);
    // List<dynamic> rest = input.sublist(1,);
    late List<double> encoded;
    if (machineType == "M" || machineType == "m"){
      encoded = [0,0,1];
    }
    else if (machineType == "L" || machineType == "l"){
      encoded = [0,1,0];
    }
    else if (machineType == "H" || machineType == "h"){
      encoded = [1,0,0];
    }

    List<double> model_input = encoded.toList() + input;
    // print(1);
    // List<double> inputFloats = model_input.map((e) => double(e)).toList();
    // print(2);

    late List<List<double>> output = [[0,0,0,0,0,0]];  
    _interpreter.run(model_input, output);
    return output;
  }

  
  var _machineTypeController = TextEditingController();
  var _airTempController = TextEditingController();
  var _processTempController = TextEditingController();
  var _rotationalSpeedController = TextEditingController();
  var _torqueController = TextEditingController();
  var _toolWearController = TextEditingController();
  // String _result = '';
  // final _modelFile = 'model.tflite';
  // double _twfProb = 0.0;
  List<List<double>> _output = [[0.0, 0.0, 0.0, 0.0, 0.0, 0.0]];
  int _indexOfMax=0;
  String _predictionLabel = "";

  void _submit() {
    // Get values from text fields
    final machineType = _machineTypeController.text;
    final airTemp = double.tryParse(_airTempController.text);
    final processTemp = double.tryParse(_processTempController.text);
    final rotationalSpeed = double.tryParse(_rotationalSpeedController.text);
    final torque = double.tryParse(_torqueController.text);
    final toolWear = double.tryParse(_toolWearController.text);
    

    // Check if all values are valid
    if (machineType.isNotEmpty && airTemp != null && processTemp != null &&
        rotationalSpeed != null && torque != null && toolWear != null) {
      //  Call function to pass input to TFLite model and get result
      // Replace with your own code
      // List<List<double>> output = getPredictions(machineType, [airTemp, processTemp, rotationalSpeed, torque, toolWear]);
      
      

      setState(() {
        _output = getPredictions(machineType, [airTemp, processTemp, rotationalSpeed, torque, toolWear]);
        _indexOfMax = getIndexOfMax(_output[0]);
        _predictionLabel = getPredictionLabel(_indexOfMax);
        // _result = 'Result: $machineType, $airTemp, $processTemp, $rotationalSpeed, $torque, $toolWear, $_output, $_indexOfMax, $_predictionLabel';
        
      });
    } else {
      // setState(() {
      //   // _result = 'Please enter valid values';
      // });
    }
  }

  int getIndexOfMax(List<double> list){

    double max = list.reduce((curr, next) => curr > next ? curr : next);
    int maxIndex = list.indexOf(max);
    return maxIndex;
  }

  String getPredictionLabel(int index){
    List<String> results = ["TWF", "HDF", "PWF", "OSF", "RNF", "No Failure"];
    return results[index];
  }

  void _clear(){
    setState(() {
      _machineTypeController.text = "";
      _airTempController.text = "";
      _processTempController.text = "";
      _rotationalSpeedController.text = "";
      _torqueController.text = "";
      _toolWearController.text = "";
      _output = [[0.0, 0.0, 0.0, 0.0, 0.0, 0.0]];
      _indexOfMax=0;
      _predictionLabel = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Machine Failure Predictor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView (
          child:(
          Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _machineTypeController,
              decoration: InputDecoration(labelText: 'Machine Type'),
            ),
            TextFormField(
              controller: _airTempController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Air Temperature'),
            ),
            TextFormField(
              controller: _processTempController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Process Temperature'),
            ),
            TextFormField(
              controller: _rotationalSpeedController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Rotational Speed'),
            ),
            TextFormField(
              controller: _torqueController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Torque'),
            ),
            TextFormField(
              controller: _toolWearController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Tool Wear'),
            ),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Submit'),
            ),
            ElevatedButton(
              onPressed: _clear,
              child: Text('Clear'),
            ),
            SizedBox(height: 16),
            // Text(_result),
            Results(twfProb: _output[0][0], hdfProb: _output[0][1], pwfProb: _output[0][2], osfProb: _output[0][3], rnfProb: _output[0][4], noFailureProb: _output[0][5], prediction: _predictionLabel,)
          ],
        )),
      ),
    ));
  }
  }
