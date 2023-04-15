import 'package:base_project/global/util/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../global/style/du_button.dart';
import '../../global/style/du_colors.dart';
import '../../global/style/du_text_styles.dart';
import '../../routes.dart';

class PageConfirm extends StatefulWidget {
  final String title;
  final String contents1;
  final String contents2;
  const PageConfirm({Key? key, required this.title, required this.contents1, required this.contents2})
      : super(key: key);

  @override
  State<PageConfirm> createState() => _PageConfirmState();
}

class _PageConfirmState extends State<PageConfirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.all(24),
        child: DUButton(
          width: MediaQuery.of(context).size.width - 48,
          text: '확인',
          type: ButtonType.normal,
          press: () {
            context.go(Routes.map);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle_outline, color: DUColors.tomato, size: 24),
            const SizedBox(
              height: 24,
            ),
            Text(widget.title, style: DUTextStyle.size20B.black),
            const SizedBox(height: 24),
            Text(
              widget.contents1,
              style: DUTextStyle.size14.black,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Text(
              widget.contents2,
              style: DUTextStyle.size14.black,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
