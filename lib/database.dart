import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'fuel_data_model.dart'; // Import your model

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'fuel_database.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE fuel_data( id INTEGER PRIMARY KEY, meter REAL, rate REAL, amount REAL, date TEXT, fuelType TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertFuelData(FuelData data) async {
    final db = await database;
    await db.insert(
      'fuel_data',
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<FuelData>> fetchFuelData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('fuel_data', orderBy: 'id DESC');
    return List.generate(maps.length, (i) {
      return FuelData(
        id: maps[i]['id'],
        meter: maps[i]['meter'],
        rate: maps[i]['rate'],
        amount: maps[i]['amount'],
        date: maps[i]['date'],
        fuelType: maps[i]['fuelType']
      );
    });
  }
  Future<void> deleteFuelData(int id) async {
    final db = await database;
    await db.delete(
      'fuel_data',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
