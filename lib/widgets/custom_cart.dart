import 'package:flutter/material.dart';

class CustomCart extends StatelessWidget {
  const CustomCart({
    super.key,
    required this.child,
    required this.number,
  });

  final Widget child;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          top: 15,
          right: 10,
          child: Container(
            alignment: Alignment.center,
            width: 14,
            height: 14,
            decoration: const BoxDecoration(
              color: Colors.teal,
              shape: BoxShape.circle,
            ),
            child: Text(
              number,
              style: const TextStyle(fontSize: 10),
            ),
          ),
        )
      ],
    );
  }
}
