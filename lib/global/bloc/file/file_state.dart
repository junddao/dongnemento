part of 'file_cubit.dart';

abstract class FileState extends Equatable {
  const FileState();

  @override
  List<Object> get props => [];
}

class FileInitial extends FileState {
  @override
  List<Object> get props => [];
}

class FileLoading extends FileState {
  @override
  List<Object> get props => [];
}

class FileLoaded extends FileState {
  final FileModel result;
  const FileLoaded({required this.result});
  @override
  List<Object> get props => [result];
}

class FileError extends FileState {
  final String errorMessage;

  const FileError({
    this.errorMessage = '',
  }) : super();
  @override
  List<Object> get props => [errorMessage];
}
