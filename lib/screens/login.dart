import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginScreen extends StatefulWidget{


  const LoginScreen({Key?key}): super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final user = TextEditingController();
  final pass = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<void> _login() async {
    try {
      // Inicia sesión con Firebase
      await _auth.signInWithEmailAndPassword(email: user.text.trim(), password: pass.text.trim());

      // Vacia el texto
      user.text="";
      pass.text="";
      // Viaja a autenticar
      context.push('/Auth');
      // Si no existe entra en el catch
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      // Si no existe mensaje de error
      if (e.code == 'user-not-found') {
        errorMessage = 'Usuario no encontrado.';
      // Si la contraseña no es correcta
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Contraseña incorrecta.';
      // Caso inesperado
      }else {
        errorMessage = 'Error: ${e.message}';
      }

      // Muestra el mensaje de error
      mensajeBarraAbajo(errorMessage);
    }
  }

  void mensajeBarraAbajo(String mensaje){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje)),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 10.0),
                  const Image(
                    image: AssetImage("assets/IMG/Escudo_de_la_Comunidad_Valenciana.svg.png"),
                    height: 250.0,
                  ),
                  const SizedBox(height: 10.0),
                  Text("Les comarques de la comunitat",
                    style: GoogleFonts.kodeMono(
                      color: Color.fromRGBO(14, 185, 232, 100),
                      fontSize: 32,
                      shadows: [
                        const Shadow(
                          color: Colors.black,
                          blurRadius: 3.0,
                          offset: Offset(3.0, 3.0)
                        )
                      ]
                    ) ,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: user,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'User',
                      border: OutlineInputBorder(),
                    ),

                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    controller: pass,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 12.0),
                  OverflowBar(
                    alignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        child: const Text("Log In"),
                        onPressed: () {
                          // Si los textos no son vacios realiza la accion
                          if (user.text.isNotEmpty && pass.text.isNotEmpty) {
                            _login(); // Llama a la función de login
                          }else {
                            mensajeBarraAbajo('Completa todos los campos');
                          }
                        },
                      ),
                      TextButton(
                        child: const Text("Sign Up"),
                        onPressed: () {
                          context.push("/signup");
                        },
                      ),
                    ],
                  )
                ],
              ) ,
            )
          ]
        )
      ),
    );
  }
}