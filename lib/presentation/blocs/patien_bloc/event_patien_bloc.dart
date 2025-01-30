import '../../../core.dart';

abstract class PatientEvent extends Equatable {
  const PatientEvent();

  @override
  List<Object?> get props => [];
}

class LoadPatients extends PatientEvent {}

class AddPatient extends PatientEvent {
  final Patient patient;
  final int doctorId;
  final int adminId;
  final String diagnosa;
  final String dateVisit;

  const AddPatient(
      this.patient, this.doctorId, this.adminId, this.diagnosa, this.dateVisit);

  @override
  List<Object?> get props => [patient, doctorId];
}

class UpdatePatient extends PatientEvent {
  final Patient patient;
  final int doctorId;
  final int adminId;
  final String diagnosa;
  final String dateVisit;

  const UpdatePatient(
      this.patient, this.doctorId, this.adminId, this.diagnosa, this.dateVisit);

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
