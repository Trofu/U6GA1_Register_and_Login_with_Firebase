import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:u3ga1/gps_utils.dart';

import '../date/counties.dart';
import '../widgets/widget_clima.dart';

class ComarcaInfo extends StatefulWidget {
  final int comarca;
  final int provincia;

  const ComarcaInfo({Key? key, required this.comarca, required this.provincia}) : super(key: key);

  @override
  State<ComarcaInfo> createState() => _ComarcaInfoState(comarca,provincia);
}

class _ComarcaInfoState extends State<ComarcaInfo> {

  int _currentIndex = 0;
  late final comarca;
  late final int provinciaId;
  late final int comarcaId;


  _ComarcaInfoState( this.comarcaId,this.provinciaId){
    comarca = provincies["provincies"][provinciaId]["comarques"][comarcaId];
  }

  late final List<Widget> _pages = [
    // Informacion Comarca
    Scaffold(
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
                  // Padding para toda la columna de textos
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          comarca["comarca"],
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 22),
                        ),
                      ),
                      const SizedBox(height: 8.0), // Espaciado entre textos
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Capital: " + comarca["capital"],
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          comarca["desc"],
                          textAlign: TextAlign.left,
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
    ),
    // Informacion Tiempo de la comarca
    Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(children: [
                              WidgetClima(
                                comarca: comarca,
                              )
                            ]),
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
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(comarca["comarca"]),
        centerTitle: true,
      ),
      body: _pages[_currentIndex],
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
