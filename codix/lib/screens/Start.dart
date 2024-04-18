import 'package:codix/screens/HomePage.dart';
import 'package:flutter/material.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(Duration(seconds: 5));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFB8500),
          ),
          child: const Center(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Codix News',
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontSize: 48,
                    ),
                  ),
                  SizedBox(
                      height:
                          16), // Add some space between the two Text widgets
                  Text(
                    'Your trusted source for tech insights, tips, and trends. Explore the digital world with confidence and stay informed with us.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
