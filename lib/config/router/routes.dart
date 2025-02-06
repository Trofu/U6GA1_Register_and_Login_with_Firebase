import 'package:FirebaseU6GA1/screens/favoritos.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:FirebaseU6GA1/screens/comarca.dart';
import 'package:FirebaseU6GA1/screens/comarcas.dart';
import 'package:FirebaseU6GA1/screens/login.dart';
import 'package:FirebaseU6GA1/screens/provincias.dart';
import 'package:FirebaseU6GA1/screens/signup.dart';

var provincia="";
final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: 'login',
      path: '/', // Ruta raíz o Home
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      name: 'Sign Up',
      builder: (context,state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/Auth',
      name: 'Auth',
      redirect: (context, state){
        // Verifica si esta el usuario conectado
        final currentUser = FirebaseAuth.instance.currentUser;
        // Si por algun motivo es nulo que lo devuelva al login
        if (currentUser == null) {
          return "/";
        }
        return "/provincias";
      }
    ),
    GoRoute(
      name: 'provincias',
      path: '/provincias',
      builder: (context, state) => const ProvinciasScreen(),
    ),
    GoRoute(
      name: 'comarcas',
      path: '/:proId/comarcas',
      builder: (context, state) {
        final String proId = state.pathParameters['proId']!;
        provincia = proId;
        return ComarquesScreen(provincia: proId);
      },
    ),
    GoRoute(
      name: 'informacion',
      path: '/:comId/info',
      builder: (context, state) {
        final String comId = state.pathParameters['comId']!;
        return ComarcaInfo(comarca: comId);
      },
    ),
    GoRoute(
      name: 'Favoritos',
      path: '/favorite',
      builder: (context, state) {
        return const FavoritosScreen();
      }
    )
  ],
);

