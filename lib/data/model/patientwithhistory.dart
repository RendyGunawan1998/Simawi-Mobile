import '../../core.dart';

class PatientWithHistory {
  final Patient patient;
  final Map<String, dynamic> patientHistory;

  PatientWithHistory({
    required this.patient,
    required this.patientHistory,
  });
}
