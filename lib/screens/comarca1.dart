import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../date/counties.dart';

class InfoComarca1Screen extends StatefulWidget {
  const InfoComarca1Screen({Key? key}) : super(key: key);

  @override
  State<InfoComarca1Screen> createState() => _InfoComarca1ScreenState();
}

class _InfoComarca1ScreenState extends State<InfoComarca1Screen> {
  final comarca = provincies["provincies"][0]["comarques"][0];

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
                      image: NetworkImage(comarca["img"]),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0), // Padding para toda la columna de textos
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
    );
  }
}
