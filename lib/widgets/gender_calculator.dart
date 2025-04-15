import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class GenderCalculator extends StatelessWidget {
  final int genderRate;
  const GenderCalculator({super.key, required this.genderRate});

  @override
  Widget build(BuildContext context) {
    if (genderRate == -1) {
      return Column(
        children: [
          Text(
            'GENDERLESS',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 10,
          ),
          LinearPercentIndicator(
            animation: true,
            backgroundColor: Color.fromRGBO(0, 0, 0, 0.7),
            percent: 0.0,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      );
    }
    return Column(
      children: [
        Text(
          'GENDER',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 10,
        ),
        LinearPercentIndicator(
          animation: true,
          progressColor: Color.from(alpha: 1, red: 255, green: 117, blue: 1),
          backgroundColor: Color.from(alpha: 37, red: 81, green: 195, blue: 1),
          percent: 1 - ((genderRate / 8)),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [Icon(Icons.male), Text('${(1 - ((genderRate / 8))) * 100} %')],
            ),
            Row(
              children: [Icon(Icons.female), Text('${((genderRate / 8) * 100)} %')],
            )
          ],
        )
      ],
    );
  }
}
