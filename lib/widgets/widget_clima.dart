import 'package:flutter/material.dart';
import '../config/peticions_http.dart';

class WidgetClima extends StatefulWidget {
   final comarca;

  const WidgetClima({
    this.comarca,
    super.key,
  }); // Afegim latitud i longitud al constructor

// Definim les propietat com a final, per a que el constructor puga ser constant

  @override
  State<WidgetClima> createState() => _WidgetClimaState(comarca);
}

class _WidgetClimaState extends State<WidgetClima> {

  late Future<dynamic> info;
  final comarca;

  _WidgetClimaState(this.comarca);

  @override
  void initState() {
    super.initState();
    info = obteClima(
        longitud: comarca["longitud"] ?? 0.0,
        latitud: comarca["latitud"] ?? 0.0
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: info,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          // Una vegada es resol el Future, tindrem disponible
          // la informació necessària per construir el giny
          String temperatura =
              snapshot.data["current_weather"]["temperature"].toString();
          String velVent =
              snapshot.data["current_weather"]["windspeed"].toString();
          String direccioVent =
              snapshot.data["current_weather"]["winddirection"].toString();
          String codi =
              snapshot.data["current_weather"]["weathercode"].toString();
          return Column(
            children: [
              _obtenirIconaOratge(codi),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.thermostat,
                    size: 35,
                  ),
                  Text(
                    "$temperaturaº",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wind_power, size: 35),
                  const SizedBox(width: 30),
                  Text(
                    "${velVent}km/h",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(width: 30),
                  _obteGinyDireccioVent(double.parse(direccioVent)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                      "Població: "
                  ),
                  const SizedBox(width: 30),
                  Text(
                      comarca["poblacio"]
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                      "Longitud: "
                  ),
                  const SizedBox(width: 30),
                  Text(
                      comarca["longitud"].toString()
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                      "Latitud: "
                  ),
                  const SizedBox(width: 30),
                  Text(
                      comarca["latitud"].toString()
                  ),
                ],
              ),
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget _obteGinyDireccioVent(double direccioVent) {
    // Aquesta funció ens retorna una giny que conté
    // una icona i un text, amb la direcció i el nom del vent
    // segons la seua direcció.
    // Fem ús de `late` per indicar que assignarem el valor després
    // a les variables.

    late Icon icona;
    late String nomVent;

    if (direccioVent > 22.5 && direccioVent < 65.5) {
      icona = const Icon(Icons.north_east);
      nomVent = "Gregal";
    } else if (direccioVent > 67.5 && direccioVent < 112.5) {
      icona = const Icon(Icons.east);
      nomVent = "Llevant";
    } else if (direccioVent > 112.5 && direccioVent < 157.5) {
      icona = const Icon(Icons.south_east);
      nomVent = "Xaloc";
    } else if (direccioVent > 157.5 && direccioVent < 202.5) {
      icona = const Icon(Icons.south);
      nomVent = "Migjorn";
    } else if (direccioVent > 202.5 && direccioVent < 247.5) {
      icona = const Icon(Icons.south_west);
      nomVent = "Llebeig/Garbí";
    } else if (direccioVent > 247.5 && direccioVent < 292.5) {
      icona = const Icon(Icons.west);
      nomVent = "Ponent";
    } else if (direccioVent > 292.5 && direccioVent < 337.5) {
      icona = const Icon(Icons.north_west);
      nomVent = "Mestral";
    } else {
      icona = const Icon(Icons.north);
      nomVent = "Tramuntana";
    }
    return Row(children: [
      Text(
        nomVent,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      icona,
    ]);
  }

  Widget _obtenirIconaOratge(String value) {
    /*
    
    Aquesta funció obté un giny amb una imatge que es 
    correspon al codi de l'oratge (Assolellat, núvo, etc.)

    Existeix una gran quantitat de codis per a l'oratge, que podem 
    consultar a la web d'OpenMeteo:https://open-meteo.com/en/docs/dwd-api#weathervariables,
    a l'apartat "WMO Weather interpretation codes (WW)"

     */
    Set<String> sol = <String>{"0"};
    Set<String> pocsNuvols = <String>{"1", "2", "3"};
    Set<String> nuvols = <String>{"45", "48"};
    Set<String> plujasuau = <String>{"51", "53", "55"};
    Set<String> pluja = <String>{
      "61",
      "63",
      "65",
      "66",
      "67",
      "80",
      "81",
      "82",
      "95",
      "96",
      "99"
    };
    Set<String> neu = <String>{"71", "73", "75", "77", "85", "86"};

    if (sol.contains(value)) {
      return Image.asset("assets/icons/png/soleado.png");
    }
    if (pocsNuvols.contains(value)) {
      return Image.asset("assets/icons/png/poco_nublado.png");
    }
    if (nuvols.contains(value)) {
      return Image.asset("assets/icons/png/nublado.png");
    }
    if (plujasuau.contains(value)) {
      return Image.asset("assets/icons/png/lluvia_debil.png");
    }
    if (pluja.contains(value)) {
      return Image.asset("assets/icons/png/lluvia.png");
    }
    if (neu.contains(value)) {
      return Image.asset("assets/icons/png/nieve.png");
    }

    return Image.asset("assets/icons/png/poco_nublado.png");
  }
}
