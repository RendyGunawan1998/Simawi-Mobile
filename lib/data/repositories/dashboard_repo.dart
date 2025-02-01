import '../../core.dart';

class DashboardRepo {
  Future<List<ICD10Diagnosis>> getTopICDCodes() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.rawQuery('''
      SELECT ICD10Code, COUNT(*) AS count
      FROM PatientHistory
      GROUP BY ICD10Code
      ORDER BY count DESC
      LIMIT 5
    ''');

    return result.map((e) => ICD10Diagnosis.fromJson(e)).toList();
  }

  Future<int> getPatientCount() async {
    final db = await DatabaseHelper.instance.database;
    var result = await db.rawQuery('SELECT COUNT(*) FROM Patient');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<List<Patient>> getRecentPatients() async {
    final db = await DatabaseHelper.instance.database;
    var result = await db.query(
      'Patient',
      orderBy: 'CreatedAt DESC',
      limit: 5,
    );
    return result.map((json) => Patient.fromJson(json)).toList();
  }
}
