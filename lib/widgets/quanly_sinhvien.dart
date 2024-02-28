import 'package:flutter/material.dart';
import '../models/student.dart';
import './drawer_screen.dart';
import './settings/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';

class QuanLySinhVienScreen extends StatefulWidget {
  @override
  _QuanLySinhVienScreenState createState() => _QuanLySinhVienScreenState();
}

class _QuanLySinhVienScreenState extends State<QuanLySinhVienScreen> {
  List<Student> students = [];

  void initState() {
    super.initState();
    // Thêm sẵn hai sinh viên khi khởi tạo màn hình
    students.add(Student("Doan Hai My", "21001", 8.5));
    students.add(Student("Tran Thi Mai", "21003", 7.0));
    students.add(Student("Nguyen Van An", "21004", 6.34));
    students.add(Student("Tran Thu Thuy", "21008", 5.5));
    students.add(Student("Nguyen Anh Quang", "21006", 4.5));
  }

  @override
  Widget build(BuildContext context) {
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return ThemeConsumer(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Quản lý Sinh viên'),
        ),
        drawer: DrawerScreen(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  showStudentList();
                },
                icon: Icon(Icons.filter_list),
                label: Text("Lọc"),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          students[index].hoVaTen,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: settingsProvider.fontSize,
                          ),
                        ),
                        subtitle: Text(
                          'Mã Sinh Viên: ${students[index].maSV} | Điểm TB: ${students[index].diemTrungBinh}',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        leading: Icon(
                          Icons.person,
                          color: Colors.blue,
                        ),
                        onTap: () {
                          _showStudentDetailsDialog(students[index]);
                        },
                        // tileColor: Colors.lightBlueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: Color(0xffefeded),
                            width: 2.0,
                          ),
                        ),
                      ),

                      SizedBox(
                          height: 8.0), // Thêm khoảng cách giữa các sinh viên
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddStudentDialog();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> _showAddStudentDialog() async {
    TextEditingController maSVController = TextEditingController();
    TextEditingController hoVaTenController = TextEditingController();
    TextEditingController diemTBController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              "Thêm Sinh Viên",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              children: [
                TextField(
                  controller: maSVController,
                  decoration: InputDecoration(labelText: 'Mã Sinh viên'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: hoVaTenController,
                  decoration: InputDecoration(labelText: 'Tên Sinh viên'),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: diemTBController,
                  decoration: InputDecoration(labelText: 'Điểm Trung Bình'),
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
                        students.add(Student(
                          maSVController.text,
                          hoVaTenController.text,
                          double.parse(diemTBController.text),
                        ));
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
          ),
        );
      },
    );
  }

  Future<void> _showStudentDetailsDialog(Student student) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thông tin Sinh viên'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Mã: ${student.maSV}'),
              Text('Tên: ${student.hoVaTen}'),
              Text('Điểm Trung Bình: ${student.diemTrungBinh}'),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close),
                  label: Text('Đóng'),
                ),
                TextButton.icon(
                  onPressed: () {
                    _showEditStudentDialog(student);
                  },
                  icon: Icon(Icons.edit),
                  label: Text('Sửa'),
                ),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      students.remove(student);
                    });
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.delete),
                  label: Text('Xóa'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditStudentDialog(Student student) async {
    TextEditingController maSVController =
        TextEditingController(text: student.maSV);
    TextEditingController hoVaTenController =
        TextEditingController(text: student.hoVaTen);
    TextEditingController diemTBController =
        TextEditingController(text: student.diemTrungBinh.toString());

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sửa Sinh viên'),
          content: Column(
            children: [
              TextField(
                controller: maSVController,
                decoration: InputDecoration(labelText: 'Mã Sinh viên'),
              ),
              TextField(
                controller: hoVaTenController,
                decoration: InputDecoration(labelText: 'Tên Sinh viên'),
              ),
              TextField(
                controller: diemTBController,
                decoration: InputDecoration(labelText: 'Điểm Trung Bình'),
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
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
                      student.maSV = maSVController.text;
                      student.hoVaTen = hoVaTenController.text;
                      student.diemTrungBinh =
                          double.parse(diemTBController.text);
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

  Future<void> showStudentList() async {
    TextEditingController minController = TextEditingController();

    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Lọc"),
            content: Column(
              children: [
                TextField(
                  controller: minController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Điểm trung bình > n'),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Hủy'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _filterAndShowStudentList(
                      double.tryParse(minController.text));
                },
                child: Text('Lọc'),
              )
            ],
          );
        });
  }

  void _filterAndShowStudentList(double? minAverage) {
    List<Student> filteredStudents = students;

    if (minAverage != null) {
      filteredStudents = students
          .where((student) => student.diemTrungBinh > minAverage)
          .toList();
    }

    filteredStudents.sort((a, b) => b.diemTrungBinh.compareTo(a.diemTrungBinh));

    _showFilteredStudentListDialog(filteredStudents);
  }

  Future<void> _showFilteredStudentListDialog(
      List<Student> filteredStudents) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Danh sách Sinh viên'),
          content: Column(
            children: [
              if (filteredStudents.isEmpty)
                Text('Không có sinh viên thỏa điều kiện.'),
              for (var student in filteredStudents)
                ListTile(
                  title: Text(student.hoVaTen),
                  subtitle: Text(
                      '${student.maSV} | Điểm TB: ${student.diemTrungBinh}'),
                  onTap: () {
                    _showStudentDetailsDialog(student);
                  },
                ),
            ],
          ),
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
