import 'package:base_project/global/bloc/auth/authentication/authentication_bloc.dart';
import 'package:base_project/global/bloc/singleton_me/singleton_me_cubit.dart';
import 'package:base_project/global/component/du_sized_box.dart';
import 'package:base_project/global/component/du_text_form_field.dart';
import 'package:base_project/global/component/du_title.dart';
import 'package:base_project/global/model/etc/kakao_local_result.dart';
import 'package:base_project/global/model/user/model_user.dart';
import 'package:base_project/global/repository/api_service.dart';
import 'package:base_project/global/style/constants.dart';
import 'package:base_project/global/style/du_colors.dart';
import 'package:base_project/global/style/du_text_styles.dart';
import 'package:base_project/global/util/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:go_router/go_router.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController textController = TextEditingController();
  ScrollController scrollController = ScrollController();

  /// 페이지
  int page = 1;

  /// 데이터
  List<KakaoLocalResult> data = [];

  /// 로딩여부
  bool isLoading = false;

  /// 추가 호출 여부
  bool hasMore = false;

  /// 최초 여부
  bool isFirst = true;

  /// API호출부분
  _loadData() async {
    isFirst = false;

    // show loading
    setState(() {
      isLoading = true;
    });

    // List<Map<String, dynamic>> items = [];

    KakaoLocalResponseData results =
        await ApiService().getKakaoAddress(textController.text);

    for (KakaoLocalResult result in results.documents) {
      data.add(result);
    }

    setState(() {
      isLoading = false;
    });
  }

  /// 새로검색
  _newSearch() async {
    data.clear();
    page = 1;
    _loadData();
  }

  /// 추가검색
  _loadMore() {
    page += 1;
    _loadData();
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('주소 찾기'),
      ),
      body: _build(context),
    );
  }

  Widget _build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultVerticalPadding,
        horizontal: kDefaultHorizontalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DUTextFormField(
            controller: textController,
            hintText: '도로명,식장명,번지 검색',
            autofocus: true,
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
              _newSearch();
            },
          ),
          if (isFirst) ...[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DUSizedBox.h16(),
                  DUTitle.size16('tip', isBold: true),
                  const DUSizedBox.h8(),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                          text:
                              '아래와 같은 조합으로 검색을 하시면 더욱 정확한 결과가 검색됩니다\n\n도로명 + 건물번호\n',
                          style: DUTextStyle.size14.grey0.h1_5,
                          children: [
                            TextSpan(
                                text: '예) 판교역로 221',
                                style: const TextStyle().subBlue),
                            TextSpan(
                                text: '\n\n지역명(동/리) + 번지\n',
                                style: const TextStyle().grey0),
                            TextSpan(
                                text: '예) 삼평동 672번지',
                                style: const TextStyle().subBlue),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            if (data.isEmpty) ...[
              Expanded(
                child: isLoading
                    ? const Center(child: RefreshProgressIndicator())
                    : const Center(child: Text('주소 정보가 없습니다.')),
              ),
            ] else ...[
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels >=
                            scrollInfo.metrics.maxScrollExtent &&
                        hasMore) {
                      if (!isLoading) {
                        _loadMore();
                        return true;
                      }
                    }
                    return false;
                  },
                  child: ListView.separated(
                    itemCount: data.length + 1,
                    itemBuilder: (_, index) {
                      if (index < data.length) {
                        KakaoLocalResult item = data[index];
                        return ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.place_name ?? "",
                                  style: DUTextStyle.size14),
                              const SizedBox(height: 4),
                              Text(
                                item.address_name ?? "",
                                style: DUTextStyle.size12
                                    .copyWith(color: DUColors.grey1),
                              ),
                            ],
                          ),
                          onTap: () {
                            ModelUser me =
                                GetIt.I.get<SingletonMeCubit>().me.copyWith(
                                      address: item.address_name,
                                      lat: double.parse(item.x),
                                      lng: double.parse(item.y),
                                    );

                            context
                                .read<SingletonMeCubit>()
                                .updateSingletonMe(me);

                            context.pop();
                          },
                        );
                      }
                      if (isLoading) {
                        return const Align(
                            alignment: Alignment.topCenter,
                            child: RefreshProgressIndicator());
                      }

                      return const SizedBox.shrink();
                    },
                    separatorBuilder: (_, index) =>
                        const Divider(color: DUColors.grey3),
                  ),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
