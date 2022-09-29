import 'package:base_project/global/component/du_app_bar.dart';
import 'package:base_project/global/style/constants.dart';
import 'package:base_project/global/style/du_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return ProductPageView();
  }
}

class ProductPageView extends StatefulWidget {
  const ProductPageView({super.key});

  @override
  State<ProductPageView> createState() => _ProductPageViewState();
}

class _ProductPageViewState extends State<ProductPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  DUAppBar _appBar() {
    return DUAppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: Text('상품'),
    );
  }

  Widget _body() {
    return Center(
        child: Column(
      children: [
        DUButton(
          width: SizeConfig.screenWidth - 40,
          text: 'tabpage 가기 (go)',
          press: () {
            context.go(
              '/loginPage',
            );
          },
        ),
        const SizedBox(height: 8),
        DUButton(
          width: SizeConfig.screenWidth - 40,
          type: ButtonType.transparent,
          text: 'tabpage 가기 (replace)',
          press: () {
            context.go(
              '/tabPage',
            );
          },
        ),
        const SizedBox(height: 8),
        DUButton(
          width: SizeConfig.screenWidth - 40,
          text: 'tabpage 가기 (push)',
          press: () {
            context.push(
              '/tabPage',
            );
          },
        ),
      ],
    ));
  }
}
