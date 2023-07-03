import 'package:flutter/material.dart';

class CustomPopMenuButton extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final IconData iconMenu;
  final Color colorIcon;
  const CustomPopMenuButton(
      {required this.colorIcon,
      required this.items,
      required this.iconMenu,
      super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return items.map<PopupMenuEntry>((item) {
          return PopupMenuItem(
            value: item['value'],
            onTap: item['onTap'],
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(children: [
                item['icono'],
                const SizedBox(
                  width: 16,
                ),
                Flexible(
                  child:
                      Text(item['text'], style: const TextStyle(fontSize: 15)),
                ),
              ]),
            ),
          );
        }).toList();
      },
      icon: Icon(iconMenu, size: 30, color: colorIcon),
    );
  }
}
