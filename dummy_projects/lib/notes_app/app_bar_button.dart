import 'package:flutter/material.dart';

class AppBarButton extends StatelessWidget {
  final IconData icon;
  final void Function()? onPressed;
  const AppBarButton({
    super.key,
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 50,
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: const Color.fromARGB(255, 59,59,59),
        child: InkWell(
          onTap: onPressed, 
          customBorder: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          borderRadius: const BorderRadius.all(Radius.circular(10)),    
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon, size: 24,),
          ),
        ),
      ),
    );
  }
}