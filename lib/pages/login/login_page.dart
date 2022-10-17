import 'dart:io';

import 'package:base_project/global/bloc/auth/authentication/authentication_bloc.dart';
import 'package:base_project/global/component/du_text_form_field.dart';
import 'package:base_project/global/enum/social_type.dart';
import 'package:base_project/global/model/auth/request/sign_in_input.dart';
import 'package:base_project/global/style/constants.dart';
import 'package:base_project/global/style/du_button.dart';
import 'package:base_project/global/style/du_colors.dart';
import 'package:base_project/global/style/du_text_styles.dart';
import 'package:base_project/global/util/extension/extension.dart';
import 'package:base_project/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const LoginPageView();
  }
}

class LoginPageView extends StatefulWidget {
  const LoginPageView({super.key});

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _tecEmail = TextEditingController();
  final TextEditingController _tecPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return SizedBox(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: SafeArea(
        top: true,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100.0),
                Text('동네멘토', style: DUTextStyle.size24B.grey0),
                _buildEmailLogin(),
                _buildKakaoLogin(),
                Platform.isIOS
                    ? const SizedBox(height: 20.0)
                    : const SizedBox.shrink(),
                Platform.isIOS ? _buildAppleLogin() : const SizedBox.shrink(),
                const SizedBox(height: 40.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailLogin() {
    FocusScopeNode node = FocusScope.of(context);
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            DUTextFormField(
              controller: _tecEmail,
              hintText: '이메일을 입력하세요.',
              textInputAction: TextInputAction.next,
              onChanged: (value) {},
              onEditingComplete: () => node.nextFocus(),
              validator: (val) {
                return val == null ||
                        !RegExp(Validation.emailRegex).hasMatch(val)
                    ? '이메일 형식이 잘못되었습니다.'
                    : null;
              },
            ),
            const SizedBox(height: 8),
            DUTextFormField(
              controller: _tecPassword,
              hintText: '비밀번호를 입력하세요.',
              showSecure: true,
              isSecure: true,
              onChanged: (value) {},
              onEditingComplete: () {
                onLogin();
              },
              validator: (value) {
                return value == null || value.length > 3
                    ? null
                    : '비밀번호는 4자리 이상만 가능합니다.';
              },
            ),
            const SizedBox(height: 48),
            DUButton(
              width: SizeConfig.screenWidth - 40,
              text: '로그인',
              press: () {
                onLogin();
              },
            ),
            DUButton(
                width: SizeConfig.screenWidth - 40,
                type: ButtonType.transparent,
                text: '회원가입',
                press: () {
                  context.go('/login/sign_up');
                  // Navigator.of(context).pushNamed('PageEmailSignUp');
                }),
            const Divider(color: DUColors.divider),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  onLogin() {
    if (_formKey.currentState!.validate() == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('이메일 정보를 다시 확인해주세요.'),
        ),
      );
      return;
    }
    context.read<AuthenticationBloc>().add(AuthenticationSignIn(
        socialType: SocialType.email,
        email: _tecEmail.text,
        password: _tecPassword.text));
  }

  _buildKakaoLogin() {
    return InkWell(
      onTap: () async {
        // bool result = await context.read<AuthProvider>().kakaoLogin();
        bool result = true;
        if (!result) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('로그인을 실패했어요. 다시 시도해 주세요.'),
            ),
          );
          return;
        }

        // result = await context.read<UserProvider>().getMe();
        if (!result) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('유저 정보를 가져오지 못했습니다. 다시 시도해 주세요.'),
            ),
          );
          return;
        }

        if (result == true) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('PageTabs', (route) => false);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('로그인 실패')));
          return;
        }
      },
      child: Container(
        width: SizeConfig.screenWidth - 40,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.yellow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 22),
            Image.asset(
              "assets/icons/ic_logo_kakao.png",
              width: 24,
              height: 24,
            ),
            const Spacer(),
            Text('카카오로 로그인', style: DUTextStyle.size18.black),
            const Spacer(),
            const SizedBox(width: 24),
            const SizedBox(width: 22),
          ],
        ),
      ),
    );
  }

  _buildAppleLogin() {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () async {
        // bool result = await context.read<AuthProvider>().appleLogin();
        bool result = true;

        if (result == true) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('PageTabs', (route) => false);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('로그인 실패')));
        }

        // result = await context.read<UserProvider>().getMe();
        if (!result) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('유저 정보를 가져오지∞ 못했습니다. 다시 시도해 주세요.'),
            ),
          );
          return;
        }

        if (result == true) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('PageTabs', (route) => false);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('로그인 실패')));
          return;
        }
      },
      child: Container(
        width: size.width - 40,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.black,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 22),
            const Icon(
              FontAwesomeIcons.apple,
              size: 24,
              color: DUColors.white,
            ),
            const Spacer(),
            Text('Apple로 로그인', style: DUTextStyle.size18.white),
            const Spacer(),
            const SizedBox(width: 24),
            const SizedBox(width: 22),
          ],
        ),
      ),
    );
  }
}
