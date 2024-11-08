import 'package:flutter/material.dart';
import 'package:u3ga1/screens/login.dart';
import 'package:u3ga1/screens/provincias.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Comarcas',
      home: Scaffold(
          appBar: AppBar(
              title: const Text(
                'Comarcas',
              ),
              centerTitle: false, // Esto centrará el título en la AppBar
          ),
          //body: const LoginScreen())));
          body: const ProvinciasScreen())));
          //body: const ComarquesScreen())));
          //body: const InfoComarca1Screen())));
          //body: const InfoComarca2Screen())));
}
