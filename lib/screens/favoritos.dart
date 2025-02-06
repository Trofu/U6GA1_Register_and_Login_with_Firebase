import 'package:FirebaseU6GA1/config/peticions_http.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FavoritosScreen extends StatefulWidget {
  const FavoritosScreen({super.key});

  @override
  State<FavoritosScreen> createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {

  var favoritos;

  _FavoritosScreenState();

  @override
  void initState() {
    super.initState();
    favoritos = obtenirFavoritos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favoritos"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: favoritos,
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No tienes favoritos"));
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return buildComarcaCard(comarca: snapshot.data![index]);
            },
          );
        },
      ),
    );
  }

  /// Widget que construye la tarjeta de cada favorito
  Widget buildComarcaCard({required var comarca}) {
    return TextButton(
      onPressed: () {
        String ruta = "/${comarca["comarca"].toString()}/info";
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
      ),
    );
  }
}
