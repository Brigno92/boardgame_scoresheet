class ScoreRow {
  final int id;
  final int sheetId;
  final String name;
  final bool positiveScore;

  ScoreRow(this.name, this.positiveScore, this.id, this.sheetId);

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'sheetId': sheetId,
      'name': name,
      'positiveScore': positiveScore ? 1 : 0,
    };
  } 
}