import 'package:base_project/global/style/du_colors.dart';
import 'package:base_project/global/style/du_text_styles.dart';

import 'package:flutter/material.dart';

class HomeIntroWidget extends StatelessWidget {
  const HomeIntroWidget({Key? key, this.goUserGuide}) : super(key: key);

  final Function? goUserGuide;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 80),
        Text('3분이면', style: DUTextStyle.size24B),
        Text('컨설팅 요청 끝!', style: DUTextStyle.size24B),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            goUserGuide!();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: DUColors.blue03,
                width: 0.5,
              ),
              color: DUColors.white02,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Image.asset('assets/icons/ic_directions.png'),
                Text('이용 방법 보기', style: DUTextStyle.size12..color?.blue),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
