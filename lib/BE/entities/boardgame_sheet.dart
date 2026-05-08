import 'package:boardgame_scoresheet/BE/dtos/scoresheet_dto.dart';
import 'package:boardgame_scoresheet/BE/entities/score_row.dart';

class BoardgameSheet {
  final int id;
  final String name;
  final int maxPlayers;
  late List<ScoreRow> scoreRows = [];

  BoardgameSheet({
    required this.id,
    required this.name,
    required this.maxPlayers,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'maxPlayers': maxPlayers};
  }

  factory BoardgameSheet.fromDto(ScoresheetDto dto, {int? id}) {
    return BoardgameSheet(
      id: id ?? 0,
      name: dto.name,
      maxPlayers: dto.maxPlayers,
    );
  }
}
