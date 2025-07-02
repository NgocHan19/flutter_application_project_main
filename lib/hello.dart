import 'package:flutter/material.dart';
import 'package:flutter_application_project_main/presentation/screens/login_screen.dart';

class Hello extends StatelessWidget {
  const Hello({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              color: const Color(0xFFFFE0B2),
            ),
            Align(
              alignment: const Alignment(0, -1.6),
              child: Image.asset(
                "assets/images/intro.png",
                width: 400,
                fit: BoxFit.contain,
              ),
            ),

            Positioned(
              bottom: 100,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Chào mừng đến với Jobnest",
                    style: TextStyle(
                      color: Color(0xFFFFA726),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Sự nghiệp mới cùng ánh bình minh!",
                    style: TextStyle(
                      color: Color(0xFFFFA726),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 30,
              right: 30,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFFFA726),

                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_forward, color: Color(0xFFFFA726), size: 30),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
