import 'package:base_project/global/bloc/auth/authentication/authentication_bloc.dart';
import 'package:base_project/global/bloc/auth/get_me/me_cubit.dart';
import 'package:base_project/global/enum/authentication_status_type.dart';
import 'package:base_project/global/service/secure_storage/secure_storage.dart';
import 'package:base_project/global/style/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    super.initState();
    // _isLogin();
  }

  _isLogin() {
    SecureStorage.instance.readToken().then((token) async {
      if (token != null && token.isNotEmpty) {
        await context.read<MeCubit>().getMe();
        context.read<AuthenticationBloc>().add(
              const AuthenticationStatusChanged(status: AuthenticationStatusType.authenticated),
            );
      } else {
        context.read<AuthenticationBloc>().add(
              const AuthenticationStatusChanged(status: AuthenticationStatusType.unauthenticated),
            );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
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
