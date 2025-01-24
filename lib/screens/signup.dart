import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final user = TextEditingController();
  final pass = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signUp() async {

    try {
      // Registrar al usuario en Firebase Authentication
      await _auth.createUserWithEmailAndPassword(email: user.text.trim(), password: pass.text.trim());

      // Si es exitoso, navega al login con las credenciales
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro exitoso, inicia sesión.')),
      );
      user.text="";
      pass.text="";
      context.push("/Auth");
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'email-already-in-use') {
        errorMessage = 'Este correo ya está en uso.';
      } else if (e.code == 'weak-password') {
        errorMessage = 'La contraseña es demasiado débil.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Correo no válido.';
      } else {
        errorMessage = 'Error: ${e.message}';
      }

      // Mostrar mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
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
                    image: AssetImage(
                        "assets/IMG/Escudo_de_la_Comunidad_Valenciana.svg.png"),
                    height: 250.0,
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    "Sign Up",
                    style: GoogleFonts.kodeMono(
                        color: Color.fromRGBO(255, 88, 52, 100),
                        fontSize: 32,
                    ),
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
                  ),
                  const SizedBox(height: 12.0),
                  OverflowBar(
                    alignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        child: const Text("Sign Up"),
                        onPressed: () {
                          if (user.text.isNotEmpty && pass.text.isNotEmpty) {
                            _signUp();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Completa todos los campos')),
                            );
                          }
                        },
                      ),
                      TextButton(
                        child: const Text("Log In"),
                        onPressed: () {
                          context.push("/");
                        },
                      )
                    ],
                  )
                ],
              ),
            )
          ])),
    );
  }
}
