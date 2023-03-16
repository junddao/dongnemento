import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../style/du_colors.dart';

class DUProfile extends StatelessWidget {
  final double size;
  final Color borderColor;
  final String? profileUrl;

  const DUProfile({
    super.key,
    required this.size,
    this.borderColor = DUColors.gray1,
    this.profileUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CachedNetworkImage(
        imageUrl: profileUrl ?? '',
        imageBuilder: (context, imageProvider) => Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            border: Border.all(color: DUColors.gray1),
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => CircleAvatar(
          radius: size / 2,
          backgroundColor: DUColors.gray1,
          child: CircleAvatar(
            radius: size / 2 - 1,
            backgroundImage: const AssetImage('assets/images/default_image.png'),
          ),
        ),
      ),
    );
  }
}
