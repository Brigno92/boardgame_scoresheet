import 'package:flutter/material.dart';

class TemplateList extends StatelessWidget {
  const TemplateList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.gamepad),
            title: Text('Template 1'),
          ),
          ListTile(
            leading: Icon(Icons.gamepad),
            title: Text('Template 2'),
          ),
        ],
      ),
    );
  }
}