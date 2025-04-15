import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PokeImage extends StatelessWidget {
  final String pokeImage;
  final double? height;
  final double? width;
  const PokeImage({
    super.key,
    required this.pokeImage,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    if (pokeImage.contains('.svg')) {
      return SizedBox(
        child: SvgPicture.network(
          width: width ?? 280,
          height: height ?? 280,
          pokeImage,
          fit: BoxFit.contain,
        ),
      );
    } else {
      return SizedBox(
          width: width ?? 280,
          height: height ?? 280,
          child: Image.network(
            pokeImage,
            fit: BoxFit.contain,
          ));
    }
  }
}
