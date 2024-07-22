import 'package:flutter/material.dart';

class SplachScreen1 extends StatelessWidget {
  const SplachScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
              size: 80,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  text: TextSpan(
                    text: "e",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                    children: [
                      TextSpan(
                        text: "Grocery",
                        style: TextStyle(color: Colors.white),
                      ),
                    ]
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}