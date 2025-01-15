import 'package:go_router/go_router.dart';
import 'package:u3ga1/screens/comarca.dart';
import 'package:u3ga1/screens/comarcas.dart';
import 'package:u3ga1/screens/login.dart';
import 'package:u3ga1/screens/provincias.dart';
import 'package:u3ga1/screens/signup.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: 'login',
      path: '/', // Ruta raíz o Home
      builder: (context, state) => const LoginScreen("",""),
    ),GoRoute(
      name: 'login',
      path: '/:user/:password', // Ruta raíz o Home
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      name: 'Sign Up',
      builder: (context,state) => const SignupScreen(),
    ),
    GoRoute(
      name: 'provincias',
      path: '/provincias',
      builder: (context, state) => const ProvinciasScreen(),
    ),
    GoRoute(
      name: 'comarcas',
      path: '/provincias/:proId/comarcas',
      builder: (context, state) {
        final String proId = state.pathParameters['proId']!;
        return ComarquesScreen(provincia: int.parse(proId),);
      },
    ),
    GoRoute(
      name: 'informacion',
      path: '/provincias/:proId/comarca/:comId',
      builder: (context, state) {
        final String proId = state.pathParameters['proId']!;
        print("Codigo de la provincia: "+proId);
        final String comId = state.pathParameters['comId']!;
        print("Codigo de la comarca: "+comId);
        return ComarcaInfo(comarca: int.parse(comId),provincia: int.parse(proId));
      },
    ),
  ],
);
