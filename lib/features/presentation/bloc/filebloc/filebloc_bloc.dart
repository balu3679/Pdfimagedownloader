import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

part 'filebloc_event.dart';
part 'filebloc_state.dart';

class FileblocBloc extends Bloc<FileblocEvent, FileblocState> {
  final Box<String> savedFilesBox = Hive.box<String>('savedFilesBox');

  FileblocBloc() : super(FileblocInitial()) {
    on<LoadSavedFilesEvent>(_onLoadSavedFiles);
    on<PickFileEvent>(_onPickFile);
    on<ClearFileEvent>((event, emit) {
      _savedFiles.clear();
      emit(FileLoaded([]));
    });
  }

  final List<File> _savedFiles = [];

  Future<void> _onLoadSavedFiles(LoadSavedFilesEvent event, Emitter<FileblocState> emit) async {
    _savedFiles.clear();

    for (final path in savedFilesBox.values) {
      final file = File(path);
      if (await file.exists()) {
        _savedFiles.add(file);
      } else {
        final keyToDelete = savedFilesBox.keys.firstWhere(
          (key) => savedFilesBox.get(key) == path,
          orElse: () => null,
        );
        if (keyToDelete != null) {
          await savedFilesBox.delete(keyToDelete);
        }
      }
    }

    emit(FileLoaded(List.from(_savedFiles)));
  }

  Future<void> _onPickFile(PickFileEvent event, Emitter<FileblocState> emit) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'pdf'],
      );

      if (result != null && result.files.single.path != null) {
        final pickedFile = File(result.files.single.path!);
        final dir = await getApplicationDocumentsDirectory();
        final fileName = result.files.single.name;

        File savedFile;

        if (fileName.endsWith('.pdf')) {
          savedFile = await pickedFile.copy('${dir.path}/$fileName');
        } else {
          final bytes = await pickedFile.readAsBytes();
          final originalImage = img.decodeImage(bytes);

          if (originalImage == null) {
            return;
          }

          final resizedImage = img.copyResize(originalImage, width: 600, height: 600);

          final resizedBytes = img.encodeJpg(resizedImage, quality: 85);
          savedFile = File('${dir.path}/$fileName')..writeAsBytesSync(resizedBytes);
        }

        _savedFiles.add(savedFile);
        await savedFilesBox.add(savedFile.path);
        emit(FileLoaded(List.from(_savedFiles))); // return a copy to avoid mutation
      }
    } catch (e) {
      emit(FileError("Error picking file: $e"));
    }
  }
}
