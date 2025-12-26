import 'package:boardgame_scoresheet/main_page/menu_drawer.dart';
import 'package:boardgame_scoresheet/main_page/router_widget.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  @override
  MainMenuState createState() => MainMenuState();
}

class MainMenuState extends State {

  final GlobalKey<NavigatorState> bodyNavigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Table Organizer')),
      drawer: DrawerMenu(
      onRouteSelected: (routeName) {
        Navigator.pop(context); // Chiudi il drawer
        bodyNavigatorKey.currentState?.pushNamed(routeName);
      },
    ),
      backgroundColor: const Color.fromARGB(255, 217, 243, 255),
      body: RouterWidget(bodyNavigatorKey),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewNight(),
      ),
    );
  }

  createNewNight() {}
}