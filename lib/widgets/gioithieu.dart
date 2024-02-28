import 'package:flutter/material.dart';
import './drawer_screen.dart';

class GioiThieuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giới Thiệu'),
      ),
      drawer: DrawerScreen(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60.0,
              child: Icon(
                Icons.account_circle, // Sử dụng biểu tượng account_circle
                size: 120.0, // Thiết lập kích thước biểu tượng
                color: Colors.blue, // Thiết lập màu sắc biểu tượng
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Admin', // Tên admin
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Xin chào! Đây là trang giới thiệu về ứng dụng. Hãy đọc nội dung giới thiệu để biết thêm thông tin chi tiết.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
