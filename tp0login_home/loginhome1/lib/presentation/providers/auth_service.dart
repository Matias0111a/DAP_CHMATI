import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthService({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
      : _auth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.instance;

  Future<UserCredential> signInWithGoogle() async {
    // Web: usar el proveedor de FirebaseAuth directamente (popup/redirect)
    if (kIsWeb) {
      final provider = GoogleAuthProvider();
      // Puedes usar signInWithPopup o signInWithRedirect según tu preferencia
      return await _auth.signInWithPopup(provider);
    }

    // Plataformas móviles/desktop: intentar flujo de google_sign_in (soporte 7.x adaptado)
    String? idToken;
    String? accessToken;
    dynamic googleUser;

    // Intentar API "antigua" (si existe)
    try {
      googleUser = await (_googleSignIn as dynamic).signIn();
      if (googleUser != null) {
        try {
          final googleAuth = await (googleUser as dynamic).authentication;
          idToken = googleAuth.idToken as String?;
          accessToken = googleAuth.accessToken as String?;
        } catch (_) {
          // no pudo leer authentication - seguir al intento 7.x
        }
      }
    } catch (_) {
      // signIn no disponible -> intentar 7.x abajo
    }

    // Si no obtuvimos tokens con la ruta antigua, usar la API 7.x
    if (idToken == null && accessToken == null) {
      try {
        await (_googleSignIn as dynamic).authenticate();
      } catch (e) {
        throw FirebaseAuthException(
            code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted: $e');
      }

      // Obtener usuario actual o desde el primer evento
      googleUser = (_googleSignIn as dynamic).currentUser;
      if (googleUser == null) {
        try {
          final event =
              await (_googleSignIn as dynamic).authenticationEvents.first;
          googleUser = (event as dynamic).user;
        } catch (_) {}
      }

      if (googleUser == null) {
        throw FirebaseAuthException(
            code: 'ERROR_ABORTED_BY_USER',
            message: 'Sign in aborted by user (no user)');
      }

      // Intentar obtener headers (contienen "Authorization: Bearer <token>")
      try {
        final headers = await (googleUser as dynamic)
            .authorizationClient
            .authorizationHeaders(<String>['email']);
        if (headers != null) {
          final authHeader =
              (headers['Authorization'] ?? headers['authorization']) as String?;
          if (authHeader != null && authHeader.startsWith('Bearer ')) {
            accessToken = authHeader.substring(7);
          }
        }
      } catch (_) {
        // fallback: intentar authorizeServer (serverAuthCode) - requiere intercambio en backend
        try {
          final serverAuth = await (googleUser as dynamic)
              .authorizationClient
              .authorizeServer(<String>['email']);
          idToken = serverAuth?.serverAuthCode as String?;
        } catch (_) {}
      }
    }

    if (idToken == null && accessToken == null) {
      throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'No se obtuvo idToken ni accessToken de Google Sign-In');
    }

    final credential = GoogleAuthProvider.credential(
      idToken: idToken,
      accessToken: accessToken,
    );

    return await _auth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    try {
      await (_googleSignIn as dynamic).disconnect();
    } catch (_) {
      try {
        await (_googleSignIn as dynamic).signOut();
      } catch (_) {}
    }
    await _auth.signOut();
  }

  Stream<User?> authStateChanges() => _auth.authStateChanges();
}