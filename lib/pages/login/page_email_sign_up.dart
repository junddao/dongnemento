import 'package:base_project/global/bloc/auth/authentication/authentication_bloc.dart';
import 'package:base_project/global/bloc/auth/sign_up/sign_up_cubit.dart';
import 'package:base_project/global/component/du_text_form_field.dart';
import 'package:base_project/global/style/constants.dart';
import 'package:base_project/global/style/du_button.dart';
import 'package:base_project/global/style/du_text_styles.dart';
import 'package:base_project/global/util/simple_logger.dart';
import 'package:base_project/global/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';

class PageEmailSignUp extends StatefulWidget {
  const PageEmailSignUp({Key? key}) : super(key: key);

  @override
  State<PageEmailSignUp> createState() => _PageEmailSignUpState();
}

class _PageEmailSignUpState extends State<PageEmailSignUp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: const PageEmailSignUpView(),
    );
  }
}

class PageEmailSignUpView extends StatefulWidget {
  const PageEmailSignUpView({super.key});

  @override
  State<PageEmailSignUpView> createState() => _PageEmailSignUpViewState();
}

class _PageEmailSignUpViewState extends State<PageEmailSignUpView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _tecEmail = TextEditingController();
  final TextEditingController _tecPassword = TextEditingController();
  final TextEditingController _tecPasswordCheck = TextEditingController();
  final TextEditingController _tecNickname = TextEditingController();

  @override
  void dispose() {
    _tecEmail.dispose();
    _tecPassword.dispose();
    _tecPasswordCheck.dispose();
    _tecNickname.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _body(),
    );
  }

  Widget _body() {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpLoaded) {
          context.go('/home');
        }
      },
      builder: (context, state) {
        if (state is SignUpLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SignUpError) {
          return Center(
            child: Text(state.errorMessage),
            // error page로 보내고 login으로 보내게 하는게 좋을듯
          );
        }
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          "회원가입.",
                          style: DUTextStyle.size18,
                        ),
                        const SizedBox(height: 53),
                        DUTextFormField(
                          controller: _tecEmail,
                          hintText: "이메일",
                          keyboardType: TextInputType.emailAddress,
                          // textInputAction: TextInputAction.next,
                          onEditingComplete: () =>
                              context.nextEditableTextFocus(),
                          showClear: true,
                          onChanged: (value) {},
                          validator: (val) {
                            return val == null ||
                                    !RegExp(Validation.emailRegex).hasMatch(val)
                                ? "이메일이 맞는지 확인해주세요"
                                : null;
                          },
                        ),
                        const SizedBox(height: 8),
                        DUTextFormField(
                          controller: _tecPassword,
                          hintText: "비밀번호",
                          showSecure: true,
                          isSecure: true,
                          onEditingComplete: () =>
                              context.nextEditableTextFocus(),
                          validator: (value) {
                            return value == null || value.length < 6
                                ? "비밀번호를 6 글자 이상으로 해주세요"
                                : null;
                          },
                        ),
                        const SizedBox(height: 8),
                        DUTextFormField(
                          controller: _tecPasswordCheck,
                          hintText: "비밀번호 확인",
                          showSecure: true,
                          isSecure: true,
                          onFieldSubmitted: (text) {
                            _signUp();
                          },
                          validator: (value) {
                            logger.i(
                                "$value == ${_tecPassword.text} = ${value == _tecPassword.text}");
                            return value == _tecPassword.text
                                ? null
                                : "비밀번호가 서로 다릅니다";
                          },
                        ),
                        const SizedBox(height: 8),
                        DUTextFormField(
                          controller: _tecNickname,
                          hintText: "닉네임",
                          showClear: true,
                          // onEditingComplete: () => context.nextEditableTextFocus(),
                          validator: (value) {
                            return value == null || value.isEmpty
                                ? "닉네임을 확인해주세요"
                                : null;
                          },
                        ),
                        const SizedBox(height: 24),
                        DUButton(
                          width: SizeConfig.screenWidth - 40,
                          text: "회원가입",
                          press: () {
                            _signUp();
                          },
                        ),
                        const SizedBox(height: 8),
                        DUButton(
                            width: SizeConfig.screenWidth - 40,
                            text: "로그인으로 돌아가기",
                            // press: () {},
                            press: () {
                              Navigator.of(context).pop();
                            },
                            type: ButtonType.transparent),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _signUp() async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    // 1. signUp
    await context
        .read<SignUpCubit>()
        .signUp(_tecEmail.text, _tecPassword.text, _tecNickname.text);
  }
}
