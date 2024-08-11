import 'package:flutter/material.dart';

class MultiPassApp extends StatelessWidget {
  const MultiPassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark, 
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Test"),
        ),
        body: Column(
          children: [
            for(int i = 0; i < 5; i++) const PasswordField(),
          ],
        ),
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({super.key});

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _shown = true;

  @override
  Widget build(BuildContext context) => TextFormField(
    obscureText: _shown,
    decoration: InputDecoration(
      suffixIcon: IconButton(
        onPressed: () => setState(() => _shown = !_shown),
        icon: Icon(_shown ? Icons.remove_red_eye_rounded : Icons.remove_red_eye_outlined),
      ),
    ),
  );
}