import 'package:flutter/material.dart';
import './quanly_monhoc.dart';
import './quanly_sinhvien.dart';
import 'package:theme_provider/theme_provider.dart';
import './dangki_dangnhap.dart';
import './gioithieu.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeConsumer(
      child: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Ứng Dụng Quản lý',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Quản lý Sinh Viên'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuanLySinhVienScreen(),
                    ));
              },
            ),
            ListTile(
              title: Text('Góc Học Tập'),
              onTap: () {
                // Chuyển đến màn hình quản lý môn học
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuanLyMonHocScreen(),
                    ));
              },
            ),
            ListTile(
              title: Text('Cài Đặt'),
              onTap: () {
                // Chuyển đến trang cài đặt
                Navigator.pop(context); // Đóng Drawer
                Navigator.pushNamed(
                    context, '/settings'); // Sử dụng route của trang cài đặt
              },
            ),
            ListTile(
              title: Text('Giới Thiệu'),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GioiThieuScreen(),
                    )); // Đóng Drawer
              },
            ),
            ListTile(
              title: Text('Đăng Xuất'),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    )); // Đóng Drawer
              },
            ),
          ],
        ),
      ),
    );
  }
}
