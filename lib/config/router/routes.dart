import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:u3ga1/screens/comarca.dart';
import 'package:u3ga1/screens/comarcas.dart';
import 'package:u3ga1/screens/login.dart';
import 'package:u3ga1/screens/provincias.dart';
import 'package:u3ga1/screens/signup.dart';

const clientId = 'AIzaSyCwqC4BWIMJZFQTRmiN86PwzZXryY3DKiY';

String user = "";
String pass = "";
final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      name: 'login',
      path: '/', // Ruta raíz o Home
      builder: (context, state) => LoginScreen(user: user, password: pass,),
      redirect: (context, state){

      }
    ),
    GoRoute(
      name: 'loginSignUp',
      path: '/login/:user/:password', // Ruta raíz o Home
      builder: (context, state){
        user = state.pathParameters['user']??='';
        pass = state.pathParameters['password']??='';
        return LoginScreen(user: user, password: pass);
      }
    ),
    GoRoute(
      path: '/signup',
      name: 'Sign Up',
      builder: (context,state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/:user/:pass',
      name: 'Auth',
      redirect: (context, state){
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser == null) {
          user = '';
          pass = '';
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
  ],
);

