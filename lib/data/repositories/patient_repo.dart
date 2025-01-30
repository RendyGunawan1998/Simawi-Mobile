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
      print('list data search :: $combinedData');
      return combinedData;
    } catch (e) {
      throw Exception('Failed to search patients: $e');
    }
  }

  Future<void> addPatient(Patient patient, int doctorId, int adminId,
      String diagnosa, String dateVisit) async {
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

      await db.insert('PatientHistory', {
        'RecordNumber': patient.recordNumber,
        'DateVisit': dateVisit,
        'RegisteredBy': adminId,
        'ConsultationBy': doctorId,
        'Symptoms': 'Tunggu Diagnosa',
        'DoctorDiagnose': diagnosa,
        'ICD10Code': 'Tunggu Kode ICD-10',
        'ICD10Name': 'Tunggu Nama ICD-10',
        'isDone': false,
      });
    } catch (e) {
      throw Exception('Gagal menambahkan pasien: $e');
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

  Future<void> updatePatient(Patient patient, int doctorId, int adminId,
      String diagnosa, String dateVisit) async {
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

      await db.update(
        'PatientHistory',
        {
          'DateVisit': dateVisit,
          'ConsultationBy': doctorId,
          'Symptoms': 'Tunggu Diagnosa',
          'DoctorDiagnose': diagnosa,
          'ICD10Code': 'Tunggu Kode ICD-10',
          'ICD10Name': 'Tunggu Nama ICD-10',
          'isDone': false,
        },
        where: 'RecordNumber = ?',
        whereArgs: [patient.recordNumber],
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
    final result = await db.query(
      'PatientHistory',
      where: 'ConsultationBy = ?',
      whereArgs: [doctorId],
    );

    List<PatientWithHistory> patientsWithHistory = [];

    for (var item in result) {
      // Query untuk mendapatkan data detail pasien terkait
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
