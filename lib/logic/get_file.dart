import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

Future<String?> _pickJSON(BuildContext context) async {
  late String json = "";
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.any,
    allowMultiple: false,
    dialogTitle: "Please pick a JSON file",
  );

  if (result != null) {
    File file = File(result.files.single.path!);
    json = await file.readAsLines().then((List<String> lines) {
      var temp = "";
      for (var element in lines) {
        temp += element;
      }
      return temp;
    });
    return json;
  } else {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('No file selected'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
