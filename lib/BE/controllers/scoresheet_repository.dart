import 'package:boardgame_scoresheet/BE/controllers/app_database.dart';
import 'package:boardgame_scoresheet/BE/dtos/scoresheet_dto.dart';
import 'package:boardgame_scoresheet/BE/entities/boardgame_sheet.dart';
import 'package:boardgame_scoresheet/BE/entities/score_row.dart';
import 'package:sqflite/sqflite.dart';

class ScoresheetRepository {
  final AppDatabase _appDatabase = AppDatabase();

  Future<int> updateSheet(int sheetId, ScoresheetDto dto) async {
    final db = await _appDatabase.database;

    return await db.transaction((txn) async {
      // 1. UPDATE SHEET
      await txn.update(
        'bg_sheet',
        BoardgameSheet.fromDto(dto, id: sheetId).toMap(),
        where: 'id = ?',
        whereArgs: [sheetId],
      );

      // 2. DELETE OLD ROWS
      await txn.delete(
        'score_row',
        where: 'sheetId = ?',
        whereArgs: [sheetId],
      );

      // 3. INSERT NEW ROWS
      for (final row in dto.scoreRows) {
        await txn.insert('score_row', row.toMap());
      }

      return sheetId;
    });
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

  Future<List<BoardgameSheet>> getSheets() async {
    final db = await _appDatabase.database;
    final result = await db.query('bg_sheet');
    return result.map((map) {
      return BoardgameSheet(
        id: map['id'] as int,
        name: map['name'] as String,
        maxPlayers: map['maxPlayers'] as int,
      );
    }).toList();
  }

  Future<BoardgameSheet> getSheetById(int id) async {
    final db = await _appDatabase.database;
    var sheet = await db.query('bg_sheet', where: 'id = $id', limit: 1);
    var rows = await db.query('score_row', where: 'sheetId = $id');
    var returnSheet = BoardgameSheet(
      id: sheet.first['id'] as int,
      name: sheet.first['name'] as String,
      maxPlayers: sheet.first['maxPlayers'] as int,
    );
    returnSheet.scoreRows = rows.map((row) {
      return ScoreRow(
        row['name'] as String,
        row['positiveScore'] == 1,
        row['id'] as int,
        row['sheetId'] as int,
      );
    }).toList();

    return returnSheet;
  }
}
