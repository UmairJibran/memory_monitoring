part of 'file_picker_cubit.dart';

@immutable
abstract class FilePickerState {}

class FilePickerInitial extends FilePickerState {}

class FilePickingStarted extends FilePickerState {}

class FilePickerCancelled extends FilePickerState {}

class FilePicked extends FilePickerState {
  final File response;

  FilePicked({required this.response});
}
