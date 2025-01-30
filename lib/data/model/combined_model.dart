import '../../core.dart';

class CombinedUserPatient {
  final Patient? patient;
  final UserModel? user;

  CombinedUserPatient({this.patient, this.user});

  // Menggabungkan data yang ada pada kedua model
  factory CombinedUserPatient.fromPatientAndUser(
      Patient patient, UserModel user) {
    return CombinedUserPatient(patient: patient, user: user);
  }

  Map<String, dynamic> toJson() {
    return {
      'patient': patient?.toJson(),
      'user': user?.toJson(),
    };
  }

  factory CombinedUserPatient.fromJson(Map<String, dynamic> json) {
    return CombinedUserPatient(
      patient: json['patient'],
      user: json['user'],
    );
  }
}
