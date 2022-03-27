part of 'file_picker_cubit.dart';

@immutable
abstract class FilePickerState extends Equatable {
  @override
  List<Object> get props => [];
}

class FilePickerInitial extends FilePickerState {}

class FilePickingStarted extends FilePickerState {}

class FilePickerCancelled extends FilePickerState {}

class FilePicked extends FilePickerState {
  final File response;

  FilePicked({required this.response});
}
