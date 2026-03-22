import 'package:flutter/material.dart';

class SectionButton extends StatefulWidget {
  final String text;
  final IconData iconData;
  final VoidCallback onPressed;

  const SectionButton({
    super.key,
    required this.text,
    required this.iconData,
    required this.onPressed,
  });

  @override
  State<SectionButton> createState() => _SectionButtonState();
}

class _SectionButtonState extends State<SectionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: _isPressed ? Colors.white30 : Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        width: 140,
        height: 50,
        margin: EdgeInsets.all(4),
        child: Padding(
          padding: EdgeInsets.fromLTRB(12, 4, 4, 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 40,
                child: Icon(
                  widget.iconData,
                  color: Theme.of(context).primaryColor,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
