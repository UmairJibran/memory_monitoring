import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:memory_checkup/models/model_patient.dart';
import 'package:meta/meta.dart';

part 'filter_records_state.dart';

class FilterRecordsCubit extends Cubit<FilterRecordsState> {
  FilterRecordsCubit() : super(FilterRecordsInitial());

  void filterRecords({
    required String patients,
    bool filterUniquePreferenceSets = false,
    bool filterUniqueConsistentSets = false,
  }) {
    List<PatientModel> filteredPatients = [];
    var listOfPatients = json.decode(patients);
    for (var patient in listOfPatients) {
      filteredPatients.add(PatientModel.fromJson(patient));
    }
    emit(FilteredRecords(filteredPatients));
  }
}
