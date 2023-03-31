import 'package:base_project/global/style/du_text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../global/model/pin/model_response_get_pin.dart';

class CellPostItem extends StatelessWidget {
  const CellPostItem({
    Key? key,
    this.id,
    required this.pin,
    required this.press,
  }) : super(key: key);

  final int? id;
  final ResponsePin pin;
  final Function press;

  final textStyleTitle = DUTextStyle.size14;
  final textStyleBody = DUTextStyle.size14;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        press();
      },
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: pin.images?.first ?? "",
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            imageBuilder: (context, imageProvider) {
              return Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pin.title ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: DUTextStyle.size16M,
                    ),
                    const SizedBox(height: 15),
                    Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.favorite, color: Colors.red, size: 12),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${pin.likeCount ?? 0}',
                                overflow: TextOverflow.ellipsis,
                                style: textStyleBody,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
