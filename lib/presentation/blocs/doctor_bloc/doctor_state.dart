import '../../../core.dart';

abstract class DoctorState {}

class DoctorInitial extends DoctorState {}

class DoctorLoading extends DoctorState {}

class DoctorSuccess extends DoctorState {
  final List<PatientWithHistory> patients;

  DoctorSuccess(this.patients);
}

class DoctorFailure extends DoctorState {
  final String message;

  DoctorFailure(this.message);
}
