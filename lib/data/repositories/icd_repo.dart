import '../../core.dart';

class ICDRepository {
  final ICDAPIProvider icdAPIProvider;

  ICDRepository({required this.icdAPIProvider});

  Future<List<DestinationEntity>> searchICD(String query) async {
    return await icdAPIProvider.searchICD(query);
  }

  Future<Map<String, dynamic>> getICDDetail(String code) async {
    return await icdAPIProvider.getICDDetail(code);
  }
}
