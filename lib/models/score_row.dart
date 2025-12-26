class ScoreRow {
  late int id;
  late int sheetId;
  String name = '';
  bool positiveScore = true;
  Map<String, int> scores = {};
  int? numberOfPlayers;

  ScoreRow(List<String> playerNames) {
    numberOfPlayers = playerNames.length;
    for (var name in playerNames) {
      scores[name] = 0;
    }
  }
}