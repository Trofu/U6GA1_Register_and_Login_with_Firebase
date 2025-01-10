import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../date/counties.dart';

class ComarquesScreen extends StatefulWidget {
  final int provincia;

  const ComarquesScreen({Key? key, required this.provincia}) : super(key: key);

  @override
  State<ComarquesScreen> createState() =>
      _ComarquesScreenState(provincia);
}

class _ComarquesScreenState extends State<ComarquesScreen> {
  late var comarca;
  late var provincia;
  late final int provinciaId;

  _ComarquesScreenState(this.provinciaId) {
    comarca = provincies["provincies"][this.provinciaId]["comarques"];
    provincia = provincies["provincies"][this.provinciaId];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comarcas de " + provincia["provincia"]),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemCount: comarca.length,
          itemBuilder: (context, index) {
            final comarca = this.comarca[index];
            return buildComarcaCard(comarca,index);
          },
        ),
      ),
    );
  }

  // Método para construir cada carta
  Widget buildComarcaCard(Map<String, dynamic> comarca,int indice) {
    return TextButton(
      onPressed: () {
        String ruta = "/provincias/$provinciaId/comarca/$indice";
        context.push(ruta);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 4.0),
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(comarca["img"]),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 8,
              left: 8,
              child: Text(
                comarca["comarca"],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
