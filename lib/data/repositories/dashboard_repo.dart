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
}
