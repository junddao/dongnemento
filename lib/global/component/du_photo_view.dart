import 'package:base_project/global/style/du_colors.dart';
import 'package:base_project/global/style/du_text_styles.dart';
import 'package:base_project/global/util/extension/extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as path;

// import 'path'

import '../../routes.dart';

class DUPhotoView extends StatefulWidget {
  const DUPhotoView({
    Key? key,
    required this.imageUrls,
    this.screenHeight = 200,
  }) : super(key: key);

  final List<String> imageUrls;

  final double? screenHeight;

  @override
  _DUPhotoViewState createState() => _DUPhotoViewState();
}

class _DUPhotoViewState extends State<DUPhotoView> {
  double currentBannerIndex = 0;
  @override
  Widget build(BuildContext context) {
    return widget.imageUrls.length == 0
        ? Container(
            width: double.infinity,
            height: widget.screenHeight,
            decoration: const BoxDecoration(
              color: DUColors.greyish,
            ),
            child: Center(child: Text('No Image', style: DUTextStyle.size14B.white)),
          )
        : Container(
            width: double.infinity,
            height: widget.screenHeight,
            child: Stack(
              children: <Widget>[
                PageView.builder(
                    itemCount: widget.imageUrls.length,
                    itemBuilder: (context, index) {
                      String filePath = widget.imageUrls[index];
                      return InkWell(
                        onTap: () {
                          context.push(path.join(Routes.photoView, filePath));
                          Navigator.of(context).pushNamed('DSPhotoViewer', arguments: filePath);
                        },
                        child: CachedNetworkImage(
                          imageUrl: filePath,
                          fit: BoxFit.cover,
                          errorWidget: (context, _, __) {
                            return const SizedBox(child: Text('이미지를 불러오지 못했습니다.'));
                          },
                        ),
                        // child: ClipRRect(
                        //   // borderRadius: BorderRadius.circular(20),
                        //   child:
                        // ),
                      );
                    },
                    onPageChanged: (index) {
                      setState(() {
                        currentBannerIndex = index.toDouble();
                      });
                    }),
                Positioned(
                  bottom: 8,
                  right: 10,
                  left: 10,
                  child: DotsIndicator(
                    dotsCount: widget.imageUrls.length,
                    position: currentBannerIndex,
                    decorator: const DotsDecorator(
                      size: Size(8, 8),
                      activeSize: Size(8, 8),
                      color: Colors.white,
                      activeColor: DUColors.tomato,
                      spacing: EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
