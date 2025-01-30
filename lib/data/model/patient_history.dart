class PatientHistory {
  final int? id;
  final int recordNumber;
  final DateTime dateVisit;
  final int registeredBy;
  final int consultationBy;
  final String symptoms;
  final String doctorDiagnose;
  final String icd10Code;
  final String icd10Name;
  final bool isDone;

  PatientHistory({
    this.id,
    required this.recordNumber,
    required this.dateVisit,
    required this.registeredBy,
    required this.consultationBy,
    required this.symptoms,
    required this.doctorDiagnose,
    required this.icd10Code,
    required this.icd10Name,
    required this.isDone,
  });

  factory PatientHistory.fromJson(Map<String, dynamic> json) {
    return PatientHistory(
      id: json['id'],
      recordNumber: json['recordnumber'],
      dateVisit: DateTime.parse(json['datevisit']),
      registeredBy: json['registeredBy'],
      consultationBy: json['consultationby'],
      symptoms: json['symptoms'],
      doctorDiagnose: json['doctordiagnose'],
      icd10Code: json['icd10code'],
      icd10Name: json['icd10Name'],
      isDone: json['isdone'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recordnumber': recordNumber,
      'datevisit': dateVisit.toIso8601String(),
      'registeredBy': registeredBy,
      'consultationby': consultationBy,
      'symptoms': symptoms,
      'doctordiagnose': doctorDiagnose,
      'icd10code': icd10Code,
      'icd10Name': icd10Name,
      'isdone': isDone ? 1 : 0,
    };
  }
}
