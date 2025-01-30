import 'package:http/http.dart' as http;

import '../../core.dart';

class ICDAuthService {
  Future<String> getAccessToken() async {
    try {
      final response = await http.post(
        Uri.parse(TOKENURL),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'grant_type': 'client_credentials',
          'client_id': CLIENTID,
          'client_secret': CLIENTSECRET,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['access_token'];
      } else {
        throw Exception(
            'Failed to get access token. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error get access token: $e');
    }
  }
}
