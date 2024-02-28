import 'package:flutter/material.dart';
import './widgets/quanly_sinhvien.dart';
import './widgets/settings/setting_page.dart';
import './widgets/settings/settings_provider.dart';
import './widgets/dangki_dangnhap.dart';

import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => SettingsProvider(),
      child: ThemeProvider(
        saveThemesOnChange: true,
        loadThemeOnInit: true,
        themes: [
          AppTheme.light(),
          AppTheme.dark(),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quản lý Sinh viên',
      // home: QuanLySinhVienScreen(),
      //
      //
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      routes: {
        '/settings': (context) => SettingsPage(),
      },
    );
  }
}
