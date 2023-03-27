import 'dart:io';

import 'package:base_project/global/bloc/file/file_cubit.dart';
import 'package:base_project/global/bloc/map/create_pin/create_pin_cubit.dart';
import 'package:base_project/global/bloc/map/get_pins/get_pins_cubit.dart';
import 'package:base_project/global/bloc/map/location/location_cubit.dart';
import 'package:base_project/global/component/du_two_button_dialog.dart';
import 'package:base_project/global/model/pin/model_request_create_pin.dart';
import 'package:base_project/global/model/pin/model_request_get_pin.dart';
import 'package:base_project/global/style/constants.dart';
import 'package:base_project/global/style/du_colors.dart';
import 'package:base_project/global/style/du_text_styles.dart';
import 'package:base_project/global/util/extension/extension.dart';
import 'package:base_project/pages/common/error_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:images_picker/images_picker.dart';

import '../../global/bloc/auth/get_me/me_cubit.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FileCubit(),
        ),
        BlocProvider(
          create: (context) => CreatePinCubit(),
        ),
      ],
      child: const PagePostCreateView(),
    );
  }
}

class PagePostCreateView extends StatefulWidget {
  const PagePostCreateView({super.key});

  @override
  State<PagePostCreateView> createState() => _PagePostCreateViewState();
}

