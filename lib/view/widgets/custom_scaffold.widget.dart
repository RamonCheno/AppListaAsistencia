import 'package:lista_asistencia_actualizado/index/index.view.dart';

class CustomScaffoldWidget extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>>? actions;
  final Widget? leading;
  final Widget cuerpo;
  final Widget? floatingActionButton;
  final Widget? bottomNavigatorBar;
  final Widget? drawer;
  const CustomScaffoldWidget(
      {required this.title,
      required this.cuerpo,
      this.actions,
      this.floatingActionButton,
      this.leading,
      this.bottomNavigatorBar,
      this.drawer,
      super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = 100.h;
    final double screenWidth = 100.w;
    final double tamanoTexto = 20.sp;
    return Scaffold(
      appBar: AppBar(
        leading: leading,
        title: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: tamanoTexto),
        ),
        actions: [
          if (actions != null)
            for (final action in actions!)
              CustomPopMenuButton(items: [
                {
                  'icono': action['icono'],
                  'text': action['text'],
                  'value': action['value'],
                  'onTap': action['onTap'],
                }
              ], iconMenu: Icons.menu, colorIcon: Colors.white),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: Container(
            decoration: const BoxDecoration(
                color: Color(0XFFECECEC),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            height: 10,
          ),
        ),
      ),
      drawer: drawer,
      body: Stack(
        children: [
          Container(
            width: screenWidth,
            height: screenHeight,
            color: const Color(0XFFECECEC),
          ),
          cuerpo,
        ],
      ),
      bottomNavigationBar: bottomNavigatorBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
