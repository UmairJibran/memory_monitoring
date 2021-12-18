import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memory_checkup/cubit/file_picker_cubit.dart';
import 'package:memory_checkup/cubit/filter_records_cubit.dart';

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
              String response = state.response.readAsLinesSync().join('\n');
              return BlocConsumer<FilterRecordsCubit, FilterRecordsState>(
                listener: (context, state) {
                  // implement listener
                },
                builder: (context, state) {
                  return BlocBuilder<FilterRecordsCubit, FilterRecordsState>(
                    builder: (filterRecordsBuilderContext, recordState) {
                      BlocProvider.of<FilterRecordsCubit>(context)
                          .filterRecords(patients: response);
                      if (recordState is FilteredRecords) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            return Text(recordState.records[index].toString());
                          },
                          itemCount: recordState.records.length,
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  );
                },
              );
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
