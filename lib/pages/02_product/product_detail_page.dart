import 'package:base_project/global/component/du_app_bar.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    super.key,
    required this.id,
  });

  final String id;
  @override
  Widget build(BuildContext context) {
    return ProductDetailPageView(id: id);
  }
}

class ProductDetailPageView extends StatefulWidget {
  const ProductDetailPageView({super.key, required this.id});

  final String id;

  @override
  State<ProductDetailPageView> createState() => _ProductDetailPageViewState();
}

class _ProductDetailPageViewState extends State<ProductDetailPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appBar(),
      body: SizedBox(
        child: Center(
          child: Text(widget.id),
        ),
      ),
    );
  }

  DUAppBar _appBar() {
    return DUAppBar(
      backgroundColor: Colors.transparent,
    );
  }
}
