import 'package:flutter/material.dart';


import 'config/router/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}

  // runApp(MaterialApp(
  //     theme: ThemeData(
  //       primarySwatch: Colors.blue,
  //     ),
  //     debugShowCheckedModeBanner: false,
  //     title: 'Comarcas',
  //     home: Scaffold(
  //
  //         //body: const LoginScreen())));
  //         //body: const ProvinciasScreen())));
  //         //body: const ComarquesScreen())));
  //         //body: const InfoComarca1Screen())));
  //         body: const InfoComarca2Screen())));
