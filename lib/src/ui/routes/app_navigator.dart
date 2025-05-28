import 'package:go_router/go_router.dart';
import 'package:sabail/src/presentation/features/home/view/home.dart';
import 'package:sabail/src/ui/pages/screens/splash_screen.dart';
import 'package:sabail/src/ui/routes/app_router.dart';

class AppNavigator {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const SabailHome(),
      ),
    ],
  );
}
