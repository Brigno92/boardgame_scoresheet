import 'package:boardgame_scoresheet/controllers/app_database.dart';
import 'package:boardgame_scoresheet/dtos/scoresheet_dto.dart';
import 'package:boardgame_scoresheet/entities/boardgame_sheet.dart';
import 'package:boardgame_scoresheet/entities/score_row.dart';
import 'package:sqflite/sqflite.dart';

class ScoresheetRepository {
  final AppDatabase _appDatabase = AppDatabase();

  Future<int> upsertSheet(Map<String, BoardgameSheet> item) async {
    final db = await _appDatabase.database;
    return db.insert(
      'bg_sheet',
      item,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> createSheet(ScoresheetDto dto) async {
    final dbFuture = await _appDatabase.database;
    var sheetId = await dbFuture.insert('bg_sheet', dto.toMap());
    for (var row in dto.scoreRows) {
      row.sheetId = sheetId;
      await dbFuture.insert('score_row', row.toMap());
    }
    return sheetId;
  }

  Future<int> deleteSheet(int id) async {
    final db = await _appDatabase.database;
    return db.delete('bg_sheet', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, BoardgameSheet>>> getSheets() async {
    final db = await _appDatabase.database;
    return db.query('bg_sheet') as List<Map<String, BoardgameSheet>>;
  }

  Future<BoardgameSheet> getSheetById(int id) async {
    final db = await _appDatabase.database;
    var sheet =
        db.query('bg_sheet', where: 'id = $id')
            as List<Map<String, BoardgameSheet>>;
    var rows =
        db.query('score_row', where: 'sheetId = $id')
            as List<Map<String, ScoreRow>>;
    var returnSheet = BoardgameSheet(
      id: id,
      name: sheet.first['name'] as String,
      maxPlayers: sheet.first['maxPlayers'] as int,
    );
    returnSheet.scoreRows = rows.map((rowMap) {
      var row = rowMap['score_row']!;
      return ScoreRow(row.name, row.positiveScore, row.id, row.sheetId);
    }).toList();

    return returnSheet;
  }
}
