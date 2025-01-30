class ICD10Diagnosis {
  final String icd10Code;
  final int count;

  ICD10Diagnosis({
    required this.icd10Code,
    required this.count,
  });

  factory ICD10Diagnosis.fromJson(Map<String, dynamic> json) {
    return ICD10Diagnosis(
      icd10Code: json['ICD10Code'],
      count: json['count'],
    );
  }
}
