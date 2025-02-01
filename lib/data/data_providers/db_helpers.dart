import '../../core.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('SIMRS_Test.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onUpgrade: _onUpgradeDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT';
    const intType = 'INTEGER';
    const boolType = 'BOOLEAN';
    // const floatType = 'REAL';

    await db.execute('''
    CREATE TABLE User (
      ID $intType,
      Email $textType,
      Password $textType,
      Name $textType,
      Role $textType,
      CreatedAt $textType,
      UpdatedAt $textType
    )
    ''');

    await db.execute('''
    CREATE TABLE Patient (
      ID $idType,
      RecordNumber $intType,
      Name $textType,
      Birth $textType,
      NIK $textType,
      Phone $textType,
      Address $textType,
      BloodType $textType,
      Weight $textType,
      Height $textType,
      CreatedAt $textType,
      UpdatedAt $textType
    )
    ''');

    await db.execute('''
    CREATE TABLE PatientHistory (
      ID $idType,
      RecordNumber $intType,
      DateVisit $textType,
      RegisteredBy $intType,
      ConsultationBy $intType,
      Symptoms $textType,
      DoctorDiagnose $textType,
      ICD10Code $textType,
      ICD10Name $textType,
      isDone $boolType,
      FOREIGN KEY (RecordNumber) REFERENCES Patient (RecordNumber),
      FOREIGN KEY (RegisteredBy) REFERENCES User (ID),
      FOREIGN KEY (ConsultationBy) REFERENCES User (ID)
    )
    ''');

    await _insertDummyData(db);
  }

  Future _onUpgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute('ALTER TABLE Patient ADD COLUMN NewColumn TEXT');
    }
  }

  Future insertPatientHistory(
      Map<String, dynamic> data, Patient patient) async {
    final db = await database;
    final existingPatient = await db.query(
      'Patient',
      where: 'ID = ?',
      whereArgs: [patient.id],
    );

    print('existingPatient :: $existingPatient');
    print('patient :: ${patient.toJson()}');
    print('data :: $data');
    final existingHistory = await db.query(
      'PatientHistory',
      where: 'RecordNumber = ? AND DateVisit = ?',
      whereArgs: [data['RecordNumber'], data['DateVisit']],
    );

    if (existingHistory.isEmpty) {
      await db.insert(
        'PatientHistory',
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      await db.update(
        'PatientHistory',
        data,
        where: 'RecordNumber = ? AND DateVisit = ?',
        whereArgs: [data['RecordNumber'], data['DateVisit']],
      );
    }

    Get.snackbar('Success', 'Patient data success added');
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    try {
      final db = await instance.database;
      return await db.insert('User', user);
    } catch (e) {
      print('Error inserting user: $e');
      return -1;
    }
  }

  Future<void> _insertDummyData(Database db) async {
    final List<Map<String, dynamic>> dummyUsers = [
      {
        'ID': 1,
        'Email': 'admin@example.com',
        'Password': 'admin123',
        'Name': 'Admin',
        'Role': 'Admin',
        'CreatedAt': DateTime.now().toIso8601String(),
        'UpdatedAt': DateTime.now().toIso8601String(),
      },
      {
        'ID': 2,
        'Email': 'doctor@example.com',
        'Password': 'doctor123',
        'Name': 'Dr. John Doe',
        'Role': 'Doctor',
        'CreatedAt': DateTime.now().toIso8601String(),
        'UpdatedAt': DateTime.now().toIso8601String(),
      },
      {
        'ID': 3,
        'Email': 'doctor2@example.com',
        'Password': 'doctor123',
        'Name': 'Dr. Jane Smith',
        'Role': 'Doctor',
        'CreatedAt': DateTime.now().toIso8601String(),
        'UpdatedAt': DateTime.now().toIso8601String(),
      },
    ];

    for (var user in dummyUsers) {
      await db.insert('User', user);
    }
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    try {
      final db = await instance.database;
      return await db.query('User');
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }

  Future<int> updateUser(int id, Map<String, dynamic> user) async {
    try {
      final db = await instance.database;
      return await db.update(
        'User',
        user,
        where: 'ID = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error updating user: $e');
      return -1;
    }
  }

  Future<int> deleteUser(int id) async {
    try {
      final db = await instance.database;
      return await db.delete(
        'User',
        where: 'ID = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error deleting user: $e');
      return -1;
    }
  }

  Future<int> insertPatient(Map<String, dynamic> patient) async {
    try {
      final db = await instance.database;
      return await db.insert('Patient', patient);
    } catch (e) {
      print('Error inserting patient: $e');
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> getAllPatients() async {
    try {
      final db = await instance.database;
      return await db.query('Patient');
    } catch (e) {
      print('Error fetching patients: $e');
      return [];
    }
  }

  Future<int> updatePatient(int id, Map<String, dynamic> patient) async {
    try {
      final db = await instance.database;
      return await db.update(
        'Patient',
        patient,
        where: 'ID = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error updating patient: $e');
      return -1;
    }
  }

  Future<int> deletePatient(int id) async {
    try {
      final db = await instance.database;
      return await db.delete(
        'Patient',
        where: 'ID = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error deleting patient: $e');
      return -1;
    }
  }

  Future<List<Map<String, dynamic>>> getAllPatientHistories() async {
    try {
      final db = await instance.database;
      return await db.query('PatientHistory');
    } catch (e) {
      print('Error fetching patient histories: $e');
      return [];
    }
  }

  Future<int> updatePatientHistory(int id, Map<String, dynamic> history) async {
    try {
      final db = await instance.database;
      return await db.update(
        'PatientHistory',
        history,
        where: 'ID = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error updating patient history: $e');
      return -1;
    }
  }

  Future<int> deletePatientHistory(int id) async {
    try {
      final db = await instance.database;
      return await db.delete(
        'PatientHistory',
        where: 'ID = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error deleting patient history: $e');
      return -1;
    }
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
