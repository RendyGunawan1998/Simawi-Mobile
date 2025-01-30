abstract class AdminEvent {}

class LoadPatientsEvent extends AdminEvent {}

class AddPatientEvent extends AdminEvent {
  final Map<String, dynamic> patientData;

  AddPatientEvent(this.patientData);
}

class DeletePatientEvent extends AdminEvent {
  final int id;

  DeletePatientEvent(this.id);
}

class UpdatePatientEvent extends AdminEvent {
  final int id;
  final Map<String, dynamic> updatedData;

  UpdatePatientEvent(this.id, this.updatedData);
}

class AssignDoctorEvent extends AdminEvent {
  final int patientId;
  final int doctorId;

  AssignDoctorEvent(this.patientId, this.doctorId);
}

class SearchICD10Event extends AdminEvent {
  final String keyword;

  SearchICD10Event(this.keyword);
}
