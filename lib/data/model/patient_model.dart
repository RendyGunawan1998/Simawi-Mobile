import '../../core.dart';

class Patient implements CombinedUserPatient {
  final int id;
  final int recordNumber;
  final String name;
  final String birth;
  final String nik;
  final String phone;
  final String address;
  final String bloodType;
  final double weight;
  final double height;
  final String createdAt;
  final String updatedAt;

  Patient({
    required this.id,
    required this.recordNumber,
    required this.name,
    required this.birth,
    required this.nik,
    required this.phone,
    required this.address,
    required this.bloodType,
    required this.weight,
    required this.height,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['ID'] as int,
      recordNumber: json['RecordNumber'] as int,
      name: json['Name'] as String,
      birth: json['Birth'] as String,
      nik: json['NIK'] as String,
      phone: json['Phone'] as String,
      address: json['Address'] as String,
      bloodType: json['BloodType'] as String,
      weight: json['Weight'] as double,
      height: json['Height'] as double,
      createdAt: json['CreatedAt'] as String,
      updatedAt: json['UpdatedAt'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'RecordNumber': recordNumber,
      'Name': name,
      'Birth': birth,
      'NIK': nik,
      'Phone': phone,
      'Address': address,
      'BloodType': bloodType,
      'Weight': weight,
      'Height': height,
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt,
    };
  }

  @override
  Patient? get patient => this;

  @override
  UserModel? get user => null;
}
