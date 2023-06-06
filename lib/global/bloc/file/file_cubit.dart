import 'dart:io';

import 'package:base_project/global/enum/file_type.dart';
import 'package:base_project/global/model/file/model_file_response.dart';
import 'package:base_project/global/repository/api_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../util/util.dart';

part 'file_state.dart';

class FileCubit extends Cubit<FileState> {
  FileCubit() : super(FileInitial());

  Future<void> uploadImages(List<File> images, String dest) async {
    try {
      emit(FileLoading());

      final response = await ApiService().postMultiPart('$endPoint/upload/file', images, FileType.image, dest);

      ModelFileResponse productImageResponse = ModelFileResponse.fromMap(response);

      emit(FileLoaded(result: productImageResponse.data!));
    } catch (e) {
      emit(FileError(errorMessage: e.toString()));
    }
  }
}
