import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class DUPhotoViewer extends StatefulWidget {
  const DUPhotoViewer({Key? key, String? filePath})
      : _filePath = filePath,
        super(key: key);

  final String? _filePath;

  @override
  _DUPhotoViewerState createState() => _DUPhotoViewerState();
}

class _DUPhotoViewerState extends State<DUPhotoViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Container(
        child: PhotoView(
          imageProvider: CachedNetworkImageProvider(widget._filePath!),
        ),
      ),
    );
  }
}
