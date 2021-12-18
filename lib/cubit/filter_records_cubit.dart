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

    if (filterUniquePreferenceSets) {
      List<PatientModel> uniquePatientsByPreferenceSets = [];
      List<String> uniqPrefs = [];
      for (PatientModel element in filteredPatients) {
        if (!uniqPrefs.contains(element.pref)) {
          uniquePatientsByPreferenceSets.add(element);
          uniqPrefs.add(element.pref!);
        }
      }
      filteredPatients = [...uniquePatientsByPreferenceSets];
    }

    if (filterUniqueConsistentSets) {
      List<PatientModel> uniquePatientsByPreferenceSets = [];
      List<String> uniqCons = [];
      for (PatientModel element in filteredPatients) {
        if (!uniqCons.contains(element.cons)) {
          uniquePatientsByPreferenceSets.add(element);
          uniqCons.add(element.cons!);
        }
      }
      filteredPatients = [...uniquePatientsByPreferenceSets];
    }

    emit(FilteredRecords(filteredPatients));
  }
}
