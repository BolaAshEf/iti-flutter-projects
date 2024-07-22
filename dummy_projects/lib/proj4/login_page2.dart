import 'package:flutter/material.dart';

class LoginPage2 extends StatefulWidget {
  const LoginPage2({super.key});

  @override
  State<LoginPage2> createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  bool _shown = false;
  bool _rememberMe = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text(
          "Acount Login", 
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset("images/login-logo.jpg"),
            ),
            const SizedBox(height: 0,),
            ..._emailField(),
            const SizedBox(height: 20,),
            ..._passField(),
            _rememberMeAndForgetPass(),
            const SizedBox(height: 30,),
            _loginButton(),
            const SizedBox(height: 20,),
            _registerQuestion()
          ],
        ),
      ),
    );
  }

  Widget _registerQuestion() => Center(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Don`t have an account?"),
        TextButton(
          onPressed: (){},
          child: const Text(
            "Register", 
            style: TextStyle(color: Colors.green),
          ),
        ),
      ],
    ),
  );

  Widget _loginButton() => Center(
    child: InkWell(
      onTap: (){},
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.green,
        ),
        alignment: Alignment.center,
        child: const Padding(
          padding: EdgeInsets.all(18),
          child: Text(
            "Login", 
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );

  Widget _rememberMeAndForgetPass() => Row(
    children: [
      Checkbox(value: _rememberMe, onChanged: (val) => setState(() => _rememberMe = val ?? false)),
      const Text("Remember me"),
      const Spacer(),
      TextButton(
        onPressed: (){},
        child: const Text(
          "Forget Password!", 
          style: TextStyle(color: Colors.black),
        ),
      ),
    ],
  );

  List<Widget> _passField() => [
    const Text("Password"),
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[300]
      ),
      child: TextFormField(
        obscureText: !_shown,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () => setState(() => _shown = !_shown),
            icon: Icon(_shown ? Icons.remove_red_eye_rounded : Icons.remove_red_eye_outlined),
          ),
          border: InputBorder.none,
        ),
      ),
    ),
  ];

  List<Widget> _emailField() => [
    const Text("Email Address"),
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.grey[300]
      ),
      child: TextFormField(
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    ),
  ];
}