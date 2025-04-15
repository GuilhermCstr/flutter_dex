import 'package:flutter/material.dart';

class EvolveCard extends StatelessWidget {
  const EvolveCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(padding: EdgeInsets.only(bottom: 4, right: 6), child: Text('lvl.')),
            Text(
              '99',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Text('Evolve'),
      ],
    );
  }
}
