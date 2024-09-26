import 'package:go_router/go_router.dart';
import 'package:lingo_panda/presentation/screens/comments_screen.dart';
import 'package:lingo_panda/presentation/screens/login_screen.dart';
import 'package:lingo_panda/presentation/screens/signup_screen.dart';

class Routes {
  static String comments = '/comments';
  static String signup = '/signup';
  static String login = '/login';
}

class RoutingUtils {
  static buildGoRouter() => GoRouter(
        initialLocation: Routes.comments,
        routes: [
          GoRoute(
            path: Routes.login,
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            path: Routes.signup,
            builder: (context, state) => const SignupScreen(),
          ),
          GoRoute(
            path: Routes.comments,
            builder: (context, state) => const CommentsScreen(),
          ),
        ],
      );
}
