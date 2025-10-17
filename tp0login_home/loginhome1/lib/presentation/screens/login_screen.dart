import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loginhome1/presentation/providers/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  static const String name = 'login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loading = false;

  Future<void> _signInWithGoogle() async {
    setState(() => _loading = true);
    try {
      final auth = AuthService();
      await auth.signInWithGoogle();

      final user = FirebaseAuth.instance.currentUser;
      final userName =
          user?.displayName ?? user?.email?.split('@').first ?? 'Usuario';
      final direction = 'google';

      if (!mounted) return;
      GoRouter.of(context).go('/home', extra: {
        'username': userName,
        'direction': direction,
      });
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Google Sign-In: ${e.message ?? e.code}')),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Google Sign-In: $e')),
      );
    } finally {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar sesión'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF4285F4), Color(0xFF34A853)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                child: Icon(
                  Icons.account_circle,
                  size: 64,
                  color: Colors.white,
                ),
              ),
            ),


            const SizedBox(height: 36), 

            SizedBox(
              width: buttonWidth > 500 ? 500 : buttonWidth,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  minimumSize: const Size.fromHeight(60),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  textStyle:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                onPressed: _loading ? null : _signInWithGoogle,
                child: _loading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.g_mobiledata,
                            size: 28,
                            color: Color(0xFF4285F4),
                          ),
                          SizedBox(width: 20),
                          Text(
                            'Continuar con Google',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}