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
        _buildResultRow('Probability of TWF', twfProb),
        _buildResultRow('Probability of HDF', hdfProb),
        _buildResultRow('Probability of PWF', pwfProb),
        _buildResultRow('Probability of OSF', osfProb),
        _buildResultRow('Probability of RNF', rnfProb),
        _buildResultRow('Probability of No failure', noFailureProb),
        _buildResultRow('Prediction : ', prediction),
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
}