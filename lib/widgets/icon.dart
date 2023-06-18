import 'package:flutter/material.dart';

class WhiteIcon extends StatelessWidget {
  final IconData icon;
  const WhiteIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 1,
              offset: Offset(2, -2),
              color: Colors.black54,
            ),
          ]),
      child: Icon(
        icon,
        color: Colors.black.withOpacity(0.5),
        size: 25,
      ),
    );
  }
}
