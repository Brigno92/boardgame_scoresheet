class ScoreRowDto {
  late int sheetId;
  late String name;
  late bool positiveScore;

  ScoreRowDto(this.name, this.positiveScore);

  toMap() {
    return {
      'sheetId': sheetId,
      'name': name,
      'positiveScore': positiveScore ? 1 : 0,
    };
  }
}