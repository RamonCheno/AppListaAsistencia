import 'package:lista_asistencia_actualizado/index/index.view.dart';

class ListGroupScreen extends StatefulWidget {
  const ListGroupScreen({super.key});
  static const String route = '/list_group';

  @override
  State<ListGroupScreen> createState() => ListGroupScreenState();
}

class ListGroupScreenState extends State<ListGroupScreen> {
  List<GroupModel> _groupList = [
    GroupModel(idGroup: 1, nameGroup: "ISC 8-1", idUser: 1),
    GroupModel(idGroup: 2, nameGroup: "ISC 2-1", idUser: 1),
    GroupModel(idGroup: 3, nameGroup: "ISC 4-1", idUser: 1),
    GroupModel(idGroup: 4, nameGroup: "ISC 6-1", idUser: 1)
  ];
  Map<String, dynamic> _args = {};
  // Map<String, dynamic> _arg = {};
  bool _isVisible = true;
  String? nombreGrupo;
  int _selectedIndex = 0;
  late TextEditingController _conNombre;
  late ScrollController _scrollController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<List<GroupModel>> _getGroup() async {
    List<GroupModel> groupList = _groupList;
    return groupList;
  }

  Future<void> _listsHomeNavigator() async {
    _args = {
      'id': _groupList[_selectedIndex].idGroup,
      'nombre': _groupList[_selectedIndex].nameGroup
    };
    await Navigator.pushNamed(context, ListsHome.route, arguments: _args)
        .then((value) {
      _getGroup().then((group) {
        setState(() {
          _groupList = group;
        });
      });
    });
  }

  Future<void> registrarGrupo() async {
    final FormState? form = _formKey.currentState;
    // String nombre = _conNombre.text;
    if (form != null) {
      if (form.validate()) {
        // int idTeacher = _arg['idTeacher'];
        // GroupModel groupM = GroupModel(nameGroup: nombre, idUser: 1);
        // groupM.idGroup = await groupC.guarderGrupo(groupM);
        if (!mounted) return;
        _conNombre.clear();
        Navigator.pop(context);
        setState(() {
          _getGroup().then((groups) => _groupList = groups);
        });
      }
    }
  }

  // Future<void> modificarGrupo(int id) async {
  //   final FormState? form = _formKey.currentState;
  //   String nombreModificado = _conNombre.text;
  //   if (form != null) {
  //     if (form.validate()) {
  //       int result = await groupC.actualizarNombreGrupo(id, nombreModificado);
  //       if (result == 1) {
  //         if (!mounted) return;
  //         mostrarSnackBar(context, 'Grupo agregado correctamente');
  //         Navigator.of(context).pop();
  //         setState(() {
  //           _getGroup().then((groups) => _groupList = groups);
  //         });
  //       } else {
  //         if (!mounted) return;
  //         mostrarSnackBar(
  //             context, 'Hubo un error al actualizar el grupo');
  //       }
  //     }
  //   }
  // }

