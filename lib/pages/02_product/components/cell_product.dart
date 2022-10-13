import 'package:base_project/global/style/du_text_styles.dart';
import 'package:flutter/material.dart';

class CellProduct extends StatelessWidget {
  CellProduct({
    Key? key,
    this.id,
    required this.title,
    required this.description,
    this.itemIndex,
    required this.press,
  }) : super(key: key);

  final String? title, description;
  final int? id;
  final int? itemIndex;
  final Function press;

  final textStyleTitle = DUTextStyle.size14;
  final textStyleBody = DUTextStyle.size14;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          press();
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              // child: Image(image: NetworkImage(product.images[0]),
              child: Container(
                width: 105,
                height: 105,
                child: Image.asset('assets/images/sample_image.png'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          title ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: DUTextStyle.size16M,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 60,
                                child: Text(
                                  "견적번호",
                                  style: textStyleTitle,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  "$id",
                                  overflow: TextOverflow.ellipsis,
                                  style: textStyleBody,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
