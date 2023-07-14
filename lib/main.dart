import 'package:lista_asistencia_actualizado/api/peticiones_http.dart';
import 'package:lista_asistencia_actualizado/index/index.view.dart';

void main() async {
  PeticionesHttp.configureDio();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = {
      ListStudentScreen.route: (_) => const ListStudentScreen(),
      AddStudentScreen.route: (_) => const AddStudentScreen(),
      ListAttendanceScreen.route: (_) => const ListAttendanceScreen(),
      ListsHome.route: (_) => const ListsHome(),
      ListGroupScreen.route: (_) => const ListGroupScreen(),
    };

    return ResponsiveSizer(
      builder: (_, orientation, screenType) {
        return MaterialApp(
          routes: router,
          initialRoute: ListGroupScreen.route,
          title: 'Lista Asistencia',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            appBarTheme: AppBarTheme(
              backgroundColor: const Color(0xff4CAF50),
              centerTitle: true,
              elevation: 0,
              titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp),
              iconTheme: const IconThemeData(color: Colors.white),
              actionsIconTheme: const IconThemeData(color: Colors.white),
              toolbarHeight: 10.68.h,
            ),
          ),
        );
      },
    );
  }
}
