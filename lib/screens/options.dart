import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  const Options({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Settings',
              style: TextStyle(
                  fontSize: 40, fontWeight: FontWeight.w600, color: Color.fromRGBO(0, 0, 0, 0.7)),
            ),
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.settings,
              size: 50,
              color: Color.fromRGBO(0, 0, 0, 0.7),
            )
          ],
        ),
      ),
    );
  }
}
