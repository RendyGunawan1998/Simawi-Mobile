import '../../core.dart';

extension DatabaseHelperExtensions on DatabaseHelper {
  Future<List<Map<String, Object?>>> login(
      String email, String password) async {
    final db = await database;
    final result = await db.query(
      'User',
      where: 'Email = ? AND Password = ?',
      whereArgs: [email, password],
    );
    print('result ::$result');
    if (result.isNotEmpty) {
      return result;
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> getAllPatients() async {
    final db = await database;
    return await db.query('Patient');
  }

  Future<Map<String, dynamic>?> getPatientByRecordNumber(
      int recordNumber) async {
    final db = await database;
    final result = await db.query(
      'Patient',
      where: 'RecordNumber = ?',
      whereArgs: [recordNumber],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> assignDoctorToPatient(int patientId, int doctorId) async {
    final db = await database;
    await db.update(
      'PatientHistory',
      {'ConsultationBy': doctorId},
      where: 'RecordNumber = ?',
      whereArgs: [patientId],
    );
  }

  Future<List<Map<String, dynamic>>> searchICD10(String keyword) async {
    final db = await database;
    return await db.query(
      'PatientHistory',
      where: 'ICD10Name LIKE ?',
      whereArgs: ['%$keyword%'],
    );
  }
}
