import 'package:base_project/global/style/du_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key, required this.exception});

  final String? exception;

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.exception ?? 'error',
          ),
          DUButton(
              text: '로그인으로 돌아가기',
              press: () {
                context.go('/login');
              })
        ],
      ),
    );
  }
}
