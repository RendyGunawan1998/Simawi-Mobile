import 'package:google_fonts/google_fonts.dart';
import 'package:simawi/core.dart';

String extractId(String id) {
  id = id.replaceAll('http://id.who.int/icd/entity/', '');
  return id;
}

textInter(String title, Color color, FontWeight fw, double fs) {
  return Text(title,
      style: GoogleFonts.inter(color: color, fontWeight: fw, fontSize: fs));
}

Future selectDate(BuildContext context) async {
  final pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );

  if (pickedDate != null) {
    return pickedDate;
  }
  return;
}

Future<String?> getDateVisitByRecordNumber(int recordNumber) async {
  final db = await DatabaseHelper.instance.database;

  final result = await db.query(
    'PatientHistory',
    columns: ['DateVisit'],
    where: 'RecordNumber = ?',
    whereArgs: [recordNumber],
    orderBy: 'DateVisit DESC',
  );

  if (result.isNotEmpty) {
    return result.first['DateVisit'] as String;
  } else {
    return null;
  }
}

Future<String> searchDateVisit(int recordNumber) async {
  final dateVisit = await getDateVisitByRecordNumber(recordNumber);

  if (dateVisit != null) {
    print('Date Visit found: $dateVisit');
    return dateVisit.toString();
  } else {
    print('No Date Visit found for Record Number $recordNumber');
    return "";
  }
}

Map<String, double> getDataMap(List<ICD10Diagnosis> topICDCodes) {
  Map<String, double> dataMap = {};
  for (var icd in topICDCodes) {
    dataMap[icd.icd10Code] = icd.count.toDouble();
  }
  return dataMap;
}
