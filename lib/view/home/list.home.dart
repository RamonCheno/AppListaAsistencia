import 'package:flutter/material.dart';
import 'package:lista_asistencia_actualizado/view/screen/attendance/list.attendance.screen.dart';
import 'package:lista_asistencia_actualizado/view/screen/students/list.students.screen.dart';
import 'package:lista_asistencia_actualizado/view/widgets/page_view_widget.dart';

class ListsHome extends StatefulWidget {
  const ListsHome({super.key});
  static const String route = '/list_home';

  @override
  State<ListsHome> createState() => _ListsHomeState();
}

class _ListsHomeState extends State<ListsHome> {
  int selectedIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  final List<Widget> _pages = const [
    ListAttendanceScreen(),
    ListStudentScreen(),
  ];

  final List<BottomNavigationBarItem> _bottomNavigatorBarItem = const [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.assignment_rounded,
        color: Color(0xffF69100),
      ),
      label: 'Asistencia',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.group_rounded,
        color: Color(0xffF69100),
      ),
      label: 'Estudiantes',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageViewWidget(
            pages: _pages, bottomNavigatorBarItem: _bottomNavigatorBarItem));
  }
}
