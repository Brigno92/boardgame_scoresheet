import 'package:boardgame_scoresheet/dtos/score_row_dto.dart';

class ScoresheetDto {
  late String name;
  late int maxPlayers;
  late List<ScoreRowDto> scoreRows;

  toMap() {
    return {
      'name': name,
      'maxPlayers': maxPlayers,
    };
  }
}