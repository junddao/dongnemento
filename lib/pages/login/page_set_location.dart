import 'package:base_project/global/style/du_text_styles.dart';
import 'package:base_project/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../global/bloc/auth/get_me/me_cubit.dart';
import '../../global/style/constants.dart';
import '../../global/style/du_button.dart';
import '../common/error_page.dart';

class PageSetLocation extends StatefulWidget {
  const PageSetLocation({Key? key}) : super(key: key);

  @override
  State<PageSetLocation> createState() => _PageSetLocationState();
}

class _PageSetLocationState extends State<PageSetLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      // title: Text('시작 위치 지정'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go(Routes.login);
          }
        },
      ),
      centerTitle: true,
      elevation: 0,
    );
  }

  Widget _body() {
    SizeConfig().init(context);
    return BlocBuilder<MeCubit, MeState>(
      builder: (context, state) {
        if (state is MeLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is MeError) {
          return ErrorPage(exception: state.errorMessage);
        }
        return Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/address.svg',
                      height: SizeConfig.screenHeight * 0.4,
                    ),
                    const SizedBox(height: 50),
                    const Text('주변 소식을 받을', style: DUTextStyle.size18B),
                    const SizedBox(height: 8),
                    const Text('위치를 선택해주세요.', style: DUTextStyle.size18B),
                  ],
                ),
                DUButton(
                  press: () async {
                    context.push(Routes.address).then((value) async {
                      if (mounted) {
                        context.push(Routes.map);
                      }
                    });
                  },
                  text: '주소로 위치지정',
                  fontWeight: FontWeight.bold,
                  width: MediaQuery.of(context).size.width - kDefaultHorizontalPadding * 2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
