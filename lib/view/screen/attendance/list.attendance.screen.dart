import 'package:lista_asistencia_actualizado/index/index.view.dart';

import 'package:intl/intl.dart';

class ListAttendanceScreen extends StatefulWidget {
  const ListAttendanceScreen({super.key});
  static const String route = '/listAttendance';

  @override
  State<ListAttendanceScreen> createState() => _ListAttendanceScreenState();
}

class _ListAttendanceScreenState extends State<ListAttendanceScreen> {
  List<String> estadoLista = [
    'Asistencia',
    'Retardo',
    'Falta',
    'Falta justificada'
  ];
  List<int> _selectedOption = [];

  List<AttendanceModel> _listaAsistencia = [
    AttendanceModel(
        alumnoFk: '19-05-0022', fecha: '03/07/2023', presente: 'Asistencia'),
    AttendanceModel(
        alumnoFk: '19-05-0023', fecha: '03/07/2023', presente: 'Falta'),
    AttendanceModel(
        alumnoFk: '19-05-0024', fecha: '03/07/2023', presente: 'Retardo')
  ];

  List<StudentModel> _listStudent = [
    StudentModel('19-05-0022', 'Ramon Francisco', 'Cheno Ocano', 'Hombre'),
    StudentModel('19-05-0023', 'Jorge Humberto', 'Cheno Ocano', 'Hombre'),
    StudentModel('19-05-0024', 'Angel Armando', 'Cheno Ocano', 'Hombre')
  ];

  String fechaActualS = '';

  DateFormat formatoFecha = DateFormat('yyyy/MM/dd');
  String estado = '';
  late ScrollController _scrollController;
  bool _isVisible = true;

  final Map<int, String> selectedStateMap = {};

  int asistioNum = 0;
  int faltasNum = 0;
  int retardoNum = 0;
  int faltasJNum = 0;

  void cleanContadores() {
    setState(() {
      asistioNum = 0;
      faltasNum = 0;
      retardoNum = 0;
      faltasJNum = 0;
    });
  }

  Future<DateTime?> _selectedInitialDay(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    return picked;
  }

  Future<void> actualizarListaStudent(dynamic data) async {
    final List<int> oldSelectedOption = _selectedOption;
    _listStudent = data;
    _selectedOption = List<int>.filled(_listStudent.length, 0);
    for (int i = 0; i < oldSelectedOption.length; i++) {
      if (i < _selectedOption.length) {
        _selectedOption[i] = oldSelectedOption[i];
      }
    }
  }

  Future<List<AttendanceModel>> _getAsistencia() async {
    List<AttendanceModel> attendanceList = _listaAsistencia;
    return attendanceList;
  }

  Future<List<StudentModel>> _getStudents() async {
    List<StudentModel> studentMList = _listStudent;
    return studentMList;
  }

  Future<void> _actualizarListaAsistencia() async {
    await _getAsistencia().then(
      (attendance) {
        setState(() {
          cleanContadores();
          _listaAsistencia = attendance;
          for (int i = 0; i < _listStudent.length; i++) {
            if (_listaAsistencia.any(
                (element) => element.alumnoFk == _listStudent[i].matricula)) {
              selectedStateMap[i] = _listaAsistencia
                  .firstWhere((element) =>
                      element.alumnoFk == _listStudent[i].matricula)
                  .presente;
            }
            debugPrint(fechaActualS);
            switch (selectedStateMap[i]) {
              case 'Asistencia':
                _selectedOption[i] = 1;
                asistioNum++;
                break;
              case 'Retardo':
                _selectedOption[i] = 2;
                retardoNum++;
                break;
              case 'Falta':
                _selectedOption[i] = 3;
                faltasNum++;
                break;
              case 'Falta justificada':
                _selectedOption[i] = 4;
                faltasNum++;
                faltasJNum++;
                break;
            }
            debugPrint('${_selectedOption[i]}: ${selectedStateMap[i]}');
          }
        });
      },
    );
  }

