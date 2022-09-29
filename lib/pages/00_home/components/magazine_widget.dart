import 'package:base_project/global/style/constants.dart';
import 'package:base_project/global/style/du_text_styles.dart';

import 'package:flutter/material.dart';

class MagazineWidget extends StatefulWidget {
  const MagazineWidget({Key? key, this.openMagazine}) : super(key: key);

  final Function? openMagazine;
  @override
  State<MagazineWidget> createState() => _MagazineWidgetState();
}

class _MagazineWidgetState extends State<MagazineWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('매거진', style: DUTextStyle.size20B),
        const SizedBox(height: 22),
        SizedBox(
          height: SizeConfig.screenWidth * 0.5,
          width: double.infinity,
          child: ListView.builder(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return _listTile(index);
            },
          ),
        ),
      ],
    );
  }

  _listTile(int index) {
    String image = '';
    if (index == 0) image = 'assets/images/magazine_sample1.png';
    if (index == 1) image = 'assets/images/magazine_sample2.png';
    if (index == 2) image = 'assets/images/magazine_sample3.png';

    return Padding(
      padding: const EdgeInsets.only(right: 22),
      child: InkWell(
        onTap: () {},
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22.0),
          child: Image.asset(
            image,
            fit: BoxFit.cover,
            height: SizeConfig.screenWidth * 0.5,
            width: SizeConfig.screenWidth * 0.5,
          ),
        ),
      ),
    );
  }
}
