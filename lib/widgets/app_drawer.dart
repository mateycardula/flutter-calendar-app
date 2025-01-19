import 'package:flutter/material.dart';
import '../services/navigation_service.dart';

class AppDrawer extends StatelessWidget {
  final NavigationService navigationService;

  AppDrawer({required this.navigationService});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Navigation Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              navigationService.replaceWith('/home'); // Navigate to Home
            },
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Map'),
            onTap: () {
              navigationService.replaceWith('/map'); // Navigate to Locations
            },
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Locations'),
            onTap: () {
              navigationService.replaceWith('/locations'); // Navigate to Locations
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              navigationService.replaceWith('/settings'); // Navigate to Settings
            },
          ),
        ],
      ),
    );
  }
}
