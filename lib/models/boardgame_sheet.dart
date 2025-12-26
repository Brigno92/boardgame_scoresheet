import 'package:boardgame_scoresheet/models/score_row.dart';

class BoardgameSheet {
    late int id;
    late String name;
    late int maxPlayers;
    List<ScoreRow> scoreRows = [];
}