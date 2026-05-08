import 'package:boardgame_scoresheet/Services/navigation_service.dart';
import 'package:boardgame_scoresheet/Template/template_page.dart';
import 'package:boardgame_scoresheet/Template/template_list.dart';
import 'package:flutter/material.dart';

class RouterWidget extends StatefulWidget {
  const RouterWidget({super.key});

  @override
  RouterWidgetState createState() => RouterWidgetState();
}

class RouterWidgetState extends State<RouterWidget> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: NavigationService.instance.navigatorKey,
      initialRoute: '/template-list',
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/template-list':
            builder = (BuildContext context) => TemplateList();
            break;
          case '/new':
            builder = (BuildContext context) => const TemplatePage();
            break;
          case '/template-details':
            final id = settings.arguments as int?;
            builder = (BuildContext context) => TemplatePage(templateId: id);
            break;
          default:
            builder = (BuildContext context) => TemplateList();
            break;
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
