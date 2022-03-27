import 'package:bloc_test/bloc_test.dart';
import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:equatable/equatable.dart';

import 'package:memory_checkup/cubit/file_picker_cubit.dart';

void main() {
  group('File Picker Repository', () {
    setUp(() {
      EquatableConfig.stringify = true;
    });

    blocTest<FilePickerCubit, FilePickerState>(
      'The initial state for the `filePicker` cubit is FilePickerInitial()',
      build: () => FilePickerCubit(),
      act: (value) => value.reset(),
      expect: () => [
        FilePickerInitial(),
      ],
    );
  });
}
