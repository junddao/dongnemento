import 'dart:io';

import 'package:base_project/global/component/du_two_button_dialog.dart';
import 'package:base_project/global/style/constants.dart';
import 'package:base_project/global/style/du_colors.dart';
import 'package:base_project/global/style/du_text_styles.dart';
import 'package:base_project/global/util/extension/extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PagePostCreate extends StatefulWidget {
  const PagePostCreate({Key? key}) : super(key: key);

  @override
  _PagePostCreateState createState() => _PagePostCreateState();
}

class _PagePostCreateState extends State<PagePostCreate> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LatLng? location;
  String? address;

  LatLng? myPostLocation;

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
      title: Text('글쓰기'),
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
            // onSave();
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
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultHorizontalPadding,
            vertical: kDefaultVerticalPadding),
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
    );
  }

  postTitle() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('제목', style: DUTextStyle.size16M),
            const SizedBox(height: 40),
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
    String? address = '';

    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('장소', style: DUTextStyle.size16M),
          const SizedBox(width: 8),
          InkWell(
            onTap: () {
              // getMyLocation();
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
            Text('위치 선택', style: DUTextStyle.size14.grey0)
          ],
        ),
      ),
      const SizedBox(height: 10),
    ]);
  }

  // getMyLocation() {
  //   var provider = context.read<LocationProvider>();
  //   location = provider.setMyPostLocation(provider.myLocation!);
  //   provider.getAddress(provider.myLocation!);
  // }

  postImages() {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
            // Expanded(
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: _selectedAssetList.length,
            //     itemBuilder: (context, index) {
            //       return getImages(index);
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    ]);
  }

  // Widget getImages(index) {
  //   return RawMaterialButton(
  //     onPressed: () async {
  //       // 클릭했을때 list 에 추가하고, 순서하고

  //       _selectedAssetList.removeAt(index);

  //       _images.removeAt(index);
  //       setState(() {});
  //     },
  //     child: Stack(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.only(top: 10, right: 10),
  //           child: ClipRRect(
  //               borderRadius: BorderRadius.circular(10),
  //               child: Image(
  //                   width: 60,
  //                   height: 60,
  //                   image: AssetEntityImageProvider(_selectedAssetList[index],
  //                       isOriginal: false))
  //               // child: CachedNetworkImage(
  //               //   imageUrl: imageUrls[index],
  //               //   width: 60,
  //               //   height: 60,
  //               //   fit: BoxFit.cover,
  //               // ),
  //               ),
  //         ),
  //         Positioned(
  //           right: 0,
  //           top: 0,
  //           child: _getSelectedPhotoEraseCircle(),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Future<void> getFileList() async {
  //   _images.clear();

  //   for (final AssetEntity asset in _selectedAssetList) {
  //     // If the entity `isAll`, that's the "Recent" entity you want.
  //     File? file = await asset.originFile;
  //     if (file != null) {
  //       var filePath = file.absolute.path;
  //       print('original size = ${asset.width} / ${asset.height}');
  //       if (asset.width > 1080 && asset.height > 1080) {
  //         final int? shorterSide =
  //             asset.width < asset.height ? asset.width : asset.height;
  //         final int resizePercent = (1080.0 / shorterSide! * 100).toInt();

  //         File compressedFile = await FlutterNativeImage.compressImage(filePath,
  //             quality: 50, percentage: resizePercent);

  //         print('resize Percent = $resizePercent');
  //         print('compressed File = ${compressedFile.toString()}');

  //         filePath = compressedFile.path;
  //       }
  //       try {
  //         if (filePath.toLowerCase().endsWith(".heic") ||
  //             filePath.toLowerCase().endsWith(".heif")) {
  //           String? jpgPath = await HeicToJpg.convert(filePath);
  //           File file = File(jpgPath!);

  //           _images.add(file);
  //         } else {
  //           File file = File(filePath);

  //           _images.add(file);
  //         }
  //       } on Exception catch (e) {
  //         print(e.toString());
  //       }
  //     }
  //   }
  // }

  // Widget _getSelectedPhotoEraseCircle() {
  //   return Container(
  //     height: 20,
  //     width: 20,
  //     child: CircleAvatar(
  //       child: Icon(
  //         Icons.close,
  //         size: 16,
  //         color: Colors.white.withOpacity(0.8),
  //       ),
  //       backgroundColor: DUColors.black05.withOpacity(0.8),
  //     ),
  //   );
  // }

  Widget getAddPhotoBtn() {
    return InkWell(
      onTap: () async {
        // _selectedAssetList = (await DSImagePicker().cameraAndStay(
        //     context: context, assets: _selectedAssetList, maxAssetsCount: 5))!;
        // await getFileList();
        // setState(() {});
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

  // Future<void> updateImageToServer() async {
  //   if (_images.isNotEmpty) {
  //     await context
  //         .read<FileProvider>()
  //         .uploadImages(_images)
  //         .then((value) async {
  //       _imageUrls = value!.images!;
  //     });
  //   }
  // }

  // void onSave() async {
  //   if (!_formKey.currentState!.validate()) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text("빈칸을 채워주세요."),
  //         backgroundColor: Colors.red,
  //       ),
  //     );

  //     return;
  //   }

  //   location = context.read<LocationProvider>().myPostLocation;
  //   EasyLoading.show(status: 'loading...', dismissOnTap: true);
  //   // 이미지 보내기
  //   try {
  //     await updateImageToServer().catchError((onError) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: const Text('이미지 업로드에 실패했습니다. 이미지를 다시 선택 후 시도해 주세요.'),
  //         ),
  //       );
  //       throw Exception();
  //     });
  //     ModelRequestCreatePin requestCreatePin = ModelRequestCreatePin(
  //       lat: location!.latitude,
  //       lng: location!.longitude,
  //       title: _titleController.text,
  //       body: _bodyController.text,
  //       images: _imageUrls,
  //     );

  //     await context
  //         .read<LocationProvider>()
  //         .createPin(requestCreatePin)
  //         .catchError((onError) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: const Text('생성에 실패하였습니다. 다시 시도해 주세요.'),
  //         ),
  //       );
  //       throw Exception();
  //     });
  //     EasyLoading.dismiss();
  //     Navigator.of(context)
  //         .pushNamedAndRemoveUntil('PageMap', (route) => false);
  //   } catch (e) {
  //     print(e);
  //   } finally {
  //     EasyLoading.dismiss();
  //   }
  // }
}
