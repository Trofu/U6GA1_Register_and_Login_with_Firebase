import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../date/counties.dart';

class ProvinciasScreen extends StatefulWidget{

  const ProvinciasScreen({Key?key}): super(key: key);

  @override
  State<ProvinciasScreen> createState() => _ProvinciasScreenState();
}

class _ProvinciasScreenState extends State<ProvinciasScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: [
            Center(
              child: Column(
                children: [
                  ClipOval(
                    child: Container(
                      height: 200, // Ajusta la altura para definir la elipse
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(provincies["provincies"][2]["img"]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          provincies["provincies"][2]["provincia"],
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  ClipOval(
                    child: Container(
                      height: 200, // Ajusta la altura para definir la elipse
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(provincies["provincies"][0]["img"]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          provincies["provincies"][0]["provincia"],
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  ClipOval(
                    child: Container(
                      height: 200, // Ajusta la altura para definir la elipse
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(provincies["provincies"][1]["img"]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          provincies["provincies"][1]["provincia"],
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}