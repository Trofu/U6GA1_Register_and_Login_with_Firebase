import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../date/counties.dart';

class ComarquesScreen extends StatefulWidget{

  const ComarquesScreen({Key?key}): super(key: key);

  @override
  State<ComarquesScreen> createState() => _ComarquesScreenState();
}

class _ComarquesScreenState extends State<ComarquesScreen> {

  final comarca = provincies["provincies"][0]["comarques"];
  final provincia = provincies["provincies"][0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Comarcas de "+ provincia["provincia"]
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemCount: comarca.length,
          itemBuilder: (context, index) {
            final comarca = this.comarca[index];
            return buildComarcaCard(comarca);
          },
        ),
      ),
    );
  }

  // Método para construir cada carta
  Widget buildComarcaCard(Map<String, dynamic> comarca) {
    return Container(
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
    );
  }
}


