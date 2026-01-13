import 'package:boardgame_scoresheet/controllers/scoresheet_repository.dart';
import 'package:boardgame_scoresheet/entities/boardgame_sheet.dart';
import 'package:flutter/material.dart';

class TemplateList extends StatefulWidget{
  const TemplateList({super.key});
  
  @override
  State<TemplateList> createState() => _TemplateListState();
}

class _TemplateListState extends State<TemplateList> {
  final ScoresheetRepository _repository = ScoresheetRepository();

  late List<BoardgameSheet> _sheets;

  @override
  void initState() {
    super.initState();
    loadTemplates();
  }

  Future<void> loadTemplates() async {
    final loadedTemplates = await _repository.getSheets();
    setState(() {
      _sheets = loadedTemplates;
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: _sheets.map((sheet) {
          return ListTile(
            title: Text(sheet.name),
            subtitle: Text('Max Players: ${sheet.maxPlayers}'),
          );
        }).toList(),
      ),
    );
  }
}