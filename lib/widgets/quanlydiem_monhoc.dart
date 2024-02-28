import 'package:flutter/material.dart';
import '../models/diem_monhoc.dart';
import 'package:intl/intl.dart';
import './settings/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';

class QuanLyDiemMonHocScreen extends StatefulWidget {
  @override
  State<QuanLyDiemMonHocScreen> createState() => _QuanLyDiemMonHocScreenState();
}

class _QuanLyDiemMonHocScreenState extends State<QuanLyDiemMonHocScreen> {
  List<DiemMonHoc> monHocs = [];

  void initState() {
    super.initState();
    // Thêm sẵn các điểm môn học khi khởi tạo màn hình
    monHocs.add(DiemMonHoc("Cơ Sở Dữ Liệu", 8.5, DateTime.now()));
    monHocs.add(DiemMonHoc("Giải Tích", 7.0, DateTime.now()));
    monHocs.add(DiemMonHoc("Mobile", 6.34, DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return ThemeConsumer(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Quản lý Môn học'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: monHocs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        monHocs[index].tenMonHoc,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: settingsProvider.fontSize,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Điểm: ${monHocs[index].diemMonHoc}',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                          Text(
                            'Ngày Nhập Điểm: ${DateFormat('dd/MM/yyyy').format(monHocs[index].ngayNhap.toLocal())}',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              // Xử lý sự kiện khi nhấn vào icon delete
                              _showDeleteMonHocDialog(monHocs[index]);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Xử lý sự kiện khi nhấn vào icon edit
                              _showEditMonHoc(monHocs[index]);
                            },
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  _showTinhDiemTrungBinh();
                },
                child: Icon(Icons.calculate),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(16.0),
                ),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddMonHoc();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> _showAddMonHoc() async {
    TextEditingController tenMonHocController = TextEditingController();
    TextEditingController diemController = TextEditingController();
    DateTime currentDate = DateTime.now();

    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Thêm Môn Học'),
            content: Column(
              children: [
                TextField(
                  controller: tenMonHocController,
                  decoration: InputDecoration(labelText: 'Tên Môn Học'),
                ),
                TextField(
                  controller: diemController,
                  decoration: InputDecoration(labelText: 'Điểm'),
                ),
                SizedBox(width: 16),
                Text(
                    'Ngày Nhập Điểm: ${DateFormat('dd/MM/yyyy').format(currentDate.toLocal())}'),
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xffd6d4d4),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.close),
                        SizedBox(width: 8),
                        Text(
                          "Hủy",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        monHocs.add(
                          DiemMonHoc(
                            tenMonHocController.text,
                            double.parse(diemController.text),
                            currentDate,
                          ),
                        );
                      });
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.save),
                        SizedBox(width: 8),
                        Text(
                          "Lưu",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }

  Future<void> _showDeleteMonHocDialog(DiemMonHoc monHoc) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Xóa'),
          content: Text('Bạn có chắc muốn xóa sinh viên ${monHoc.tenMonHoc}?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  monHocs.remove(monHoc);
                });
                Navigator.of(context).pop();
              },
              child: Text('Xóa'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditMonHoc(DiemMonHoc monHoc) async {
    TextEditingController tenMonHocController =
        TextEditingController(text: monHoc.tenMonHoc);
    TextEditingController diemController =
        TextEditingController(text: monHoc.diemMonHoc.toString());
    DateTime currentDate = monHoc.ngayNhap;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sửa Môn Học'),
          content: Column(
            children: [
              TextField(
                controller: tenMonHocController,
                decoration: InputDecoration(labelText: 'Tên Môn Học'),
              ),
              Text('Ngày Nhập Điểm: ${currentDate.toLocal()}'),
              TextField(
                controller: diemController,
                decoration: InputDecoration(labelText: 'Điểm'),
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xffd6d4d4),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.close),
                      SizedBox(width: 8),
                      Text(
                        "Hủy",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      monHocs.add(
                        DiemMonHoc(
                          tenMonHocController.text,
                          double.parse(diemController.text),
                          currentDate,
                        ),
                      );
                    });
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.save),
                      SizedBox(width: 8),
                      Text(
                        "Lưu",
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _showTinhDiemTrungBinh() async {
    double diemTrungBinh = monHocs.isEmpty
        ? 0.0
        : monHocs.map((monHoc) => monHoc.diemMonHoc).reduce((a, b) => a + b) /
            monHocs.length;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Điểm Trung Bình'),
          content: Text('Điểm Trung Bình: $diemTrungBinh'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Đóng'),
            ),
          ],
        );
      },
    );
  }
}
