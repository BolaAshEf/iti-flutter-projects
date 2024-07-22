import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _backgroundWidget(),
          Container(
            margin: EdgeInsets.only(top: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Colors.white
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 130,),
                    _emailField(),
                    const SizedBox(height: 20,),
                    _passField(),
                    _forgetPass(),
                    const SizedBox(height: 30,),
                    _loginButton(),
                    const SizedBox(height: 80,),
                    _registerQuestion()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Center _registerQuestion() {
    return Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Don`t have an account?"),
                        TextButton(
                          onPressed: (){},
                          child: Text("Register Now", style: TextStyle(color: Colors.blueAccent),),
                        ),
                      ],
                    ),
                  );
  }

  Center _loginButton() {
    return Center(
                    child: InkWell(
                      onTap: (){},
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blue[300],
                        ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(11),
                          child: Text("Login", style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),
                  );
  }

  Align _forgetPass() {
    return Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: (){},
                      child: Text("forget password", style: TextStyle(color: Colors.blueAccent),),
                    ),
                  );
  }

  Container _passField() {
    return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[300]
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.lock_outline),
                        ),
                        border: InputBorder.none,
                        hintText: "Password",
                      ),
                    ),
                  );
  }

  Container _emailField() {
    return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[300]
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.email_outlined),
                        ),
                        border: InputBorder.none,
                        hintText: "Your Email",
                      ),
                    
                    ),
                  );
  }

  Container _backgroundWidget() {
    return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 30, 74, 156),
                Color.fromARGB(255, 30, 74, 156).withOpacity(0.7)
              ],
              stops: [
                0,1
              ],
            ),
            
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 50, left: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40
                    ),
                  ),
                  Text(
                    "Enter a beautiful world.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}