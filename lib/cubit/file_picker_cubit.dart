import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

part 'file_picker_state.dart';

class FilePickerCubit extends Cubit<FilePickerState> {
  FilePickerCubit() : super(FilePickerInitial());

  void reset() {
    emit(FilePickerInitial());
  }

  Future<String?> pickJSON() async {
    emit(FilePickingStarted());
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
      dialogTitle: "Please pick a JSON file",
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      emit(FilePicked(response: file));
    } else {
      emit(FilePickerCancelled());
    }
  }
}
