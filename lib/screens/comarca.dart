import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../date/counties.dart';
import '../widgets/widget_clima.dart';

class ComarcaInfo extends StatefulWidget {
  final int comarca;
  final int provincia;

  const ComarcaInfo({Key? key, required this.comarca, required this.provincia})
      : super(key: key);

  @override
  State<ComarcaInfo> createState() =>
      _ComarcaInfoState(provincia, comarca);
}

class _ComarcaInfoState extends State<ComarcaInfo> {
  int _currentIndex = 0,pro,com;
  var comarca;
  bool esFavorito = false;
  late final String id;
  late DatabaseReference ref;


  @override
  void initState() {
    super.initState();
    _verificarFavorito();
  }

  _ComarcaInfoState(this.pro, this.com){
    comarca = provincies["provincies"][pro]["comarques"][com];
    id = FirebaseAuth.instance.currentUser?.uid ?? "";
    ref = FirebaseDatabase.instance.ref("usuarios/$id/favoritos/${pro}-${com}");
  }


  Future<void> _verificarFavorito() async {
    final existe = await ref.child("favorito").get();
    setState(() {
      esFavorito = existe.exists && (existe.value == true);
    });
  }

  Future<void> anyadirFavoritos() async {
    final existe = await ref.child("favorito").get();
    if (existe.exists) {
      if (esFavorito) {
        await ref.update({"favorito": false});
        print("remove favorito");
      } else {
        await ref.update({"favorito": true});
        print("add favorito");
      }
    } else {
      await ref.set({
        "favorito": true,
        "pro": pro,
        "com": com,
      });
    }
    setState((){
      esFavorito = !esFavorito;
      print("cambiando el favorito");
    });
  }


  /// Página de información de la comarca
  Widget _buildInfoPage(){
    () async {
      await _verificarFavorito();
    };
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
                      image: NetworkImage(comarca["img"]),
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
                            comarca["comarca"],
                            style: const TextStyle(fontSize: 22),
                          ),
                          IconButton(
                            icon: Icon(esFavorito ? Icons.star : Icons.star_border),
                            onPressed: () async {
                              await anyadirFavoritos();
                            },
                            tooltip: (esFavorito ? "Quitar de favoritos" : "Añadir a favoritos"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Capital: ${comarca["capital"]}",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          comarca["desc"],
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
  Widget _buildClimaPage() {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: WidgetClima(comarca: comarca),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(comarca["comarca"]),
        centerTitle: true,
      ),
      body: _currentIndex == 0 ? _buildInfoPage() : _buildClimaPage(),
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


}
