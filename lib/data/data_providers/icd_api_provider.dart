import 'package:http/http.dart' as http;
import '../../core.dart';

class ICDAPIProvider {
  Future<List<DestinationEntity>> searchICD(String query) async {
    try {
      final accessToken = await ICDAuthService().getAccessToken();
      final url = Uri.parse('$URL_ICD/search?q=$query');
      print('URL SEARCH ENTITY :: $url');
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
          "API-Version": 'v2',
          "Accept-Language": 'en',
        },
      );
      print('RES S.CODE :: ${response.statusCode}');
      print('RES S.BODY :: ${response.body}');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = (data['destinationEntities'] as List)
                .map((item) => DestinationEntity.fromJson(item))
                .toList() ??
            [];
        return results;
      } else {
        throw Exception('FAIL FETCH ICD DATA, S.CODE :: ${response.body}');
      }
    } catch (e) {
      throw Exception('ERROR FETCH ICD DATA :: $e');
    }
  }

  Future<Map<String, dynamic>> getICDDetail(String code) async {
    try {
      final accessToken = await ICDAuthService().getAccessToken();
      final url = Uri.parse('$URL_ICD/$code');

      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
          "API-Version": 'v2',
          "Accept-Language": 'en',
        },
      );

      print('RES S.CODE ICD DETAIL :: ${response.statusCode}');
      print('RES S.BODY ICD DETAIL :: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        throw Exception(
            'FAIL GET DETAIL ICD, S.CODE :: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('ERROR GET DETAIL ICD :: $e');
    }
  }

  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  Future<void> submitMedicalRecord({
    required int recordNumber,
    required int registeredBy,
    required String dateVisit,
    required int consultationBy,
    required String symptoms,
    required String doctorDiagnose,
    required String icd10Code,
    required String icd10Name,
    required int id,
    required String name,
    required String date,
  }) async {
    final recordData = {
      'RecordNumber': recordNumber,
      'DateVisit': dateVisit,
      'RegisteredBy': registeredBy,
      'ConsultationBy': consultationBy,
      'Symptoms': symptoms,
      'DoctorDiagnose': doctorDiagnose,
      'ICD10Code': icd10Code,
      'ICD10Name': icd10Name,
      'isDone': 1,
    };

    final patient = Patient(
      id: id,
      recordNumber: recordNumber,
      name: name,
      birth: '',
      nik: '',
      phone: '',
      address: '',
      bloodType: '',
      weight: '',
      height: '',
      createdAt: date,
      updatedAt: DateTime.now().toIso8601String(),
    );

    final dbHelper = DatabaseHelper.instance;
    await dbHelper.insertPatientHistory(recordData, patient);
  }
}
