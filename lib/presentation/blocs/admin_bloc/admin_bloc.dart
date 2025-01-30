import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  AdminBloc() : super(AdminInitial()) {
    on<LoadPatientsEvent>(_onLoadPatients);
    on<AddPatientEvent>(_onAddPatient);
    on<DeletePatientEvent>(_onDeletePatient);
    on<UpdatePatientEvent>(_onUpdatePatient);
    on<AssignDoctorEvent>(_onAssignDoctor);
    on<SearchICD10Event>(_onSearchICD10);
  }

  Future<void> _onLoadPatients(
      LoadPatientsEvent event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      final patients = await _dbHelper.getAllPatients();
      emit(AdminSuccess(patients));
    } catch (e) {
      emit(AdminFailure('Failed to load patients: $e'));
    }
  }

  Future<void> _onAddPatient(
      AddPatientEvent event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      final existingPatient = await _dbHelper
          .getPatientByRecordNumber(event.patientData['RecordNumber']);
      if (existingPatient != null) {
        emit(AdminFailure('Patient already registered.'));
      } else {
        await _dbHelper.insertPatient(event.patientData);
        emit(AdminSuccess('Patient added successfully.'));
      }
    } catch (e) {
      emit(AdminFailure('Failed to add patient: $e'));
    }
  }

  Future<void> _onDeletePatient(
      DeletePatientEvent event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      await _dbHelper.deletePatient(event.id);
      emit(AdminSuccess('Patient deleted successfully.'));
    } catch (e) {
      emit(AdminFailure('Failed to delete patient: $e'));
    }
  }

  Future<void> _onUpdatePatient(
      UpdatePatientEvent event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      await _dbHelper.updatePatient(event.id, event.updatedData);
      emit(AdminSuccess('Patient updated successfully.'));
    } catch (e) {
      emit(AdminFailure('Failed to update patient: $e'));
    }
  }

  Future<void> _onAssignDoctor(
      AssignDoctorEvent event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      await _dbHelper.assignDoctorToPatient(event.patientId, event.doctorId);
      emit(AdminSuccess('Doctor assigned successfully.'));
    } catch (e) {
      emit(AdminFailure('Failed to assign doctor: $e'));
    }
  }

  Future<void> _onSearchICD10(
      SearchICD10Event event, Emitter<AdminState> emit) async {
    emit(AdminLoading());
    try {
      final icd10Results = await _dbHelper.searchICD10(event.keyword);
      emit(AdminSuccess(icd10Results));
    } catch (e) {
      emit(AdminFailure('Failed to search ICD-10 codes: $e'));
    }
  }
}