  void updateGroupForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GrupoForm(
          formKey: _formKey,
          conNombre: _conNombre,
          actionFunction: () {},
          // modificarGrupo(_groupList[_selectedIndex].idGroup!),
          text: 'Modificar grupo',
          buttonText: 'Modificar',
          idGrupo: _groupList[_selectedIndex].idGroup,
          nameGroup: _groupList[_selectedIndex].nameGroup,
        );
      },
    );
  }

  void saveGroupForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GrupoForm(
          formKey: _formKey,
          conNombre: _conNombre,
          actionFunction: registrarGrupo,
          text: 'Agregar grupo',
          buttonText: 'Guardar',
        );
      },
    );
  }

  Future<void> eliminarGrupo(int? idGroup, int index) async {
    // if (idGroup != null) {
    //   await groupC.eliminarGrupo(idGroup);
    // }
    setState(() {
      if (_groupList.isNotEmpty) {
        _groupList.removeAt(index);
      }
    });
  }

  Future<void> _dialogConfirmarEliminarGrupo(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Eliminar Grupo'),
          content: Text(
              '¿Seguro que quiere eliminar el grupo ${_groupList[_selectedIndex].nameGroup} con alumnos y asistencia registradas?'),
          actions: [
            TextButton(
              child: const Text('Aceptar'),
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
                        '¿Realmente deseas eliminar de la lista el grupo ${_groupList[_selectedIndex].nameGroup}?',
                        style: const TextStyle(color: Colors.white),
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Aceptar',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () async {
                            Navigator.of(context).pop();
                            await eliminarGrupo(
                                _groupList[_selectedIndex].idGroup,
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
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancelar',
              ),
            ),
          ],
        );
      },
    );
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
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _conNombre = TextEditingController();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _conNombre.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double baseFontSize = 18.sp;
    final double tamanoTexto = baseFontSize;
    return CustomScaffoldWidget(
      title: 'Grupos',
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0XFFECECEC), Color(0xffDEDEDE)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            children: <Widget>[
              Container(
                height: 100,
                margin: const EdgeInsets.only(top: 30),
                child: DrawerHeader(
                  child: Text(
                    'Lista de Asistencia ISC'.toUpperCase(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontSize: 16),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app_outlined,
                    size: 26, color: Color(0xff0048BA)),
                title: const Text(
                  'Cerrar Sesión',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (context) {
                  //     return AlertDialog(
                  //       title: const Text('Cerrar Sesión'),
                  //       content:
                  //           const Text('¿Seguro que quiere Cerrar sesión?'),
                  //       actions: [
                  //         TextButton(
                  //           child: const Text('Aceptar'),
                  //           onPressed: () async {
                  //             Navigator.of(context).pop();
                  //             Navigator.of(context)
                  //                 .pushReplacementNamed(LoginScreen.route);
                  //           },
                  //         ),
                  //         TextButton(
                  //           onPressed: () {
                  //             Navigator.of(context).pop();
                  //           },
                  //           child: const Text('Cancelar'),
                  //         ),
                  //       ],
                  //     );
                  //   },
                  // );
                },
              ),
            ],
          ),
        ),
      ),
      cuerpo: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: _getGroup(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.none &&
                    !snapshot.hasData) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Color(0xffF69100),
                  ));
                }
                if (snapshot.data != null) {
                  _groupList = snapshot.data;
                }
                return _groupList.isEmpty
                    ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Text(
                            'Presione el "botón +" para agregar un grupo a la lista',
                            style:
                                TextStyle(fontSize: 24, color: Colors.black45)),
                      )
                    : ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          final GroupModel group = _groupList[index];
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
                              title: Row(
                                children: [
                                  const SizedBox(width: 15),
                                  Text(group.nameGroup,
                                      style: TextStyle(fontSize: tamanoTexto)),
                                ],
                              ),
                              onTap: () {
                                setState(() {
                                  _selectedIndex = index;
                                });
                                _listsHomeNavigator();
                              },
                              leading: CustomPopMenuButton(
                                items: [
                                  {
                                    'icono': const Icon(Icons.description,
                                        color: Color(0xff000000)),
                                    'value': 4,
                                    'text': 'Reporte',
                                    'onTap': () async {
                                      await Future.delayed(Duration.zero);
                                      if (!mounted) return;
                                      // _reportNavigator();
                                    },
                                  },
                                  {
                                    'icono': const Icon(Icons.delete_outline,
                                        color: Color(0xff000000)),
                                    'value': 6,
                                    'text': 'Eliminar',
                                    'onTap': () async {
                                      await Future.delayed(Duration.zero);
                                      if (!mounted) return;
                                      setState(() {
                                        _selectedIndex = index;
                                      });
                                      _dialogConfirmarEliminarGrupo(context);
                                    }
                                  },
                                  {
                                    'icono': const Icon(Icons.mode_edit_outline,
                                        color: Color(0xff000000)),
                                    'value': 7,
                                    'text': 'Modificar',
                                    'onTap': () async {
                                      await Future.delayed(Duration.zero);
                                      if (!mounted) return;
                                      setState(() {
                                        _selectedIndex = index;
                                      });
                                      // updateGroupForm(context);
                                    }
                                  },
                                ],
                                iconMenu: Icons.more_vert,
                                colorIcon: Colors.black,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                              height: 10,
                            ),
                        itemCount: _groupList.length);
              },
            ),
          )
        ],
      ),
      floatingActionButton: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: _isVisible ? 1.0 : 0.0,
        child: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: null /*saveGroupForm(context)*/,
          backgroundColor: const Color(0xffFF9800),
          child: Icon(
            Icons.add,
            color: _isVisible ? Colors.white : Colors.transparent,
            size: 22.sp,
          ),
        ),
      ),
    );
  }
}
