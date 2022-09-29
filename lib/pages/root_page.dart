import 'package:base_project/global/bloc/auth/authentication/authentication_bloc.dart';
import 'package:base_project/global/enum/authentication_status_type.dart';
import 'package:base_project/global/service/secure_storage/secure_storage.dart';
import 'package:base_project/global/style/constants.dart';
import 'package:base_project/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    super.initState();
    _isLogin();
  }

  _isLogin() {
    SecureStorage.instance.readToken().then((value) {
      if (value != null && value.token.isNotEmpty) {
        context.read<AuthenticationBloc>().add(
              const AuthenticationStatusChanged(AuthenticationStatusType.authenticated),
            );
      } else {
        context.read<AuthenticationBloc>().add(
              const AuthenticationStatusChanged(AuthenticationStatusType.unauthenticated),
            );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    SizeConfig().init(context);
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class RootPageView extends StatefulWidget {
  const RootPageView({super.key});

  @override
  State<RootPageView> createState() => _RootPageViewState();
}

class _RootPageViewState extends State<RootPageView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
