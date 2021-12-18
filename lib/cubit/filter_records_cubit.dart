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
    List<PatientModel> allPatients = [];
    var listOfPatients = json.decode(patients);
    for (var patient in listOfPatients) {
      allPatients.add(PatientModel.fromJson(patient));
    }

    if (filterUniquePreferenceSets) {
      List<PatientModel> uniquePatientsByPreferenceSets = [];
      List<String> uniqPrefs = [];
      for (PatientModel element in allPatients) {
        if (!uniqPrefs.contains(element.pref)) {
          uniquePatientsByPreferenceSets.add(element);
          uniqPrefs.add(element.pref!);
        }
      }
      allPatients = [...uniquePatientsByPreferenceSets];
    }

    if (filterUniqueConsistentSets) {
      List<PatientModel> uniquePatientsByPreferenceSets = [];
      List<String> uniqCons = [];
      for (PatientModel element in allPatients) {
        if (!uniqCons.contains(element.cons)) {
          uniquePatientsByPreferenceSets.add(element);
          uniqCons.add(element.cons!);
        }
      }
      allPatients = [...uniquePatientsByPreferenceSets];
    }

    emit(FilteredRecords(allPatients));
  }
}
