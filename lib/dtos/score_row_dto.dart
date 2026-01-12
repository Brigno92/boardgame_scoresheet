class ScoreRowDto {
  late int sheetId;
  late String name;
  late bool positiveScore;

  toMap() {
    return {
      'sheetId': sheetId,
      'name': name,
      'positiveScore': positiveScore ? 1 : 0,
    };
  }
}