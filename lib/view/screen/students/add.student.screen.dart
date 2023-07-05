import 'package:flutter/material.dart';
import 'package:lista_asistencia_actualizado/view/widgets/custom_scaffold.widget.dart';
import 'package:lista_asistencia_actualizado/view/widgets/textformfield.widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  static const String route = '/addStudent';

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _conMatricula;
  late TextEditingController _conNombre;
  late TextEditingController _conApellido;
  // late StudentController studentC;
  SelectedGender? _conGenero = SelectedGender.hombre;

  void registrarAlumno() async {}

  @override
  void dispose() {
    super.dispose();
    _conMatricula.dispose();
    _conNombre.dispose();
    _conApellido.dispose();
  }

  @override
  void initState() {
    super.initState();
    _conMatricula = TextEditingController();
    _conNombre = TextEditingController();
    _conApellido = TextEditingController();
    // studentC = StudentController();
  }

  @override
  Widget build(BuildContext context) {
    final double baseFontSize = 18.sp;
    final double tamanoTexto = baseFontSize;
    return CustomScaffoldWidget(
      title: "Agregar Alumno",
      cuerpo: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10),
                Text(
                  "Matricula",
                  style: TextStyle(
                    fontSize: tamanoTexto,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextFormFieldWidget(
                  action: TextInputAction.next,
                  controller: _conMatricula,
                  hintName: 'Matricula',
                  icon: Icons.numbers_rounded,
                  inputType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                Text(
                  'Apellidos',
                  style: TextStyle(
                      fontSize: tamanoTexto, fontWeight: FontWeight.bold),
                ),
                TextFormFieldWidget(
                  action: TextInputAction.next,
                  controller: _conApellido,
                  hintName: 'Apellidos',
                  icon: Icons.person_rounded,
                  inputType: TextInputType.text,
                ),
                const SizedBox(height: 10),
                Text(
                  'Nombres',
                  style: TextStyle(
                      fontSize: tamanoTexto, fontWeight: FontWeight.bold),
                ),
                TextFormFieldWidget(
                  action: TextInputAction.done,
                  controller: _conNombre,
                  hintName: 'Nombre(s)',
                  icon: Icons.person_rounded,
                  inputType: TextInputType.text,
                ),
                Text(
                  'Genero',
                  style: TextStyle(
                      fontSize: tamanoTexto, fontWeight: FontWeight.bold),
                ),
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0XFFECECEC),
                        border: Border.all(
                            color: const Color(0xfff69100), width: 2.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          //Opcion 'Hombre'
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                          decoration: BoxDecoration(
                            color: _conGenero == SelectedGender.hombre
                                ? const Color(0xFFFFFFFF)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8.0),
                            // border: Border.all(
                            //     color: conGenero == SelectedGender.hombre
                            //         ? const Color(0xfff69100)
                            //         : Colors.transparent),
                          ),
                          child: RadioListTile<SelectedGender>(
                            selected: SelectedGender.hombre == _conGenero,
                            title: Text('Masculino',
                                style: TextStyle(fontSize: 16.sp)),
                            value: SelectedGender.hombre,
                            groupValue: _conGenero,
                            onChanged: (SelectedGender? value) {
                              setState(() {
                                if (_conGenero != null) {
                                  _conGenero = value;
                                }
                              });
                            },
                            activeColor: const Color(0xfff69100),
                          ),
                        ),
                        Container(
                          //Opcion 'Mujer'
                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          decoration: BoxDecoration(
                            color: _conGenero == SelectedGender.mujer
                                ? const Color(0xFFFFFFFF)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8.0),
                            // border: Border.all(
                            //     color: conGenero == SelectedGender.mujer
                            //         ? const Color(0xfff69100)
                            //         : Colors.transparent),
                          ),
                          child: RadioListTile<SelectedGender>(
                            selected: SelectedGender.mujer == _conGenero,
                            title: Text('Femenino',
                                style: TextStyle(fontSize: 16.sp)),
                            value: SelectedGender.mujer,
                            groupValue: _conGenero,
                            onChanged: (SelectedGender? value) {
                              setState(() {
                                if (_conGenero != null) {
                                  _conGenero = value;
                                }
                              });
                            },
                            activeColor: const Color(0xfff69100),
                          ),
                        ),
                      ],
                    )),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 1,
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          textStyle: const TextStyle(fontSize: 18),
                          backgroundColor: const Color(0xFFFF9800),
                          foregroundColor: const Color(0xffffffff),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: registrarAlumno,
                        child: const Text('Guardar')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum SelectedGender { hombre, mujer }
