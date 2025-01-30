import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final PatientRepository patientRepo = PatientRepository();

  DoctorBloc() : super(DoctorInitial()) {
    on<LoadPatientsForDoctorEvent>(_onLoadPatientsForDoctor);
    on<FilterPatientsByStatus>(_onFilterPatientsForDoctor);
    on<UpdateMedicalRecordEvent>(_onUpdateMedicalRecord);
  }

  Future<void> _onLoadPatientsForDoctor(
      LoadPatientsForDoctorEvent event, Emitter<DoctorState> emit) async {
    emit(DoctorLoading());
    try {
      print('call load patient by doctor');
      final patients = await patientRepo.getPatientsForDoctor(event.doctorId);
      emit(DoctorSuccess(patients));
    } catch (e) {
      emit(DoctorFailure('Failed to load patients: $e'));
    }
  }

  Future<void> _onFilterPatientsForDoctor(
      FilterPatientsByStatus event, Emitter<DoctorState> emit) async {
    emit(DoctorLoading());
    try {
      print('call load patients by doctor');
      print('status :: ${event.isDone}');
      int stat = event.isDone == 'true' ? 1 : 0;
      print('stat :: $stat');
      final patients = await patientRepo.getPatientsForDoctor(event.doctorId);
      final filteredPatients = patients.where((patient) {
        return patient.patientHistory['isDone'] == stat;
      }).toList();
      emit(DoctorSuccess(filteredPatients));
    } catch (e) {
      emit(DoctorFailure('Failed to load patients: $e'));
    }
  }

  Future<void> _onUpdateMedicalRecord(
      UpdateMedicalRecordEvent event, Emitter<DoctorState> emit) async {
    emit(DoctorLoading());
    try {
      final updatedData = {
        'Symptoms': event.symptoms,
        'DoctorDiagnose': event.doctorDiagnose,
        'ICD10Code': event.icd10Code,
        'ICD10Name': event.icd10Name,
        'ConsultationBy': event.consultationBy,
      };

      await patientRepo.updatePatientHistory(updatedData, event.recordNumber);
      emit(DoctorSuccess([]));
      Get.offAll(() => DoctorPatientPage(
            doctorId: event.doctorID,
          ));
    } catch (e) {
      emit(DoctorFailure('Failed to update medical record: $e'));
    }
  }
}
