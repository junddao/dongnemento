import 'package:base_project/global/bloc/auth/authentication/authentication_bloc.dart';
import 'package:base_project/global/component/du_text_form_field.dart';
import 'package:base_project/global/model/auth/request/sign_in_input.dart';
import 'package:base_project/global/style/constants.dart';
import 'package:base_project/global/style/du_button.dart';
import 'package:base_project/global/style/du_colors.dart';
import 'package:base_project/global/style/du_text_styles.dart';
import 'package:base_project/global/util/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                Text('Base Project', style: DUTextStyle.size24B.grey1),
                _buildEmailLogin(),
                // _buildKakaoLogin(),
                // Platform.isIOS ? const SizedBox(height: 20.0) : const SizedBox.shrink(),
                // Platform.isIOS ? _buildAppleLogin() : const SizedBox.shrink(),
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
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: '이메일을 입력하세요.',
              ),
              onChanged: (value) {},
              onEditingComplete: () => node.nextFocus(),
              validator: (val) {
                return val == null || !RegExp(Validation.emailRegex).hasMatch(val) ? '이메일 형식이 잘못되었습니다.' : null;
              },
            ),
            const SizedBox(height: 8),
            DUTextFormField(
              controller: _tecPassword,
              decoration: const InputDecoration(
                hintText: '비밀번호를 입력하세요.',
              ),
              obscureText: true,
              onChanged: (value) {},
              onEditingComplete: () {},
              validator: (value) {
                return value == null || value.length > 3 ? null : '비밀번호는 4자리 이상만 가능합니다.';
              },
            ),
            const SizedBox(height: 48),
            DUButton(
              width: SizeConfig.screenWidth - 40,
              text: '로그인 하기',
              press: () {
                SignInInput input = SignInInput(
                  email: _tecEmail.text,
                  password: _tecPassword.text,
                );
                context.read<AuthenticationBloc>().add(AuthenticationSignIn(input: input));
              },
            ),
            const SizedBox(height: 8),
            const Divider(color: DUColors.divider),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
