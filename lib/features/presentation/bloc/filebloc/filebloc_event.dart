part of 'filebloc_bloc.dart';

sealed class FileblocEvent {}

class PickFileEvent extends FileblocEvent {}

class ClearFileEvent extends FileblocEvent {}
