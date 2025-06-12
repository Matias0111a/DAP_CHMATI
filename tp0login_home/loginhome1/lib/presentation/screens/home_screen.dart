import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class HomeScreen extends StatelessWidget {
  static const String name = 'home';
  const HomeScreen({super.key, required this.userName, required this.direction});
  final String userName;
  final String direction;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenido ${userName.toString()} con dirección $direction',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    GoRouter.of(context).push('/bandas');
                  },
                  child: const Text('Bandas', style: TextStyle(fontSize: 35, color: Colors.black)),
                ),
              ElevatedButton(
              onPressed: () {
                GoRouter.of(context).push('/esp32');
              },
              child: const Text('VACIO', style: TextStyle(fontSize: 35, color: Colors.black)),
            ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
