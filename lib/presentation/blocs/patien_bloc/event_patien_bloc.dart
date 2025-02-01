import '../../../core.dart';

abstract class PatientEvent extends Equatable {
  const PatientEvent();

  @override
  List<Object?> get props => [];
}

class LoadPatients extends PatientEvent {}

class AddPatient extends PatientEvent {
  final Patient patient;

  const AddPatient(this.patient);

  @override
  List<Object?> get props => [patient];
}

class UpdateUserEvent extends PatientEvent {
  final UserModel user;

  const UpdateUserEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class AddAppointmentPatient extends PatientEvent {
  final PatientHistory appointment;

  const AddAppointmentPatient(this.appointment);

  @override
  List<Object?> get props => [appointment];
}

class UpdatePatient extends PatientEvent {
  final Patient patient;

  const UpdatePatient(this.patient);

  @override
  List<Object?> get props => [patient];
}

class DeletePatient extends PatientEvent {
  final int patientId;

  const DeletePatient(this.patientId);

  @override
  List<Object?> get props => [patientId];
}

class SearchPatientByName extends PatientEvent {
  final String name;

  const SearchPatientByName(this.name);

  @override
  List<Object?> get props => [name];
}

class LoadDoctors extends PatientEvent {}
