import 'package:boardgame_scoresheet/entities/score_row.dart';
import 'package:flutter/material.dart';

class NewTemplatePage extends StatefulWidget {
  const NewTemplatePage({Key? key}) : super(key: key);

  @override
  State<NewTemplatePage> createState() => _NewTemplatePageState();
}

class _NewTemplatePageState extends State<NewTemplatePage> {
  List<ScoreRow> scoreRows = [ScoreRow('', true, 0, 0)];
  String gameTitle = '';

  void addScoreRow() {
    setState(() {
      scoreRows.add(ScoreRow('', true, 0, 0));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        child: Column(
          children: [
            Expanded(child: TextFormField(
              decoration: InputDecoration(labelText: 'Game Name'),
              onChanged: (value) {
                              setState(() {
                                gameTitle = value;
                              });
                            },
            )),
            Expanded(
              child: ListView(
                children: [
                  ...scoreRows.map(
                    (row) => Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            initialValue: row.name,
                            decoration: InputDecoration(labelText: 'Score ${scoreRows.indexOf(row) + 1} name'),
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

            ElevatedButton(
              onPressed: addScoreRow,
              child: Text('Add Score Row'),
            ),
          ],
        ),
      ),
    );
  }
}
