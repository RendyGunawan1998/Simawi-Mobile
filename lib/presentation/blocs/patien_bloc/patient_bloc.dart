import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  final PatientRepository patientRepository;

  PatientBloc(this.patientRepository) : super(PatientInitial()) {
    on<LoadPatients>(_onLoadPatients);
    on<AddPatient>(_onAddPatient);
    on<UpdatePatient>(_onUpdatePatient);
    on<DeletePatient>(_onDeletePatient);
    on<SearchPatientByName>(_onSearchPatientByName);
  }

  Future<void> _onLoadPatients(
    LoadPatients event,
    Emitter<PatientState> emit,
  ) async {
    emit(PatientLoading());
    try {
      final combinedData = await patientRepository.getAllPatientsUser();
      print('success get patient and user :: $combinedData');
      if (combinedData.isNotEmpty) {
        emit(PatientLoaded(combinedData));
      } else {
        emit(PatientError('No patients found.'));
      }
    } catch (e) {
      emit(PatientError(e.toString()));
    }
  }

  Future<void> _onSearchPatientByName(
    SearchPatientByName event,
    Emitter<PatientState> emit,
  ) async {
    emit(PatientLoading());
    try {
      final patients = await patientRepository.searchPatientsByName(event.name);
      emit(PatientLoaded(patients));
    } catch (e) {
      emit(PatientError(e.toString()));
    }
  }

  Future<void> _onAddPatient(
    AddPatient event,
    Emitter<PatientState> emit,
  ) async {
    try {
      await patientRepository.addPatient(event.patient, event.doctorId,
          event.adminId, event.diagnosa, event.dateVisit);
      add(LoadPatients());
    } catch (e) {
      emit(PatientError(e.toString()));
    }
  }

  Future<void> _onUpdatePatient(
    UpdatePatient event,
    Emitter<PatientState> emit,
  ) async {
    try {
      await patientRepository.updatePatient(event.patient, event.doctorId,
          event.adminId, event.diagnosa, event.dateVisit);
      add(LoadPatients());
    } catch (e) {
      emit(PatientError(e.toString()));
    }
  }

  Future<void> _onDeletePatient(
    DeletePatient event,
    Emitter<PatientState> emit,
  ) async {
    try {
      await patientRepository.deletePatient(event.patientId);
      add(LoadPatients());
    } catch (e) {
      emit(PatientError(e.toString()));
    }
  }
}
