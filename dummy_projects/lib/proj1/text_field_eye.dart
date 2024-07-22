import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _shown = true;

  @override
  Widget build(BuildContext context) => TextFormField(
    decoration: InputDecoration(
      suffixIcon: IconButton(
        onPressed: () => setState(() => _shown = !_shown),
        icon: Icon(_shown ? Icons.remove_red_eye_rounded : Icons.remove_red_eye_outlined),
      ),
    ),
  );
}