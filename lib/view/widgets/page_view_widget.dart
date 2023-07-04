import 'package:lista_asistencia_actualizado/index/index.view.dart';

class PageViewWidget extends StatefulWidget {
  final List<Widget> pages;
  final List<BottomNavigationBarItem> bottomNavigatorBarItem;

  const PageViewWidget(
      {required this.pages, required this.bottomNavigatorBarItem, super.key});

  @override
  State<PageViewWidget> createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  int selectedIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: widget.pages,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: widget.bottomNavigatorBarItem,
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
