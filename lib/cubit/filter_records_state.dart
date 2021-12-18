part of 'filter_records_cubit.dart';

@immutable
abstract class FilterRecordsState {}

class FilterRecordsInitial extends FilterRecordsState {}

class FilteredRecords extends FilterRecordsState {
  final List<PatientModel> records;
  FilteredRecords(this.records);
}
