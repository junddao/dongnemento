import 'package:base_project/global/component/du_loading.dart';
import 'package:base_project/global/style/constants.dart';
import 'package:base_project/global/style/du_colors.dart';
import 'package:base_project/pages/02_post/components/cell_post_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart' as path;

import '../../global/bloc/map/get_my_pins/get_my_pins_cubit.dart';
import '../../global/component/du_two_button_dialog.dart';
import '../../global/model/model.dart';
import '../../routes.dart';

class MyPostPage extends StatefulWidget {
  const MyPostPage({super.key});

  @override
  State<MyPostPage> createState() => _MyPostPageState();
}

class _MyPostPageState extends State<MyPostPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GetMyPinsCubit>(
          create: (context) => GetMyPinsCubit()..getMyPins(),
        ),
      ],
      child: const MyPostView(),
    );
  }
}

class MyPostView extends StatefulWidget {
  const MyPostView({super.key});

  @override
  State<MyPostView> createState() => _MyPostViewState();
}

class _MyPostViewState extends State<MyPostView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      centerTitle: false,
      title: const Text('내가 쓴글'),
    );
  }

  Widget _body() {
    return BlocConsumer<GetMyPinsCubit, GetMyPinsState>(
      listener: (context, state) {
        if (state is GetMyPinsError) {
          DUDialog.showOneButtonDialog(context: context, title: '핀 정보를 가져오지 못했어요. 😂', subTitle: '다시 시도해주세요.');
        }
      },
      builder: (context, state) {
        if (state is GetMyPinsLoading) {
          return const DULoading();
        }
        if (state is GetMyPinsLoaded) {
          List<ModelResponsePins> pins = state.result;
          return SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultHorizontalPadding, vertical: kDefaultVerticalPadding),
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CellPostItem(
                        pin: pins[index],
                        press: () {
                          onProduct(pins[index].id, pins[index].userId);
                        },
                      );
                    },
                    separatorBuilder: ((context, index) => const Divider(
                          color: DUColors.grey1,
                        )),
                    itemCount: pins.length,
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  void onProduct(String pinId, String userId) async {
    final result = await context.push<bool>(path.join(Routes.map, Routes.post, pinId, userId));

    context.read<GetMyPinsCubit>().getMyPins();
  }
}
