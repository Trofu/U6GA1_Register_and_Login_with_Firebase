import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../date/counties.dart';

class InfoComarca2Screen extends StatefulWidget{

  const InfoComarca2Screen({Key?key}): super(key: key);

  @override
  State<InfoComarca2Screen> createState() => _InfoComarca2ScreenState();
}

class _InfoComarca2ScreenState extends State<InfoComarca2Screen> {

  final comarca= provincies["provincies"][0]["comarques"][0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(comarca["comarca"]),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/icons/cloudy.png"),
                          fit: BoxFit.contain
                      )
                  ),
                ),
                Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          width: 20,
                          image: AssetImage("assets/icons/termometro.png"),
                        ),
                        Text("5.4º"),
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          width: 20,
                          image: AssetImage("assets/icons/veleta-de-viento.png"),
                        ),
                        SizedBox(width: 8), // Espacio entre la imagen y el texto
                        Text("9.4km/h"),
                        SizedBox(width: 8), // Espacio entre el texto y el siguiente texto
                        Text("Ponent"),
                        SizedBox(width: 8), // Espacio entre el texto y la imagen
                        Image(
                          width: 20,
                          image: AssetImage("assets/icons/atras.png"),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        // Primera columna con texto alineado a la izquierda y padding
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0), // Espaciado horizontal
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start, // Alinea el contenido de la columna a la izquierda
                              children: [
                                Text("Població:", textAlign: TextAlign.left),
                                Text("Latitud:", textAlign: TextAlign.left),
                                Text("Longitud:", textAlign: TextAlign.left),
                              ],
                            ),
                          ),
                        ),
                        // Segunda columna con los valores de la comarca y padding
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0), // Espaciado horizontal
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start, // Alinea el contenido de la columna a la izquierda
                              children: [
                                Text(comarca["poblacio"].toString(), textAlign: TextAlign.left),
                                Text(comarca["coordenades"][0].toString(), textAlign: TextAlign.left),
                                Text(comarca["coordenades"][1].toString(), textAlign: TextAlign.left),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )

              ],
            ),
          ],
        )
      ),
    );
  }
}