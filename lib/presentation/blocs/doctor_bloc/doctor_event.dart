abstract class DoctorEvent {}

class LoadPatientsForDoctorEvent extends DoctorEvent {
  final int doctorId;

  LoadPatientsForDoctorEvent(this.doctorId);
}

class FilterPatientsByStatus extends DoctorEvent {
  final String isDone;
  final int doctorId;
  FilterPatientsByStatus(this.isDone, this.doctorId);
}

class UpdateMedicalRecordEvent extends DoctorEvent {
  final int doctorID;
  final int recordNumber;
  final String symptoms;
  final String doctorDiagnose;
  final String icd10Code;
  final String icd10Name;
  final int consultationBy;

  UpdateMedicalRecordEvent({
    required this.doctorID,
    required this.recordNumber,
    required this.symptoms,
    required this.doctorDiagnose,
    required this.icd10Code,
    required this.icd10Name,
    required this.consultationBy,
  });
}
