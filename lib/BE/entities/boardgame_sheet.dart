import 'package:boardgame_scoresheet/BE/entities/score_row.dart';

class BoardgameSheet {
    final int id;
    final String name;
    final int maxPlayers;
    late List<ScoreRow> scoreRows = [];

  BoardgameSheet({required this.id, required this.name, required this.maxPlayers});
}