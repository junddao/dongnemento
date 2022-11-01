import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PagePostDetail extends StatefulWidget {
  const PagePostDetail({
    super.key,
    required this.id,
  });

  final String id;
  @override
  State<PagePostDetail> createState() => _PagePostDetailState();
}

class _PagePostDetailState extends State<PagePostDetail> {
  @override
  Widget build(BuildContext context) {
    return PagePostDetailView(id: widget.id);
  }
}

class PagePostDetailView extends StatefulWidget {
  const PagePostDetailView({super.key, required this.id});
  final String id;
  @override
  State<PagePostDetailView> createState() => _PagePostDetailViewState();
}

class _PagePostDetailViewState extends State<PagePostDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Center(
        child: Text('aaa'),
      ),
    );
  }
}
