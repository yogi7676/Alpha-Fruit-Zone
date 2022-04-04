import 'package:flutter/material.dart';

class CartItemButton extends StatelessWidget {
  final Function() onTap;
  final IconData icon;
  const CartItemButton({Key? key, required this.onTap, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          borderRadius: BorderRadius.circular(5),
        ),
        height: 30,
        width: 30,
        child: Icon(
          icon,
          size: 18,
        ),
      ),
    );
  }
}
