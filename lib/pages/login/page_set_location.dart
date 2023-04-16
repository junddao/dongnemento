import 'package:base_project/global/style/du_text_styles.dart';
import 'package:base_project/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../global/bloc/auth/get_me/me_cubit.dart';
import '../../global/model/user/model_user.dart';
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
    return BlocConsumer<MeCubit, MeState>(
      listener: (context, state) {
        if (state is MeLoaded) {
          context.push(Routes.map);
        }
      },
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
                  press: () {
                    context.push(Routes.address, extra: {'setAddress': setAddress});
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

  setAddress(String address, double? lat, double? lng) async {
    ModelUser updatedMe = context.read<MeCubit>().me.copyWith(address: address, lat: lat, lng: lng);

    // server 정보 update
    await context.read<MeCubit>().updateUser(updatedMe);
    // updateMe 필요
    // context.read<GetMeCubit>().me.copyWith(address: address, lat: lat, lng: lng);
  }
}
