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
  late bool togglePrefs;
  late bool toggleCons;

  @override
  void initState() {
    togglePrefs = false;
    toggleCons = false;
    super.initState();
  }

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
              return BlocBuilder<FilterRecordsCubit, FilterRecordsState>(
                builder: (context, state) {
                  return BlocBuilder<FilterRecordsCubit, FilterRecordsState>(
                    builder: (filterRecordsBuilderContext, recordState) {
                      BlocProvider.of<FilterRecordsCubit>(context)
                          .filterRecords(
                        patients: response,
                        filterUniquePreferenceSets: togglePrefs,
                        filterUniqueConsistentSets: toggleCons,
                      );
                      if (recordState is FilteredRecords) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            children: [
                              ButtonBar(
                                children: [
                                  const Text("Prefs"),
                                  Switch(
                                    value: togglePrefs,
                                    onChanged: (value) {
                                      setState(() {
                                        togglePrefs = value;
                                      });
                                    },
                                  ),
                                  const Text("Cons"),
                                  Switch(
                                    value: toggleCons,
                                    onChanged: (value) {
                                      setState(() {
                                        toggleCons = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height - 150,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                          recordState.records[index].ruleBody!),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Pref: " +
                                              recordState.records[index].pref!),
                                          Text("Con: " +
                                              recordState.records[index].cons!),
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: recordState.records.length,
                                ),
                              ),
                            ],
                          ),
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
