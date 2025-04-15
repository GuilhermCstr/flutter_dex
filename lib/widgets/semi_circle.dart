import 'package:flutter/material.dart';

class SemiCircle extends StatelessWidget {
  final int color1;
  final int color2;
  const SemiCircle({super.key, required this.color1, required this.color2});

  @override
  Widget build(BuildContext context) {
    final Color primary = Color(color1);
    final Color secundary = Color(color2);
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: MediaQuery.of(context).size.height / 2,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              secundary,
              primary,
            ],
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(size.width / 2, size.height + 50, size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
