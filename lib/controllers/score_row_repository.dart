import 'package:boardgame_scoresheet/controllers/app_database.dart';
import 'package:boardgame_scoresheet/dtos/score_row_dto.dart';
import 'package:boardgame_scoresheet/entities/score_row.dart';

class ScoreRowRepository {
  final AppDatabase _appDatabase = AppDatabase();

  Future<int> insertRows(List<ScoreRowDto> rowDtos) async {
    final db = await _appDatabase.database;
    var result = 1;
    for (var row in rowDtos) {
      result = await db.insert('score_row', row.toMap());
    }
    return result;
  }

  Future<int> updateRow(int id, ScoreRowDto rowDto) async {
    final db = await _appDatabase.database;
    return db.update(
      'score_row',
      rowDto.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteRow(int id) async {
    final db = await _appDatabase.database;
    return db.delete('score_row', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, ScoreRow>>> getRows() async {
    final db = await _appDatabase.database;
    return db.query('score_row') as List<Map<String, ScoreRow>>;
  }

  Future<List<Map<String, ScoreRow>>> getRowById(int id) async {
    final db = await _appDatabase.database;
    return db.query('score_row', where: 'id = $id')
        as List<Map<String, ScoreRow>>;
  }
}
