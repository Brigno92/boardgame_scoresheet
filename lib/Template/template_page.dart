import 'package:boardgame_scoresheet/BE/controllers/scoresheet_repository.dart';
import 'package:boardgame_scoresheet/BE/dtos/score_row_dto.dart';
import 'package:boardgame_scoresheet/BE/dtos/scoresheet_dto.dart';
import 'package:boardgame_scoresheet/BE/entities/boardgame_sheet.dart';
import 'package:flutter/material.dart';

class TemplatePage extends StatefulWidget {
  const TemplatePage({super.key, templateId}) : _templateId = templateId;
  final int? _templateId;

  @override
  State<TemplatePage> createState() => TemplatePageState();
}

class TemplatePageState extends State<TemplatePage> {
  BoardgameSheet? template;
  List<ScoreRowDto> scoreRows = [ScoreRowDto('', true)];
  final ScoresheetRepository _repository = ScoresheetRepository();
  final TextEditingController _gameTitleController = TextEditingController();
  
  String gameTitle = '';

  void addScoreRow() {
    setState(() {
      scoreRows.add(ScoreRowDto('', true));
    });
  }

  Future<void> loadTemplate() async {
    final loadedTemplate = await _repository.getSheetById(widget._templateId!);
    setState(() {
      template = loadedTemplate;
      _gameTitleController.text = template?.name ?? 'Game Name';
      scoreRows =
          template?.scoreRows
              .map((row) => ScoreRowDto(row.name, row.positiveScore))
              .toList() ??
          [ScoreRowDto('', true)];
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget._templateId != null) loadTemplate();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Game Name',
                ),
                controller: _gameTitleController,
                onChanged: (value) {
                  setState(() {
                    gameTitle = value;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Score Name',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Positive?',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Expanded(
              flex: 4,
              child: ListView(
                children: [
                  ...scoreRows.map(
                    (row) => Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: row.name,
                            onChanged: (value) {
                              setState(() {
                                row.name = value;
                              });
                            },
                          ),
                        ),
                        Checkbox(
                          value: row.positiveScore,
                          onChanged: (value) {
                            setState(() {
                              row.positiveScore = value ?? true;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final id = await saveTemplate();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Template saved with id: $id')),
                    );
                  },
                  child: Text('Save Template'),
                ),
                ElevatedButton(
                  onPressed: addScoreRow,
                  child: Text('Add Score Row'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<int> saveTemplate() async {
    final dto = ScoresheetDto(gameTitle, 4, scoreRows);
    return widget._templateId == null
        ? await _repository.createSheet(dto)
        : await _repository.updateSheet(widget._templateId!, dto);
  }
}
