import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();
  static Database? _database;

  AppDatabase._internal();

  factory AppDatabase() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'boardgame_scoresheet.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await createSheetTable(db);
        await createScoreRowTable(db);
      },
    );
  }

  Future<void> createSheetTable(Database db) async {
    await db.execute('''
      CREATE TABLE bg_sheet (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        maxPlayers INTEGER NOT NULL
      )
    ''');
  }

  Future<void> createScoreRowTable(Database db) async {
    await db.execute('''
      CREATE TABLE score_row (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        sheetId INTEGER NOT NULL,
        name TEXT NOT NULL,
        positiveScore INTEGER NOT NULL,
        FOREIGN KEY (sheetId) REFERENCES bg_sheet(id) ON DELETE CASCADE
      )
    ''');
  }

}