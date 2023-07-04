import 'package:lista_asistencia_actualizado/index/index.view.dart';

class StudentInfoWidget extends StatefulWidget {
  final StudentModel student;
  final Function(int) onSelectionChanged;
  final int selectedOption;

  const StudentInfoWidget({
    required this.student,
    required this.onSelectionChanged,
    required this.selectedOption,
    super.key,
  });

  @override
  State<StudentInfoWidget> createState() => _StudentInfoWidgetState();
}

class _StudentInfoWidgetState extends State<StudentInfoWidget> {
  int _selectedOption = 0;

  Future<void> _loadSelectedOption() async {
    setState(() {
      _selectedOption = widget.selectedOption;
    });
  }

  void _saveSelectedOption(int value) async {
    setState(() {
      _selectedOption = value;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final double tamanoIcono = 24.sp;
    final List<String> nombres = widget.student.nombre.split(' ');
    final List<String> apelldos = widget.student.apellido.split(' ');
    String primerNombre = nombres[0];
    String primerApellido = apelldos[0];
    _loadSelectedOption();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0XFFF4F4F4),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, offset: Offset(0.0, 3.0), blurRadius: 1),
          ]),
      child: ListTile(
        key: Key(widget.student.matricula),
        leading: const CircleAvatar(
          radius: 20,
          backgroundColor: Color(0xffF69100),
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: 24,
          ),
        ),
        title: Text(
          '$primerApellido $primerNombre',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
          maxLines: 2,
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(right: 15.0),
              child: CustomRadio(
                icon: Icon(
                  Icons.check_circle_rounded,
                  size: tamanoIcono,
                  color: Colors.green,
                ),
                icon2: Icon(Icons.check_circle_outline, size: tamanoIcono),
                selected: widget.selectedOption == 1,
                groupValue: widget.selectedOption,
                value: 1,
                onChanged: (value) {
                  _saveSelectedOption(value!);
                  widget.onSelectionChanged(_selectedOption);
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: CustomRadio(
                icon: Icon(Icons.access_time_filled,
                    size: tamanoIcono, color: Colors.yellow),
                icon2: Icon(Icons.access_time_rounded, size: tamanoIcono),
                selected: widget.selectedOption == 2,
                value: 2,
                groupValue: widget.selectedOption,
                onChanged: (value) {
                  _saveSelectedOption(value!);
                  widget.onSelectionChanged(_selectedOption);
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15.0),
              child: CustomRadio(
                icon: Icon(
                  Icons.cancel,
                  size: tamanoIcono,
                  color: Colors.red,
                ),
                icon2: Icon(Icons.cancel_outlined, size: tamanoIcono),
                selected: widget.selectedOption == 3,
                groupValue: widget.selectedOption,
                value: 3,
                onChanged: (value) {
                  _saveSelectedOption(value!);
                  widget.onSelectionChanged(_selectedOption);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
