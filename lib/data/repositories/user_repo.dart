import '../../core.dart';

class UserRepository {
  final DatabaseHelper dbHelper;

  UserRepository({required this.dbHelper});

  Future<int> createUser(UserModel user) async {
    try {
      return await dbHelper.insertUser(user.toJson());
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      final data = await dbHelper.getAllUsers();
      return data.map((user) => UserModel.fromMap(user)).toList();
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }

  Future<int> updateUser(int id, UserModel user) async {
    try {
      return await dbHelper.updateUser(id, user.toJson());
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  Future<int> deleteUser(int id) async {
    try {
      return await dbHelper.deleteUser(id);
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }
}
