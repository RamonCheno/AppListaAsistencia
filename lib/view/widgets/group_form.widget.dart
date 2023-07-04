import 'package:lista_asistencia_actualizado/index/index.view.dart';

class GrupoForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController conNombre;
  final VoidCallback actionFunction;
  final String text;
  final String buttonText;
  final String? nameGroup;
  final int? idGrupo;

  const GrupoForm(
      {Key? key,
      required this.formKey,
      required this.conNombre,
      required this.actionFunction,
      required this.text,
      required this.buttonText,
      this.nameGroup,
      this.idGrupo})
      : super(key: key);

  @override
  State<GrupoForm> createState() => _GrupoFormState();
}

class _GrupoFormState extends State<GrupoForm> {
  // GroupController groupC = GroupController();

  @override
  void initState() {
    super.initState();
    // if (widget.idGrupo != null) {
    //   _cargarDatosGrupo();
    // }
  }

  // Future<void> _cargarDatosGrupo() async {
  //   final grupo = await groupC.getGroup(widget.idGrupo!);
  //   widget.conNombre.text = grupo.nombreGrupo;
  // }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.text),
      content: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Form(
          key: widget.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Nombre',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              TextFormFieldWidget(
                controller: widget.conNombre,
                hintName: 'Nombre',
                icon: Icons.groups,
                action: TextInputAction.done,
                inputType: TextInputType.text,
              ),
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
                      onPressed: widget.actionFunction,
                      child: Text(widget.buttonText)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
