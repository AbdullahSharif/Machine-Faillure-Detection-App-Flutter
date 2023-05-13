import 'package:flutter/material.dart';

class Results extends StatelessWidget {
  final double twfProb;
  final double hdfProb;
  final double pwfProb;
  final double osfProb;
  final double rnfProb;
  final double noFailureProb;
  final String prediction;

  const Results({
    Key? key,
    required this.twfProb,
    required this.hdfProb,
    required this.pwfProb,
    required this.osfProb,
    required this.rnfProb,
    required this.noFailureProb,
    required this.prediction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildResultRow('Probability of Tool Wear Failure (TWF)', twfProb),
        _buildResultRow('Probability of Heat Dissipation Failure (HDF)', hdfProb),
        _buildResultRow('Probability of Power Failure (PWF)', pwfProb),
        _buildResultRow('Probability of Overstrain Failure (OSF)', osfProb),
        _buildResultRow('Probability of Random Failures (RNF)', rnfProb),
        _buildResultRow('Probability of No failure', noFailureProb),
        SizedBox(height: 16,),
        _buildPredictionRow('Final Prediction : ', prediction),
      ],
    );
  }

  Widget _buildResultRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          value is String?
          Text(value) :
          Text('${value.toStringAsFixed(2)}%'),
        ],
      ),
    );
  }

  Widget _buildPredictionRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(label, style: TextStyle(fontWeight: FontWeight.bold))),
          value is String?
          Text(value, style: TextStyle(fontWeight: FontWeight.bold)) :
          Text('${value.toStringAsFixed(2)}%', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  
}