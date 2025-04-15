import 'package:flutter/material.dart';
import 'package:flutter_dex/utils.dart';
import 'package:flutter_svg/svg.dart';

class TypeChart extends StatelessWidget {
  final String type;
  final int color;
  const TypeChart({
    super.key,
    required this.type,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(2, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8,
          ),
          child: Row(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Color(color)),
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: SvgPicture.asset(
                    kTypeIcons.firstWhere(
                      (element) => element.contains(
                        type,
                      ),
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                width: 6,
              ),
              Text(capitalizeFirstLetter(type)),
            ],
          ),
        ));
  }
}
