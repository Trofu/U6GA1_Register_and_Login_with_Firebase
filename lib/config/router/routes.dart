import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:FirebaseU6GA1/screens/comarca.dart';
import 'package:FirebaseU6GA1/screens/comarcas.dart';
import 'package:FirebaseU6GA1/screens/login.dart';
import 'package:FirebaseU6GA1/screens/provincias.dart';
import 'package:FirebaseU6GA1/screens/signup.dart';

const clientId = 'AIzaSyCwqC4BWIMJZFQTRmiN86PwzZXryY3DKiY';


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
        final currentUser = FirebaseAuth.instance.currentUser;
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
        final String comId = state.pathParameters['comId']!;
        return ComarcaInfo(comarca: int.parse(comId),provincia: int.parse(proId));
      },
    ),
    GoRoute(
      name: 'Favoritos',
      path: '/favorite',
      builder: (context, state) {
        return const LoginScreen();
      }
    )
  ],
);

