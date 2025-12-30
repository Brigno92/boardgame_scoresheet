import 'package:boardgame_scoresheet/new_template_page.dart';
import 'package:boardgame_scoresheet/template_list.dart';
import 'package:flutter/material.dart';

class RouterWidget extends StatefulWidget {
  const RouterWidget(GlobalKey<NavigatorState> bodyNavigatorKey, {super.key})
    : _bodyNavigatorKey = bodyNavigatorKey;

  final GlobalKey<NavigatorState> _bodyNavigatorKey;

  @override
  RouterWidgetState createState() => RouterWidgetState();
}

class RouterWidgetState extends State<RouterWidget> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget._bodyNavigatorKey,
      initialRoute: '/template-list',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/template-list':
            builder = (BuildContext context) => const TemplateList();
            break;
          case '/new':
            builder = (BuildContext context) => const NewTemplatePage();
          default:
            builder = (BuildContext context) => const TemplateList();
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
