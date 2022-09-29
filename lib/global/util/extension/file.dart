import 'dart:io';

import 'package:base_project/global/util/extension/extension.dart';

extension FileExtension on File {
  ///
  ///
  /// Example:
  /// ```dart
  ///
  /// ```
  getFileSize({int decimals = 2}) {
    int bytes = lengthSync();
    return bytes.bytesToString(decimals: decimals);
  }
}