class _PagePostCreateViewState extends State<PagePostCreateView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<String> imagePaths = [];

  LatLng? location;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
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
      title: const Text('글쓰기'),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          DUDialog.showTwoButtonDialog(context: context).then((value) {
            setState(() {
              if (value == true) {
                context.go('/map');
              }
            });
          });
        },
        icon: const Icon(
          Icons.close,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            onSave();
          },
          child: Text(
            '등록',
            style: DUTextStyle.size16M.tomato,
          ),
        ),
      ],
    );
  }

  Widget _body() {
    return BlocConsumer<FileCubit, FileState>(
      listener: ((context, state) {
        if (state is FileError) {
          DUDialog.showOneButtonDialog(context: context, title: '에러', subTitle: '사진 업로드에 실패했어요');
        }
      }),
      builder: (context, state) {
        if (state is FileLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is FileLoaded) {
          _createPin(imagePaths: state.result);
        }

        return BlocConsumer<CreatePinCubit, CreatePinState>(
          listener: (context, state) {
            if (state is CreatePinLoaded) {
              double lat = context.read<MeCubit>().me.lat ?? 0;
              double lng = context.read<MeCubit>().me.lng ?? 0;

              ModelRequestGetPin modelRequestGetPin = ModelRequestGetPin(
                lat: lat,
                lng: lng,
              );
              context.read<GetPinsCubit>().getPins(modelRequestGetPin);
              context.pop();
            }
            if (state is CreatePinError) {
              DUDialog.showOneButtonDialog(context: context, title: '에러', subTitle: '핀 생성에 실패했어요');
            }
          },
          builder: (context, state) {
            if (state is CreatePinLoading) {
              return const Center(
                child: CircularProgressIndicator(),
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
                physics: const ClampingScrollPhysics(),
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kDefaultHorizontalPadding, vertical: kDefaultVerticalPadding),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // 1. 제목
                        postTitle(),
                        const SizedBox(height: 20),
                        // 2. 내용
                        postContents(),
                        const SizedBox(height: 20),
                        // 3. 위치지정
                        postLocation(),
                        const SizedBox(height: 20),
                        // 4. 이미지
                        postImages(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  postTitle() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('제목', style: DUTextStyle.size16M),
            SizedBox(height: 40),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 54,
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 4),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: DUColors.pinkish_grey, width: 1)),
          child: TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              hintText: "제목을 입력해주세요.",
              hintStyle: DUTextStyle.size16.grey3,
              labelStyle: const TextStyle(color: Colors.transparent),
              border: const UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
            validator: (text) {
              return text == null ? '제목을 입력해주세요.' : null;
            },
          ),
        ),
      ],
    );
  }

  postContents() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('내용', style: DUTextStyle.size16M),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          height: 150,
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 4),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: DUColors.pinkish_grey, width: 1)),
          child: TextFormField(
            maxLines: null,
            controller: _bodyController,
            decoration: InputDecoration(
              hintText: "내용을 입력해주세요.",
              hintStyle: DUTextStyle.size16.grey3,
              labelStyle: const TextStyle(color: Colors.transparent),
              border: const UnderlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
            validator: (text) {
              return text == null ? '제목을 입력해주세요.' : null;
            },
          ),
        ),
      ],
    );
  }

  postLocation() {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        String? address;
        if (state is LocationError) {
          return ErrorPage(exception: state.errorMessage);
        }
        if (state is LocationLoaded) {
          address = state.postLocation!.address;
        }
        return Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('장소', style: DUTextStyle.size16M),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  getMyLocation();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: DUColors.greyish),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('현재 위치로 선택', style: DUTextStyle.size12.grey0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('PageSelectLocation');
            },
            child: Row(
              children: [
                const Icon(Icons.location_pin, color: DUColors.pinkish_grey),
                const SizedBox(width: 10),
                Text(address ?? '위치 선택', style: DUTextStyle.size14.grey0),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ]);
      },
    );
  }

  getMyLocation() {
    double lng = context.read<MeCubit>().me.lng!;
    double lat = context.read<MeCubit>().me.lat!;
    LatLng location = LatLng(lat, lng);

    context.read<LocationCubit>().setPostLocation(location);
  }

  postImages() {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Text('사진', style: DUTextStyle.size16M),
        ],
      ),
      const SizedBox(height: 10),
      SizedBox(
        height: 80,
        width: double.infinity,
        child: Row(
          children: [
            getAddPhotoBtn(),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imagePaths.length,
                itemBuilder: (context, index) {
                  return getImages(index);
                },
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  Widget getImages(index) {
    return RawMaterialButton(
      onPressed: () async {
        imagePaths.removeAt(index);
        setState(() {});
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.file(
                File(imagePaths[index]),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: _getSelectedPhotoEraseCircle(),
          )
        ],
      ),
    );
  }

  Widget _getSelectedPhotoEraseCircle() {
    return SizedBox(
      height: 20,
      width: 20,
      child: CircleAvatar(
        backgroundColor: DUColors.black05.withOpacity(0.8),
        child: Icon(
          Icons.close,
          size: 16,
          color: Colors.white.withOpacity(0.8),
        ),
      ),
    );
  }

  Widget getAddPhotoBtn() {
    return InkWell(
      onTap: () async {
        try {
          List<Media>? res = await ImagesPicker.pick(
            count: 5,
            pickType: PickType.image,
          );
          if (res == null) {
            return;
          }
          imagePaths = res.map(
            (e) {
              return e.path;
            },
          ).toList();

          setState(() {});
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('사진을 가져오지 못했습니다. 다시 시도해주세요.'),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, right: 10),
        child: Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(color: DUColors.black05, width: 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.image_outlined,
                color: DUColors.black05,
              ),
              const SizedBox(height: 4),
              Text(
                '1 / 5',
                style: DUTextStyle.size10.grey1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onSave() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("빈칸을 채워주세요."),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    List<File> files = imagePaths.map((e) {
      return File(e);
    }).toList();

    if (files.isNotEmpty) {
      context.read<FileCubit>().uploadImages(files);
    } else {
      _createPin();
    }
  }

  void _createPin({List<String>? imagePaths}) {
    double lat = context.read<LocationCubit>().state.postLocation!.lat!;
    double lng = context.read<LocationCubit>().state.postLocation!.lng!;

    location = LatLng(lat, lng);

    ModelRequestCreatePin requestCreatePin = ModelRequestCreatePin(
      lat: location!.latitude,
      lng: location!.longitude,
      title: _titleController.text,
      body: _bodyController.text,
      images: imagePaths,
    );

    context.read<CreatePinCubit>().createPin(requestCreatePin);
  }
}
