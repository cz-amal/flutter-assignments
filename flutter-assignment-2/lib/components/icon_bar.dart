import 'package:flutter/material.dart';

class IconBar extends StatefulWidget {
  final String iconPath;
  final bool isSelected;
  final void Function()? onPressed;
  const IconBar({
    super.key,
    required this.iconPath,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  State<IconBar> createState() => _IconBarState();
}

class _IconBarState extends State<IconBar> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        backgroundColor: widget.isSelected ? Colors.blue : Colors.white,
        shape: CircleBorder(
          side: BorderSide(
            color: widget.isSelected ? Colors.white : Colors.grey,
          ),
        ),
      ),
      onPressed: widget.onPressed,
      icon: Image.asset(
        widget.iconPath,
        height: 20,
        width: 20,
        color: widget.isSelected ? Colors.white : Colors.grey,
      ),
    );
  }
}
