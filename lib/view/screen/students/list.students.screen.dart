import 'package:lista_asistencia_actualizado/index/index.view.dart';

class ListStudentScreen extends StatefulWidget {
  const ListStudentScreen({super.key});
  static const String route = '/listStudent';

  @override
  State<ListStudentScreen> createState() => _ListStudentScreenState();
}

class _ListStudentScreenState extends State<ListStudentScreen> {
  List<StudentModel> _listStudent = [];

  StudentController? studentController;

  final int _selectedIndex = -1;

  ScrollController? _scrollController;
  bool _isVisible = true;

  void _scrollListener() {
    if (_scrollController!.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_isVisible) {
        setState(() {
          _isVisible = false;
        });
      }
    }
    if (_scrollController!.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (_isVisible) {
        setState(() {
          _isVisible = true;
        });
      }
    }
  }

  Future<List<StudentModel>> _getStudents() async {
    List<StudentModel> studentMList = await studentController!.getStudent();
    return studentMList;
  }

  @override
  void initState() {
    super.initState();
    studentController = StudentController();
    _scrollController = ScrollController();
    _scrollController!.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController!.removeListener(_scrollListener);
    _scrollController!.dispose();
    super.dispose();
  }

  Future<void> registrarAlumno() async {
    await Navigator.pushNamed(context, AddStudentScreen.route,
        arguments: {'id': "", 'nombre': ""}).then((value) {
      _getStudents().then((student) {
        setState(() {
          _listStudent = student;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double baseFontSize = 16.sp;
    final double tamanoIcono = 22.sp;
    final double tamanoTexto = baseFontSize;
    return CustomScaffoldWidget(
      title: 'Alumnos',
      cuerpo: Column(children: [
        Expanded(
          child: FutureBuilder(
            future: _getStudents(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.none &&
                  !snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(0xffF69100)),
                );
              }
              return _listStudent.isEmpty
                  ? Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text(
                          'Presione el "botón +" para agregar un alumno a la lista',
                          style:
                              TextStyle(fontSize: 20, color: Colors.black45)),
                    )
                  : ListView.separated(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final StudentModel student = _listStudent[index];
                        final List<String> nombres = student.nombre.split(' ');
                        final List<String> apelldos =
                            student.apellido.split(' ');
                        String primerNombre = nombres[0];
                        String primerApellido = apelldos[0];
                        return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0XFFF4F4F4),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0.0, 3.0),
                                      blurRadius: 1),
                                ]),
                            child: ListTile(
                              key: Key(student.matricula),
                              leading: CustomPopMenuButton(
                                items: [
                                  {
                                    'icono': const Icon(
                                        Icons.delete_forever_rounded),
                                    'value': 'eliminarAlumno',
                                    'text': 'Eliminar Alumno',
                                    'onTap': () async {
                                      await Future.delayed(Duration.zero);
                                      if (!mounted) return;
                                    }
                                  },
                                ],
                                iconMenu: Icons.more_vert,
                                colorIcon: Colors.black,
                              ),
                              title: Row(
                                children: [
                                  CircleAvatar(
                                      radius: 20.sp,
                                      backgroundColor: const Color(0xffF69100),
                                      child: Icon(Icons.person,
                                          color: Colors.white,
                                          size: tamanoIcono)),
                                  const SizedBox(width: 15),
                                  Text(
                                    '$primerNombre $primerApellido',
                                    style: TextStyle(fontSize: tamanoTexto),
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                              trailing: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.black),
                              onTap: () {},
                            ));
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                            height: 10,
                          ),
                      itemCount: _listStudent.length);
            },
          ),
        )
      ]),
      floatingActionButton: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: _isVisible ? 1.0 : 0.0,
        child: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: null,
          backgroundColor: const Color(0xffFF9800),
          child: Icon(
            Icons.add,
            color: _isVisible ? Colors.white : Colors.transparent,
            size: tamanoIcono,
          ),
        ),
      ),
    );
  }
}
