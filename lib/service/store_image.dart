import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'images.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE images (id INTEGER PRIMARY KEY, path TEXT)',
        );
      },
    );
  }

  Future<int> insertImage(String path) async {
    final db = await database;
    return await db.insert('images', {'path': path});
  }

  Future<String?> getImage() async {
    final db = await database;
    List<Map> maps = await db.query('images', limit: 1, orderBy: 'id DESC');
    if (maps.isNotEmpty) {
      return maps.first['path'] as String?;
    }
    return null;
  }
}