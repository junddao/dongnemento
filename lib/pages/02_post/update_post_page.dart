import 'dart:io';

import 'package:base_project/global/bloc/file/file_cubit.dart';
import 'package:base_project/global/bloc/map/create_pin/create_pin_cubit.dart';
import 'package:base_project/global/bloc/map/get_pin/get_pin_cubit.dart';
import 'package:base_project/global/bloc/map/update_pin/update_pin_cubit.dart';
import 'package:base_project/global/component/du_two_button_dialog.dart';
import 'package:base_project/global/enum/category_type.dart';
import 'package:base_project/global/model/pin/model_request_update_pin.dart';
import 'package:base_project/global/style/constants.dart';
import 'package:base_project/global/style/du_colors.dart';
import 'package:base_project/global/style/du_text_styles.dart';
import 'package:base_project/global/util/extension/extension.dart';
import 'package:base_project/pages/common/error_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../global/model/pin/model_response_pin.dart';

class UpdatePostPage extends StatefulWidget {
  const UpdatePostPage({Key? key, required this.pinId}) : super(key: key);

  final String pinId;

  @override
  State<UpdatePostPage> createState() => _UpdatePostPageState();
}

class _UpdatePostPageState extends State<UpdatePostPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetPinCubit()..getPin(widget.pinId),
        ),
        BlocProvider(
          create: (context) => UpdatePinCubit(),
        ),
        BlocProvider(
          create: (context) => FileCubit(),
        ),
        BlocProvider(
          create: (context) => CreatePinCubit(),
        ),
      ],
      child: BlocBuilder<GetPinCubit, GetPinState>(
        builder: (context, state) {
          if (state is GetPinLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is GetPinError) {
            return ErrorPage(exception: state.errorMessage);
          }
          if (state is GetPinLoaded) {
            return PagePostCreateView(pin: state.result);
          }
          return Container();
        },
      ),
    );
  }
}

class PagePostCreateView extends StatefulWidget {
  const PagePostCreateView({super.key, required this.pin});

  final ModelResponsePin pin;

  @override
  State<PagePostCreateView> createState() => _PagePostCreateViewState();
}

class _PagePostCreateViewState extends State<PagePostCreateView> {
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;
  late final TextEditingController _dateController;

  late DateTime startDate;
  late DateTime endDate;

  late double lat;
  late double lng;

  final _formKey = GlobalKey<FormState>();

  late final ValueNotifier<CategoryType> category;
  double categoryScore = 40;

  // List<String> imagePaths = [];

  LatLng? location;

