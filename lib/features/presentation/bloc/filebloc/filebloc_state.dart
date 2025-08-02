part of 'filebloc_bloc.dart';

sealed class FileblocState {}

final class FileblocInitial extends FileblocState {}

class FileLoading extends FileblocState {}

class FileLoaded extends FileblocState {
  final List<File> files;
  FileLoaded(this.files);
}

class FileError extends FileblocState {
  final String message;
  FileError(this.message);
}
