import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key, required this.onRouteSelected});
  final void Function(String routeName) onRouteSelected;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue,
      child: ListView(
        children: [
          const DrawerHeader(child: Text('Menù')),
          ListTile(
                leading: const Icon(Icons.apps),
                title: const Text('I miei giochi'),
                onTap: () => onRouteSelected('/template-list'),
              ),
              ListTile(
                leading: const Icon(Icons.add_box_rounded),
                title: const Text('Crea template'),
                onTap: () => onRouteSelected('/new'),
              )
        ],
      ),
      
    );
  }
}