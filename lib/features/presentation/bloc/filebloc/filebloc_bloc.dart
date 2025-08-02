import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

part 'filebloc_event.dart';
part 'filebloc_state.dart';

class FileblocBloc extends Bloc<FileblocEvent, FileblocState> {
  FileblocBloc() : super(FileblocInitial()) {
    on<PickFileEvent>(_onPickFile);
    on<ClearFileEvent>((event, emit) {
      _savedFiles.clear();
      emit(FileLoaded([]));
    });
  }

  final List<File> _savedFiles = [];

  Future<void> _onPickFile(PickFileEvent event, Emitter<FileblocState> emit) async {
    emit(FileLoading());

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
            emit(FileError("Invalid image file"));
            return;
          }

          final resizedImage = img.copyResize(originalImage, width: 600, height: 600);

          final resizedBytes = img.encodeJpg(resizedImage, quality: 85);
          savedFile = File('${dir.path}/$fileName')..writeAsBytesSync(resizedBytes);
        }

        _savedFiles.add(savedFile);
        emit(FileLoaded(List.from(_savedFiles))); // return a copy to avoid mutation
      } else {
        emit(FileError("No file selected"));
      }
    } catch (e) {
      emit(FileError("Error picking file: $e"));
    }
  }
}
