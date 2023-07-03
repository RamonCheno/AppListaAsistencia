import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  final Widget icon;
  final Widget icon2;
  final int value;
  final int? groupValue;
  final bool selected;
  final ValueChanged<int?> onChanged;
  const CustomRadio(
      {required this.groupValue,
      required this.value,
      required this.icon,
      required this.icon2,
      required this.selected,
      required this.onChanged,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (groupValue != null && value != groupValue) {
          onChanged(value);
        }
      },
      child: Row(
        children: [
          Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: selected ? icon : icon2),
          const Text(''),
        ],
      ),
    );
  }
}
