import 'package:intl/intl.dart';

import '../../core.dart';

class PatientRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<List<CombinedUserPatient>> getAllPatientsUser() async {
    try {
      final db = await _databaseHelper.database;
      final patients = await db.query('Patient');
      final doctorResult = await db.query('User');

      print('doctorResult :: $doctorResult');
      List<CombinedUserPatient> combinedData = [];

      for (var patient in patients) {
        final patientModel = Patient.fromJson(patient);
        combinedData.add(patientModel);
      }

      for (var doctor in doctorResult) {
        final userModel = UserModel.fromMap(doctor);
        combinedData.add(userModel);
      }

      return combinedData;
    } catch (e) {
      throw Exception('Failed to fetch patientsand user: $e');
    }
  }

  Future<List<CombinedUserPatient>> searchPatientsByName(String name) async {
    try {
      final db = await _databaseHelper.database;
      final patientResults = await db.query(
        'Patient',
        where: 'Name LIKE ?',
        whereArgs: ['%$name%'],
      );

      final userResults = await db.query(
        'User',
        where: 'Name LIKE ?',
        whereArgs: ['%$name%'],
      );

      final patientHistoryResults = await db.query(
        'PatientHistory',
        where: 'DateVisit LIKE ?',
        whereArgs: ['%$name%'],
      );

      List<CombinedUserPatient> combinedData = [];

      for (var patient in patientResults) {
        final patientModel = Patient.fromJson(patient);
        combinedData.add(CombinedUserPatient(
          patient: patientModel,
        ));
      }

      for (var user in userResults) {
        final userModel = UserModel.fromMap(user);
        combinedData.add(CombinedUserPatient(user: userModel));
      }

      for (var history in patientHistoryResults) {
        final recordNumber = history['RecordNumber'];
        final matchingPatient = await db.query(
          'Patient',
          where: 'RecordNumber = ?',
          whereArgs: [recordNumber],
        );

        if (matchingPatient.isNotEmpty) {
          final patientModel = Patient.fromJson(matchingPatient.first);
          combinedData.add(CombinedUserPatient(
            patient: patientModel,
          ));
        }
      }
      print('list data search :: $combinedData');
      return combinedData;
    } catch (e) {
      throw Exception('Failed to search patients: $e');
    }
  }

  Future<void> addPatient(Patient patient) async {
    try {
      final db = await _databaseHelper.database;
      await db.insert('Patient', {
        'RecordNumber': patient.recordNumber,
        'Name': patient.name,
        'Birth': patient.birth,
        'NIK': patient.nik,
        'Phone': patient.phone,
        'Address': patient.address,
        'BloodType': patient.bloodType,
        'Weight': patient.weight,
        'Height': patient.height,
        'CreatedAt': DateTime.now().toIso8601String(),
        'UpdatedAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Gagal menambahkan pasien: $e');
    }
  }

  Future<void> addAppointmentPatient(PatientHistory patient) async {
    try {
      print('make appointment');
      final db = await _databaseHelper.database;

      var res = await db.insert('PatientHistory', {
        'RecordNumber': patient.recordNumber,
        'DateVisit': DateFormat('dd MMM yyyy').format(patient.dateVisit),
        'RegisteredBy': 1,
        'ConsultationBy': patient.consultationBy,
        'Symptoms': patient.symptoms,
        'DoctorDiagnose': patient.doctorDiagnose,
        'ICD10Code': patient.icd10Code,
        'ICD10Name': patient.icd10Name,
        'isDone': false,
      });

      print('res :: $res');
    } catch (e) {
      print('Err appointment :: ${e.toString()}');
      throw Exception('Gagal menambahkan pasien: $e');
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      final db = await _databaseHelper.database;
      var res = await db.update(
        'User',
        {
          'Name': user.name,
          'Email': user.email,
          'Password': user.password,
          'UpdatedAt': DateTime.now().toIso8601String(),
        },
        where: 'ID = ?',
        whereArgs: [user.id],
      );
      print('RES user :: $res');
    } catch (e) {
      print('Err update user :: ${e.toString()}');
      throw Exception('Gagal update user: $e');
    }
  }

  Future<String?> getDiagnosaByPatientId(int patientId) async {
    try {
      final db = await _databaseHelper.database;
      final result = await db.query(
        'PatientHistory',
        columns: ['DoctorDiagnose'],
        where: 'RecordNumber = ?',
        whereArgs: [patientId],
      );

      if (result.isNotEmpty) {
        return result.first['DoctorDiagnose'] as String?;
      }
      return null;
    } catch (e) {
      print('Error fetching diagnosa: $e');
      return null;
    }
  }

  getDoctorByPatientId(int patientId) async {
    try {
      final db = await _databaseHelper.database;
      final result = await db.query(
        'PatientHistory',
        columns: ['ConsultationBy'],
        where: 'RecordNumber = ?',
        whereArgs: [patientId],
      );

      if (result.isNotEmpty) {
        return result.first['ConsultationBy'] as int;
      }
    } catch (e) {
      print('Error fetching diagnosa: $e');
    }
  }

  Future<void> updatePatient(
    Patient patient,
  ) async {
    try {
      final db = await _databaseHelper.database;

      await db.update(
        'Patient',
        {
          'RecordNumber': patient.recordNumber,
          'Name': patient.name,
          'Birth': patient.birth,
          'NIK': patient.nik,
          'Phone': patient.phone,
          'Address': patient.address,
          'BloodType': patient.bloodType,
          'Weight': patient.weight,
          'Height': patient.height,
          'UpdatedAt': DateTime.now().toIso8601String(),
        },
        where: 'ID = ?',
        whereArgs: [patient.id],
      );
    } catch (e) {
      throw Exception('Gagal memperbarui data pasien: $e');
    }
  }

  Future<void> deletePatient(int id) async {
    try {
      final db = await _databaseHelper.database;
      await db.delete(
        'Patient',
        where: 'ID = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw Exception('Failed to delete patient: $e');
    }
  }

  Future<List<PatientWithHistory>> getPatientsForDoctor(int doctorId) async {
    final db = await _databaseHelper.database;
    print('doctorId :: $doctorId');
    final result = await db.query(
      'PatientHistory',
      where: 'ConsultationBy = ?',
      whereArgs: [doctorId],
    );
    print('patientResult :: $result');

    List<PatientWithHistory> patientsWithHistory = [];

    for (var item in result) {
      final patientResult = await db.query(
        'Patient',
        where: 'RecordNumber = ?',
        whereArgs: [item['RecordNumber']],
      );

      if (patientResult.isNotEmpty) {
        final patient = Patient.fromJson(patientResult.first);
        patientsWithHistory.add(
          PatientWithHistory(patient: patient, patientHistory: item),
        );
      }
    }

    return patientsWithHistory;
  }

  List<PatientWithHistory> filterPatientsByStatus(
      List<PatientWithHistory> patients, bool isDone) {
    return patients.where((item) {
      return item.patientHistory['isDone'] == (isDone ? 1 : 0);
    }).toList();
  }

  Future<List<UserModel>> getDoctorDropdown() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> doctorList = await db.query(
      'User',
      where: 'Role = ?',
      whereArgs: ['Doctor'],
    );

    return List.generate(doctorList.length, (index) {
      return UserModel.fromMap(doctorList[index]);
    });
  }

  Future<void> updateMedicalRecord(PatientHistory history) async {
    try {
      final db = await _databaseHelper.database;
      await db.update(
        'patient_history',
        history.toJson(),
        where: 'id = ?',
        whereArgs: [history.id],
      );
    } catch (e) {
      throw Exception('Failed to update medical record: $e');
    }
  }

  Future<void> updatePatientHistory(
      Map<String, dynamic> data, int recordNumber) async {
    final db = await DatabaseHelper.instance.database;

    await db.update(
      'PatientHistory',
      data,
      where: 'RecordNumber = ?',
      whereArgs: [recordNumber],
    );
  }
}