  final ImagePicker _picker = ImagePicker();
  late final ValueNotifier<List<String>> imagePaths;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.pin.title);
    _bodyController = TextEditingController(text: widget.pin.body);
    _dateController = TextEditingController(
        text: '${DateFormat.MEd().format(widget.pin.startDate!)} ~ ${DateFormat.MEd().format(widget.pin.endDate!)}');

    startDate = widget.pin.startDate!;
    endDate = widget.pin.endDate!;
    category = ValueNotifier(widget.pin.category);
    imagePaths = ValueNotifier(widget.pin.images ?? []);

    lat = widget.pin.lat!;
    lng = widget.pin.lng!;
    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(child: _body()),
    );
  }

  AppBar _appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text('글 수정하기'),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          DUDialog.showTwoButtonDialog(context: context, subTitle: '수정을 취소하시겠습니까?').then((value) {
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
          onPressed: () async {
            await onSave();
          },
          child: Text(
            '수정하기',
            style: DUTextStyle.size16M.tomato,
          ),
        ),
      ],
    );
  }

  Widget _body() {
    return BlocConsumer<UpdatePinCubit, UpdatePinState>(
      listener: (context, state) {
        if (state is UpdatePinLoaded) {
          context.read<GetPinCubit>().getPin(widget.pin.id);
          context.pop();
        }
        if (state is UpdatePinError) {
          DUDialog.showOneButtonDialog(context: context, title: '에러', subTitle: '핀 수정에 실패했어요');
        }
      },
      builder: (context, state) {
        if (state is UpdatePinLoading) {
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
              padding: const EdgeInsets.symmetric(vertical: kDefaultVerticalPadding),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // 1. 제목
                    postTitle(),

                    // 2. 내용
                    postContents(),

                    // 3. 시작일 / 종료일 선택
                    postStartDate(),

                    postCategory(),

                    // 3. 위치지정
                    // postLocation(),
                    // const Divider(thickness: 1),

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
  }

  postTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultHorizontalPadding, vertical: kDefaultVerticalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('🪧 지도에 표시되는 제목입니다.'),
          const SizedBox(height: 16),
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(
              hintText: "제목을 입력해주세요.",
              hintStyle: DUTextStyle.size16.grey2,
              labelStyle: const TextStyle(color: Colors.transparent),
              border: const OutlineInputBorder(),
            ),
            validator: (text) {
              return text.isNullEmpty ? '제목을 입력해주세요.' : null;
            },
          ),
        ],
      ),
    );
  }

  postContents() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultHorizontalPadding, vertical: kDefaultVerticalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('😃 쓰고싶은 내용을 입력하세요. '),
          const SizedBox(height: 16),
          TextFormField(
            minLines: 3,
            maxLines: null,
            controller: _bodyController,
            decoration: InputDecoration(
              hintText: "내용을 입력해주세요.",
              hintStyle: DUTextStyle.size16.grey2,
              labelStyle: const TextStyle(color: Colors.transparent),
              border: const OutlineInputBorder(),
            ),
            validator: (text) {
              return text.isNullEmpty ? '내용을 입력해주세요.' : null;
            },
          ),
        ],
      ),
    );
  }

  postCategory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: kDefaultVerticalPadding),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.centerLeft,
            child: Text(
              '🤖 카테고리',
              style: DUTextStyle.size14.black,
            ),
          ),
          ChipsChoice<CategoryType>.single(
            value: category.value,
            onChanged: (val) => setState(() => category.value = val),
            choiceItems: C2Choice.listFrom<CategoryType, String>(
              source: CategoryType.values.map((e) => e.title).toList(),
              value: (i, v) => CategoryType.values[i],
              label: (i, v) => v,
            ),
            choiceCheckmark: true,
            wrapped: true,
            choiceStyle: C2ChipStyle.outlined(
              // borderWidth: 1,
              color: DUColors.grey2,
              selectedStyle: const C2ChipStyle(
                foregroundStyle: DUTextStyle.size14M,
                borderColor: DUColors.tomato,
                foregroundColor: DUColors.tomato,
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // postLocation() {
  //   return BlocBuilder<LocationCubit, LocationState>(
  //     builder: (context, state) {
  //       String? address;
  //       if (state is LocationError) {
  //         return ErrorPage(exception: state.errorMessage);
  //       }
  //       if (state is LocationLoaded) {
  //         address = state.postLocation!.address;
  //       }
  //       return Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: kDefaultHorizontalPadding, vertical: kDefaultVerticalPadding),
  //         child: Column(children: [
  //           InkWell(
  //             onTap: () {
  //               LatLng location = LatLng(state.postLocation!.lat!, state.postLocation!.lng!);
  //               context.push(Routes.selectLocation, extra: {'location': location});
  //             },
  //             child: Row(
  //               children: [
  //                 const Icon(Icons.location_pin, color: DUColors.pinkish_grey),
  //                 const SizedBox(width: 4),
  //                 Expanded(
  //                     child: Text(
  //                   address ?? '위치 선택',
  //                   maxLines: 2,
  //                   style: DUTextStyle.size14B.tomato,
  //                   overflow: TextOverflow.ellipsis,
  //                 )),
  //               ],
  //             ),
  //           ),
  //         ]),
  //       );
  //     },
  //   );
  // }

  postStartDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultHorizontalPadding, vertical: kDefaultVerticalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('📅 글을 게시할 기간을 선택하세요.', style: DUTextStyle.size14.black),
          const SizedBox(height: 8),
          TextFormField(
              readOnly: true,
              controller: _dateController,
              decoration: InputDecoration(
                hintText: "시작일 - 종료일",
                hintStyle: DUTextStyle.size12.grey2,
                labelStyle: DUTextStyle.size12.black,
                border: const OutlineInputBorder(),
              ),
              onTap: () async {
                var results = await showCalendarDatePicker2Dialog(
                  context: context,
                  config: CalendarDatePicker2WithActionButtonsConfig(
                    calendarType: CalendarDatePicker2Type.range,
                  ),
                  dialogSize: const Size(325, 400),
                  value: [startDate, endDate],
                  borderRadius: BorderRadius.circular(15),
                );

                if (results == null) {
                  return;
                }
                startDate = results.first!;
                endDate = results.last!;

                setState(() {
                  _dateController.text = '${DateFormat.MEd().format(startDate)} ~ ${DateFormat.MEd().format(endDate)}';
                  // _dateController.text =  '${startDate.month}/${startDate.day} ~ ${endDate.month}/${endDate.day}';
                });
              }),
        ],
      ),
    );
  }

  postImages() {
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
          imagePaths.value = state.result;
        }
        return ValueListenableBuilder<List<String>>(
            valueListenable: imagePaths,
            builder: (_, value, __) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultHorizontalPadding, vertical: kDefaultVerticalPadding),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.photo, color: DUColors.pinkish_grey),
                      const SizedBox(width: 4),
                      Text('사진', style: DUTextStyle.size14.pinkish_grey),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 80,
                    width: double.infinity,
                    child: Row(
                      children: [
                        getAddPhotoBtn(),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              return getImages(index, value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              );
            });
      },
    );
  }

  Widget getImages(index, List<String> value) {
    return RawMaterialButton(
      onPressed: () async {
        value.removeAt(index);
        imagePaths.value = [...value];
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: value[index],
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
          final List<XFile?> pickedFiles = await _picker.pickMultiImage(
            imageQuality: 30,
          );
          if (pickedFiles.isNotEmpty) {
            List<File> files = pickedFiles.map((e) => File(e!.path)).toList();
            if (mounted) context.read<FileCubit>().uploadImages(files, '${FlavorConfig.instance.name}/post');
          }
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
                '${imagePaths.value.length} / 5',
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

    _createPin();
  }

  void _createPin() {
    ModelRequestUpdatePin requestUpdatePin = ModelRequestUpdatePin(
      lat: lat,
      lng: lng,
      title: _titleController.text,
      body: _bodyController.text,
      category: category.value,
      categoryScore: categoryScore.toInt(),
      startDate: startDate,
      endDate: endDate,
      images: imagePaths.value,
    );

    context.read<UpdatePinCubit>().updatePin(requestUpdatePin, widget.pin.id);
  }
}
