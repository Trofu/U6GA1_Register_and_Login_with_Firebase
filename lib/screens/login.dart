import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget{

  const LoginScreen({Key?key}): super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

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
                  ),
                  const SizedBox(height: 12.0),
                  OverflowBar(
                    alignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: const Text("CANCEL"),
                        onPressed: () {
                          pass.clear();
                          user.clear();
                        },
                      ),
                      ElevatedButton(
                        child: const Text("NEXT"),
                        onPressed: () {
                          // Navigator.pop(context);
                        },
                      )
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