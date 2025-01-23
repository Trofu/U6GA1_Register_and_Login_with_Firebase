import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut(); // Cerrar sesión con Firebase
      context.go('/'); // Redirigir al login
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cerrar sesión: ${e.toString()}')),
      );
    }
  }

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
        title: const Text("Provincias"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Ícono de flecha
          onPressed: () async {
            // Confirmar antes de cerrar sesión
            final confirmLogout = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Cerrar sesión"),
                content: const Text("¿Estás seguro de que deseas cerrar sesión?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false), // Cancelar
                    child: const Text("Cancelar"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true), // Confirmar
                    child: const Text("Cerrar sesión"),
                  ),
                ],
              ),
            );

            if (confirmLogout == true) {
              await FirebaseAuth.instance.signOut(); // Cerrar sesión
              context.go('/'); // Redirigir al login
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () async {
              await FirebaseAuth.instance.signOut(); // Opción adicional de logout
              context.go('/'); // Redirigir al login
            },
            tooltip: 'Cerrar sesión',
          ),
        ],
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
