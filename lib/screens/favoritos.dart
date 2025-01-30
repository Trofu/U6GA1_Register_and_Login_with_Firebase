import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../date/counties.dart';

class FavoritosScreen extends StatefulWidget {
  const FavoritosScreen({super.key});

  @override
  State<FavoritosScreen> createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {
  late DatabaseReference ref;
  List<Map<String, dynamic>> favoritos = [];
  bool isLoading = true;


  @override
  void initState() {
    super.initState();
    var id = FirebaseAuth.instance.currentUser?.uid ?? "";
    ref = FirebaseDatabase.instance.ref("usuarios/$id/favoritos");
    getFavoritos();  // Llama a la función para buscar los favoritos
  }

  /// Función que obtiene los favoritos desde Firebase
  void getFavoritos() async {
    final snapshot = await ref.get();
    if (snapshot.exists) {
      Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        favoritos = data.entries.map((entry) {
          Map<String, dynamic> favorito = Map<String, dynamic>.from(entry.value);
          return favorito;
        }).toList();
        isLoading = false; // Cambia a false cuando los datos hayan sido cargados
      });
    } else {
      setState(() {
        isLoading = false; // Cambia a false si no hay datos en Firebase
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> sifavoritos=[];
    favoritos.forEach((element) => element["favorito"]==true? sifavoritos.add(element):null,);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favoritos"),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : sifavoritos.isEmpty
          ? const Center(child: Text("No tienes favoritos"))
          : ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemCount: sifavoritos.length,
        itemBuilder: (context, index) {
          var pro = sifavoritos[index]["pro"];
          var com = sifavoritos[index]["com"];
          return buildComarcaCard(index,pro,com);
        },
      ),
    );
  }

  /// Widget que construye la tarjeta de cada favorito
  Widget buildComarcaCard(int indice,int pro,int com) {
    var comarca = provincies["provincies"][pro]["comarques"][com];
    return TextButton(
      onPressed: () {
        String ruta = "/provincias/$pro/comarca/$com";
        context.push(ruta);          
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 4.0),
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(comarca["img"] ?? ""),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 8,
              left: 8,
              child: Text(
                comarca["comarca"] ?? "Sin nombre",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
