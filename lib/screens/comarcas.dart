import 'package:FirebaseU6GA1/config/peticions_http.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ComarquesScreen extends StatefulWidget {
  final String provincia;

  const ComarquesScreen({Key? key, required this.provincia}) : super(key: key);

  @override
  State<ComarquesScreen> createState() =>
      _ComarquesScreenState(provincia: provincia);
}

class _ComarquesScreenState extends State<ComarquesScreen> {
  late Future<dynamic> comarca;
  final String provincia;

  _ComarquesScreenState({required this.provincia});

  @override
  void initState() {
    super.initState();
    comarca = obtenirComarquesAmbImatge(provincia: provincia);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: comarca,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Comarcas de " + provincia),
                centerTitle: true,
              ),
              body: SafeArea(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    final comarcaName = snapshot.data[index];
                    return buildComarcaCard(
                        comarca: comarcaName, indice: index);
                  },
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }

  // Método para construir cada carta
  Widget buildComarcaCard({required var comarca, required int indice}) {
    return TextButton(
        onPressed: () {
          String ruta = "/${comarca["nom"].toString()}/info";
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
                  comarca["nom"],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
