import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';
import './settings_provider.dart';
import '../drawer_screen.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    var themeProvider = ThemeProvider.themeOf(context).data;
    return ThemeConsumer(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cài đặt'),
        ),
        drawer: DrawerScreen(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Kích thước font chữ: ${settingsProvider.fontSize.toInt()}',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 8.0),
              Slider(
                value: settingsProvider.fontSize,
                min: 10.0,
                max: 30.0,
                onChanged: (value) {
                  settingsProvider.fontSize = value;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  ThemeProvider.controllerOf(context).nextTheme();
                },
                child: Text('Chuyển chủ đề'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
