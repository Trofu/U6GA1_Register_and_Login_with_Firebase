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
                        color: Color.fromRGBO(14, 185, 232, 100),
                        fontSize: 32,
                        shadows: [
                          const Shadow(
                              color: Colors.black,
                              blurRadius: 3.0,
                              offset: Offset(3.0, 3.0))
                        ]),
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
                          context.push("/login");
                        },
                      ),
                      TextButton(
                        child: const Text("CANCEL"),
                        onPressed: () {
                          pass.clear();
                          user.clear();
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
