import 'package:boardgame_scoresheet/BE/dtos/score_row_dto.dart';

class ScoresheetDto {
  late String name;
  late int maxPlayers;
  late List<ScoreRowDto> scoreRows;

  ScoresheetDto(this.name, this.maxPlayers, this.scoreRows);

  toMap() {
    return {
      'name': name,
      'maxPlayers': maxPlayers,
    };
  }
}