import 'dart:io';

import 'package:base_project/global/bloc/auth/authentication/authentication_bloc.dart';
import 'package:base_project/global/component/du_loading.dart';
import 'package:base_project/global/component/du_text_form_field.dart';
import 'package:base_project/global/component/du_two_button_dialog.dart';
import 'package:base_project/global/model/user/model_user.dart';
import 'package:base_project/global/style/constants.dart';
import 'package:base_project/global/style/du_button.dart';
import 'package:base_project/global/style/du_colors.dart';
import 'package:base_project/global/style/du_text_styles.dart';
import 'package:base_project/global/util/extension/extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../global/bloc/auth/get_me/me_cubit.dart';
import '../../global/bloc/file/file_cubit.dart';
import '../../routes.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FileCubit(),
        ),
      ],
      child: const MorePageView(),
    );
  }
}

class MorePageView extends StatefulWidget {
  const MorePageView({super.key});

  @override
  State<MorePageView> createState() => _MorePageViewState();
}

class _MorePageViewState extends State<MorePageView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textNameController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  String? _imagePath;

  String _address = '';
  double? _lat;
  double? _lng;

  @override
  void initState() {
    _textNameController.text = context.read<MeCubit>().me.name ?? '';
    _address = context.read<MeCubit>().me.address ?? '';
    _lat = context.read<MeCubit>().me.lat;
    _lng = context.read<MeCubit>().me.lng;
    _imagePath = context.read<MeCubit>().me.profileImage;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _textNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: _body(),
    );
  }

  _appBar() {
    return AppBar(
      titleSpacing: 16,
      title: const Text('내정보'),
      centerTitle: false,
      automaticallyImplyLeading: false,
      actions: [
        PopupMenuButton<int>(
          onSelected: (value) async {
            if (value == 0) {
              _logout();
            } else if (value == 1) {
              bool result = await DUDialog.showTwoButtonDialog(
                  context: context,
                  title: '주의',
                  subTitle: '탈퇴 후 재가입은 운영자의 승인이 필요합니다.\n탈퇴 하시겠습니까?',
                  btn1Text: '아니요.',
                  btn2Text: '네');
              if (result == true) {
              } else {
                return;
              }
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 0,
              child: Text('로그아웃', style: DUTextStyle.size14),
            ),
            PopupMenuItem(
              value: 1,
              child: Text('탈퇴하기', style: DUTextStyle.size14.warning),
            ),
          ],
        ),
      ],
    );
  }

  Widget _body() {
    final FocusScopeNode node = FocusScope.of(context);

    return BlocConsumer<MeCubit, MeState>(
      listener: (context, state) {
        if (state is MeLoaded) {
          DUDialog.showOneButtonDialog(
            context: context,
            title: '성공',
            subTitle: '프로필이 수정되었습니다. 😃',
          );
        }
      },
      builder: (context, state) {
        if (state is MeLoading) {
          return const DULoading();
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
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultHorizontalPadding, vertical: kDefaultVerticalPadding),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            _onImageButtonPressed();
                          },
                          child: getProfileImage(),
                        ),
                        const SizedBox(width: 18),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(text: '안녕하세요\n', style: DUTextStyle.size18.grey1),
                                  TextSpan(
                                      text: context.watch<MeCubit>().me.name ?? '이름없음',
                                      style: DUTextStyle.size18.black),
                                  TextSpan(text: '님!', style: DUTextStyle.size18.grey1),
                                ],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 20),
                            Text(context.watch<MeCubit>().me.email ?? ''),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    const Text('이름 수정하기', style: DUTextStyle.size18B),
                    const SizedBox(height: 4),
                    DUTextFormField(
                      controller: _textNameController,

                      hintText: "변경하실 성명을 입력해주세요",
                      // errorText: "성명을 입력해주세요",

                      onEditingComplete: () => node.nextFocus(),
                      validator: (value) {
                        if (value!.length > 10) {
                          return "10자 내로 입력해주세요.";
                        }
                        if (value.isEmpty) {
                          return "이름을 입력해주세요.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    const Text('주소 변경하기', style: DUTextStyle.size18B),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text(context.watch<SingletonMeCubit>().me.address ?? ''),
                        Text(_address),
                        DUButton(
                            text: '변경하기',
                            press: () {
                              context.push(Routes.address, extra: {'setAddress': setAddress});
                            },
                            type: ButtonType.transparent),
                      ],
                    ),
                    const SizedBox(height: 40),
                    DUButton(
                        text: '수정하기',
                        press: () async {
                          ModelUser updatedMe = context.read<MeCubit>().me.copyWith(
                              address: _address,
                              lat: _lat,
                              lng: _lng,
                              name: _textNameController.text,
                              profileImage: _imagePath);

                          // server 정보 update
                          await context.read<MeCubit>().updateUser(updatedMe);
                        },
                        type: ButtonType.normal,
                        width: SizeConfig.screenWidth),
                    // const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onImageButtonPressed() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        context.read<FileCubit>().uploadImages([File(pickedFile.path)], 'profile');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('사진을 가져오지 못했습니다. 다시 시도해주세요.'),
        ),
      );
    }
  }

  Widget getProfileImage() {
    return BlocConsumer<FileCubit, FileState>(
      listener: ((context, state) {
        if (state is FileError) {
          DUDialog.showOneButtonDialog(context: context, title: '에러', subTitle: '사진 업로드에 실패했어요');
        }
      }),
      builder: (context, state) {
        if (state is FileLoading) {
          return const DULoading();
        }
        if (state is FileLoaded) {
          _imagePath = state.result.first;
        }

        return SizedBox(
          height: 80,
          width: 80,
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(300),
                  child: CachedNetworkImage(
                    imageUrl: _imagePath ?? defaultUser,
                    errorWidget: (context, url, error) => Image.network(defaultUser),
                    fit: BoxFit.cover,
                    height: 80,
                    width: 80,
                  )),
              Positioned(
                top: 60,
                left: 60,
                child: Container(
                  alignment: Alignment.center,
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      color: DUColors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(width: 1, color: DUColors.grey_06)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.camera_alt,
                        color: DUColors.grey_06,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _logout() async {
    context.read<AuthenticationBloc>().add(AuthenticationSignOut());
  }

  setAddress(String address, double? lat, double? lng) {
    _address = address;
    _lat = lat;
    _lng = lng;
    setState(() {});
  }
}