  Future<void> cambiarValor(int value, int index) async {
    setState(() {
      switch (value) {
        case 1:
          asistioNum++;
          break;
        case 2:
          retardoNum++;
          break;
        case 3:
          faltasNum++;
          break;
        case 4:
          faltasNum++;
          faltasJNum++;
          break;
      }

      switch (_selectedOption[index]) {
        case 1:
          if (_selectedOption[index] > 0 && asistioNum > 0) {
            asistioNum--;
          }
          break;
        case 2:
          if (_selectedOption[index] > 0 && retardoNum > 0) {
            retardoNum--;
          }
          break;
        case 3:
          if (_selectedOption[index] > 0 && faltasNum > 0) {
            faltasNum--;
          }
          break;
        case 4:
          if (_selectedOption[index] > 0 && (faltasNum > 0 && faltasJNum > 0)) {
            faltasNum--;
            faltasJNum--;
          }
          break;
      }
      _selectedOption[index] = value;
      estado = estadoLista[value - 1];
      selectedStateMap[index] = estado;
    });
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_isVisible) {
        setState(() {
          _isVisible = false;
        });
      }
    }
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_isVisible) {
        setState(() {
          _isVisible = true;
        });
      }
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    fechaActualS = formatoFecha.format(DateTime.now());
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseFontSize = 20.sp;
    final double screenWidth = 100.w;
    final double tamanoIcono = 20.sp;
    final double tamanoTexto = baseFontSize;
    return CustomScaffoldWidget(
      title: "Grupo 8-1",
      cuerpo: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0XFFF4F4F4),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 4.0),
                    blurRadius: 5.0),
              ],
            ),
            width: screenWidth,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
                vertical: 1.h,
              ),
              child: Row(
                children: <Widget>[
                  Image.asset(
                      'assets/images/unsierra_logo_icono.png', //imagen por defecto, agregar imagen depende de la imagen agregada por el usuario
                      height: 8.h,
                      fit: BoxFit.cover),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(fechaActualS,
                                style: TextStyle(fontSize: tamanoTexto)),
                            IconButton(
                              icon: Icon(
                                Icons.date_range,
                                color: const Color(0xffF69100),
                                size: tamanoIcono,
                              ),
                              onPressed: () async {
                                DateTime? selectedDate =
                                    await _selectedInitialDay(context);
                                if (selectedDate != null) {
                                  setState(() {
                                    fechaActualS =
                                        formatoFecha.format(selectedDate);
                                  });
                                  await _actualizarListaAsistencia();
                                }
                              },
                            )
                          ],
                        ), //Texto e iconos del dia de la asistencia
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.groups_2,
                                color: const Color(0xff757575),
                                size: tamanoIcono),
                            Text(
                              '${_listStudent.length}',
                              style: TextStyle(fontSize: (tamanoTexto)),
                            ),
                            const SizedBox(width: 10),
                            Icon(Icons.check_circle_rounded,
                                color: Colors.green, size: tamanoIcono),
                            Text('$asistioNum',
                                style: TextStyle(fontSize: tamanoTexto)),
                            const SizedBox(width: 10),
                            Icon(Icons.access_time_filled,
                                color: Colors.yellow, size: tamanoIcono),
                            Text('$retardoNum',
                                style: TextStyle(fontSize: tamanoTexto)),
                            const SizedBox(width: 10),
                            Icon(Icons.close_rounded,
                                color: Colors.red, size: tamanoIcono),
                            Text('$faltasNum',
                                style: TextStyle(fontSize: tamanoTexto)),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: FutureBuilder(
              future: _getStudents(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.none &&
                    !snapshot.hasData) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Color(0xffF69100),
                  ));
                }
                if (snapshot.data != null) {
                  actualizarListaStudent(snapshot.data);
                }
                return _listStudent.isEmpty
                    ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Deslice a la pagina "Estudiantes" para agregar estudiantes en la lista de asistencia -->',
                          style: TextStyle(
                            fontSize: tamanoTexto,
                            color: Colors.black45,
                          ),
                        ),
                      )
                    : ListView.separated(
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemCount: _listStudent.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 10);
                        },
                        itemBuilder: (context, index) {
                          final student = _listStudent[index];
                          int selectedOption = 0;
                          if (_selectedOption.isNotEmpty &&
                              index < _selectedOption.length) {
                            selectedOption = _selectedOption[index];
                          }
                          return StudentInfoWidget(
                            selectedOption: selectedOption,
                            student: student,
                            onSelectionChanged: (value) {
                              cambiarValor(value, index);
                            },
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: _isVisible ? 1.0 : 0.0,
        child: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: null,
          backgroundColor: const Color(0xffFF9800),
          child: Icon(
            Icons.save_outlined,
            color: _isVisible ? Colors.white : Colors.transparent,
            size: tamanoIcono,
          ),
        ),
      ),
    );
  }
}
