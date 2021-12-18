import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_checkup/cubit/file_picker_cubit.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = "/home";

  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          BlocBuilder<FilePickerCubit, FilePickerState>(
            builder: (builderContext, state) {
              return IconButton(
                icon: const Icon(Icons.delete_outline_sharp),
                onPressed: () {
                  BlocProvider.of<FilePickerCubit>(builderContext).reset();
                },
              );
            },
          )
        ],
      ),
      body: Center(
        child: BlocConsumer<FilePickerCubit, FilePickerState>(
          listener: (listenerContext, state) {
            if (state is FilePicked) {
              ScaffoldMessenger.of(listenerContext).showSnackBar(
                SnackBar(
                  content: Text(state.response.path),
                ),
              );
            }
          },
          builder: (BuildContext builderContext, FilePickerState state) {
            if (state is FilePickerInitial) {
              return ElevatedButton(
                child: const Text(
                  "Load JSON",
                ),
                onPressed: () {
                  BlocProvider.of<FilePickerCubit>(builderContext).pickJSON();
                },
              );
            } else if (state is FilePicked) {
              String value = state.response.readAsLinesSync().join('\n');
              var map = json.decode(value);
              map.forEach((value) => {print(value)});
              return const Text("File Picked");
            } else if (state is FilePickerCancelled) {
              return const Text('No file selected');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
