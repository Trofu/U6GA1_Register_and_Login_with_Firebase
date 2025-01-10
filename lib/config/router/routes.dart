import 'package:go_router/go_router.dart';
import 'package:u3ga1/screens/comarca1.dart';
import 'package:u3ga1/screens/comarca2.dart';
import 'package:u3ga1/screens/comarcas.dart';
import 'package:u3ga1/screens/login.dart';
import 'package:u3ga1/screens/provincias.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: 'login',
      path: '/', // Ruta raíz o Home
      builder: (context, state) => const LoginScreen(),
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
      name: 'informacion1',
      path: '/provincias/:proId/comarca/:comId',
      builder: (context, state) {
        final String proId = state.pathParameters['proId']!;
        final String comId = state.pathParameters['comId']!;
        return InfoComarca1Screen(comarca: int.parse(comId),provincia: int.parse(proId));
      },
    ),
    GoRoute(
      name: 'informacion2',
      path: '/provincias/:proId/comarca/:comId/tiempo',
      builder: (context, state) {
        final String proId = state.pathParameters['proId']!;
        final String comId = state.pathParameters['comId']!;
        return InfoComarca2Screen(comarca: int.parse(comId),provincia: int.parse(proId));
      },
    ),
  ],
);
