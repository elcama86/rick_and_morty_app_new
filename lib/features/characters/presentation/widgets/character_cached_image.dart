import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CharacterCachedImage extends StatelessWidget {
  final double? height;
  final double? width;
  final String imageUrl;

  const CharacterCachedImage({
    super.key,
    this.height,
    this.width,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      fit: BoxFit.fill,
      placeholder: (context, url) => Image.asset(
        'assets/images/cargando.gif',
        height: 180.0,
        fit: BoxFit.fill,
      ),
      imageUrl: imageUrl,
    );
  }
}
