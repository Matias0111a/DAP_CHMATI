import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loginhome1/presentation/providers/auth_service.dart';

class HomeScreen extends StatelessWidget {
  static const String name = 'home';
  const HomeScreen({super.key, required this.userName, required this.direction});
  final String userName;
  final String direction;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final photoUrl = user?.photoURL;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          // Profile avatar + menu
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: PopupMenuButton<String>(
              tooltip: 'Perfil',
              onSelected: (value) async {
                if (value == 'signout') {
                  try {
                    await AuthService().signOut();
                    // Navegar a login (ajusta la ruta si tu router usa otra)
                    GoRouter.of(context).go('/login');
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error al cerrar sesión: $e')),
                      );
                    }
                  }
                }
              },
              itemBuilder: (context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'profile',
                  child: Text('Ver perfil'),
                ),
                const PopupMenuItem<String>(
                  value: 'signout',
                  child: Text('Cerrar sesión'),
                ),
              ],
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.transparent,
                backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
                child: photoUrl == null
                    ? const Icon(Icons.person, color: Colors.black)
                    : null,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenido ${userName.toString()}',
              textAlign: TextAlign.center,
              style: const TextStyle(
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
                  child: const Text('Bandas', style: TextStyle(fontSize: 30, color: Colors.black)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
