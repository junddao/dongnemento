import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';

class DUPhotoViewer extends StatefulWidget {
  const DUPhotoViewer({Key? key, required this.filePaths, required this.index}) : super(key: key);

  final List<String> filePaths;
  final int index;

  @override
  State<DUPhotoViewer> createState() => _DUPhotoViewerState();
}

class _DUPhotoViewerState extends State<DUPhotoViewer> {
  late PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: widget.index);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: Container(
        child: PageView.builder(
          controller: pageController,
          itemBuilder: (context, index) {
            String filePath = widget.filePaths[index];
            return PhotoView(
              imageProvider: CachedNetworkImageProvider(filePath),
            );
          },
          itemCount: widget.filePaths.length,
        ),
      ),
    );
  }
}
