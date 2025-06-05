import 'package:go_router/go_router.dart';
import 'package:loginhome1/presentation/screens/esp32_screen.dart';
import 'package:loginhome1/presentation/screens/home_screen.dart';
import 'package:loginhome1/presentation/screens/login_screen.dart';
import 'package:loginhome1/presentation/screens/bandas_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      name: LoginScreen.name,
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: HomeScreen.name,
      path: '/home',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return HomeScreen(
          userName: extra['username'] as String,
          direction: extra['direction'] as String,
        );
      },
    ),
    GoRoute(
      name: BandasScreen.name,
      path: '/bandas',
      builder: (context, state) => BandasScreen(),
    ),
    GoRoute(
     name: Esp32Screen.name,
     path: '/esp32',
     builder: (context, state) => const Esp32Screen(), 
    )
  ],
);
