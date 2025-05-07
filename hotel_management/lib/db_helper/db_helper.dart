import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async{
    if (_database != null) return _database!;
    _database = await _initDB();
    return database!;
  }

  Future<Database> _initDB() async{
    String path = join(await getDatabasesPath(), 'hotelapp.db');
    String sql = "";
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async{
        await db.execute(sql);
      }
    )
  }
}