import 'package:FirebaseU6GA1/config/peticions_http.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/widget_clima.dart';

class ComarcaInfo extends StatefulWidget {
  final String comarca;

  const ComarcaInfo({Key? key, required this.comarca}) : super(key: key);

  @override
  State<ComarcaInfo> createState() => _ComarcaInfoState(comarca);
}

class _ComarcaInfoState extends State<ComarcaInfo> {
  int _currentIndex = 0;
  late Future<dynamic> infoComarca;
  String comarca;
  bool esFavorito = false;
  late final String id;
  late DatabaseReference ref;

  @override
  void initState() {
    super.initState();
    _verificarFavorito();
    infoComarca = obtenirInfoComarca(comarca: comarca);
  }

  _ComarcaInfoState(this.comarca) {
    id = FirebaseAuth.instance.currentUser?.uid ?? "";
    ref = FirebaseDatabase.instance.ref("usuarios/$id/favoritos/${comarca}");
  }

  Future<void> _verificarFavorito() async {
    final existe = await ref.child("favorito").get();
    setState(() {
      esFavorito = existe.exists && (existe.value == true);
    });
  }

  Future<void> anyadirFavoritos() async {
    String errorMessage = "Añadiendo ${comarca} a favoritos";
    final existe = await ref.child("favorito").get();
    if (existe.exists) {
      if (esFavorito) {
        await ref.update({"favorito": false});
        errorMessage = "Quitando ${comarca} de favoritos";
      } else {
        await ref.update({"favorito": true});
      }
    } else {
      await ref.set({
        "favorito": true,
        "comarca": comarca,
      });
    }
    setState(() {
      esFavorito = !esFavorito;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
  }

  /// Página de información de la comarca
  Widget _buildInfoPage(var info) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(info["img"]),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            info["comarca"],
                            style: const TextStyle(fontSize: 22),
                          ),
                          IconButton(
                            icon: Icon(
                                esFavorito ? Icons.star : Icons.star_border),
                            onPressed: () async {
                              await anyadirFavoritos();
                            },
                            tooltip: (esFavorito
                                ? "Quitar de favoritos"
                                : "Añadir a favoritos"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Capital: ${info["capital"]}",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          info["desc"],
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Página de información del clima
  Widget _buildClimaPage(var info) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: WidgetClima(comarca: info),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: infoComarca,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text(comarca),
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(Icons.arrow_back),
                  tooltip: "Volver atras",
                ),
              ),
              body: _currentIndex == 0
                  ? _buildInfoPage(snapshot.data)
                  : _buildClimaPage(snapshot.data),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (int index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.info),
                    label: 'Info',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.cloud),
                    label: 'Tiempo',
                  ),
                ],
              ),
            );
          }
          return CircularProgressIndicator();
        });
  }
}
