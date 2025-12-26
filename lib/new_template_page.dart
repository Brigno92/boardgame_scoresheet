import 'package:flutter/material.dart';

class NewTemplatePage extends StatefulWidget {
  const NewTemplatePage({Key? key}) : super(key: key);

  @override
  State<NewTemplatePage> createState() => _NewTemplatePageState();
}

class _NewTemplatePageState extends State<NewTemplatePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text('New Template Page'),
      ],
    );
  }
}