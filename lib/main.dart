import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_checkup/cubit/file_picker_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FilePickerCubit>(
          create: (BuildContext filePickerCubitContext) => FilePickerCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
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
                  BlocProvider.of<FilePickerCubit>(builderContext)
                      .startPicking();
                  BlocProvider.of<FilePickerCubit>(builderContext).pickJSON();
                },
              );
            } else if (state is FilePicked) {
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
