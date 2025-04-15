import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Community extends StatelessWidget {
  const Community({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Community',
              style: TextStyle(
                  fontSize: 40, fontWeight: FontWeight.w600, color: Color.fromRGBO(0, 0, 0, 0.7)),
            ),
            SizedBox(
              width: 20,
            ),
            SvgPicture.asset(
              'assets/community.svg',
              height: 50,
              width: 50,
            )
          ],
        ),
      ),
    );
  }
}
