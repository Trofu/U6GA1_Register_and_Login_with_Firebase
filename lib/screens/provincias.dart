import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../date/counties.dart';

class ProvinciasScreen extends StatefulWidget {
  const ProvinciasScreen({Key? key}) : super(key: key);

  @override
  State<ProvinciasScreen> createState() => _ProvinciasScreenState();
}

class _ProvinciasScreenState extends State<ProvinciasScreen> {
  // Método para construir cada provincia como un widget
  Widget buildProvincias(Map<String, dynamic> provincia,int indice) {
    return Column(
      children: [
        ClipOval(
          child: Container(
            height: 175, // Altura para definir la elipse
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(provincia["img"]),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: TextButton(
                onPressed: () {
                  String ruta = "/provincias/$indice/comarcas";
                  context.push(ruta);
                },
                child: Text(
                  provincia["provincia"],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Colors.black, // Sombra negra para el texto
                        blurRadius: 4, // Difuminado de la sombra del texto
                        offset: Offset(2, 3), // Desplazamiento de la sombra del texto
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ),
          ),
        ),
        const SizedBox(height: 20.0), // Espaciado entre elementos
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: const Text(
         "Provincias"
       ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          itemCount: provincies["provincies"].length, // Iteramos sobre las provincias
          itemBuilder: (context, index) {
            final provincia = provincies["provincies"][index];
            return buildProvincias(provincia,index);
          },
        ),
      ),
    );
  }
}
