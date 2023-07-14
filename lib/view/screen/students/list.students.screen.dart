import 'package:lista_asistencia_actualizado/index/index.view.dart';

class ListStudentScreen extends StatefulWidget {
  const ListStudentScreen({super.key});
  static const String route = '/listStudent';

  @override
  State<ListStudentScreen> createState() => _ListStudentScreenState();
}

class _ListStudentScreenState extends State<ListStudentScreen> {
  List<StudentModel> _listStudent = [];

  Map<String, dynamic> _args = {};

  StudentController? studentController;

  int _selectedIndex = -1;

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

  Future<void> _updateListStudent(dynamic data) async {
    _listStudent = data;
    debugPrint('${_listStudent.toList()}');
  }

  Future<List<StudentModel>> _getStudents() async {
    int idGroup = _args["id"] ?? 1;
    debugPrint("ID Grupo: $idGroup");
    List<StudentModel> studentMList =
        await studentController!.getStudentsByGroup(idGroup);
    return studentMList;
  }

  Future<void> registrarAlumno() async {
    await Navigator.pushNamed(context, AddStudentScreen.route).then((value) {
      _getStudents().then((student) {
        setState(() {
          _listStudent = student;
        });
      });
    });
  }

  Future<void> eliminarAlumno(String matricula, int index) async {
    setState(() {
      if (_listStudent.isNotEmpty) {
        _listStudent.removeAt(index);
      }
    });
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
    _listStudent.clear();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    _args = args;
    _getStudents().then((student) {
      setState(() {
        _listStudent = student;
      });
    });
    super.didChangeDependencies();
  }

  Future<void> _dialogConfirmarEliminarAlumno(BuildContext context) async {
    final List<String> nombres = _listStudent[_selectedIndex].nombre.split(' ');
    final List<String> apellidos =
        _listStudent[_selectedIndex].apellido.split(' ');
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar estudiante'),
          content: Text(
              '¿Seguro de eliminar al estudiante "${apellidos[0]} ${nombres[0]}" de la lista?'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.red,
                      title: const Text(
                        '¿ESTAS SEGURO?',
                        style: TextStyle(color: Colors.white),
                      ),
                      content: Text(
                        '¿Realmente deseas eliminar de la lista al estudiante "${apellidos[0]} ${nombres[0]}"?',
                        style: const TextStyle(color: Colors.white),
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Aceptar',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () async {
                            Navigator.of(context).pop();
                            await eliminarAlumno(
                                _listStudent[_selectedIndex].matricula,
                                _selectedIndex);
                          },
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancelar',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Aceptar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
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
              if (snapshot.data != null) {
                _updateListStudent(snapshot.data);
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
                                      setState(() {
                                        _selectedIndex = index;
                                      });
                                      _dialogConfirmarEliminarAlumno(context);
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
          onPressed: registrarAlumno,
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
