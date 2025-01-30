import 'package:simawi/core.dart';

class UserModel implements CombinedUserPatient {
  final int? id;
  final String email;
  final String password;
  final String name;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Email': email,
      'Password': password,
      'Name': name,
      'Role': role,
      'CreatedAt': createdAt.toIso8601String(),
      'UpdatedAt': updatedAt.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['ID'] as int?,
      email: map['Email'] as String,
      password: map['Password'] as String,
      name: map['Name'] as String,
      role: map['Role'] as String,
      createdAt: DateTime.parse(map['CreatedAt'] as String),
      updatedAt: DateTime.parse(map['UpdatedAt'] as String),
    );
  }

  // UserModel copyWith({
  //   int? id,
  //   String? email,
  //   String? password,
  //   String? name,
  //   String? role,
  //   DateTime? createdAt,
  //   DateTime? updatedAt,
  // }) {
  //   return UserModel(
  //     id: id ?? this.id,
  //     email: email ?? this.email,
  //     password: password ?? this.password,
  //     name: name ?? this.name,
  //     role: role ?? this.role,
  //     createdAt: createdAt ?? this.createdAt,
  //     updatedAt: updatedAt ?? this.updatedAt,
  //   );
  // }

  @override
  Patient? get patient => null;

  @override
  UserModel? get user => this;
}
