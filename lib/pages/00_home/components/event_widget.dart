import 'package:base_project/global/style/constants.dart';
import 'package:base_project/global/style/du_colors.dart';
import 'package:base_project/global/style/du_text_styles.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class EventWidget extends StatefulWidget {
  const EventWidget({Key? key, this.openEvent}) : super(key: key);

  final Function? openEvent;
  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  double currentBannerIndex = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double? screenHeight = (SizeConfig.screenWidth - kDefaultHorizontalPadding * 2) * 2 / 3;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('이벤트', style: DUTextStyle.size20B),
        const SizedBox(height: 22),
        SizedBox(
          width: SizeConfig.screenWidth,
          height: screenHeight,
          child: Column(
            children: [
              Stack(
                children: <Widget>[
                  CarouselSlider.builder(
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
                      return InkWell(
                        onTap: () {},
                        child: itemIndex == 0
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset('assets/images/event_sample1.png'),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset('assets/images/event_sample2.png'),
                              ),
                      );
                    },
                    options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 1,
                        // aspectRatio: 3 / 2,
                        initialPage: 0,
                        onPageChanged: (page, _) {
                          setState(() {
                            currentBannerIndex = page.toDouble();
                          });
                        }),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 10,
                    left: 10,
                    child: DotsIndicator(
                      dotsCount: 2,
                      position: currentBannerIndex,
                      decorator: const DotsDecorator(
                        size: Size(8, 8),
                        activeSize: Size(8, 8),
                        color: Colors.white,
                        activeColor: DUColors.blue03,
                        spacing: EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
