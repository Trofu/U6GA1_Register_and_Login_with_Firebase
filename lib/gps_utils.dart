import 'package:geolocator/geolocator.dart';

/* Aquesta funció obté de forma asíncrona la posició actual del dispositius */

Future<Position?> determinaPosicio() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Comprovem que el servei estiga en funcionament
  serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    // Si el servei de geolocalització no és actiu,
    // informem a l'usuari
    return Future.error('El servei de geolocalització està desactivat');
  }

  // En cas que el servei estiga en funcionament, comprovem els permisos:
  permission = await Geolocator.checkPermission();
  // Si no tenim permisos...
  if (permission == LocationPermission.denied) {
    // Demanem permís a l'usuari (observeu que fem ús de l'await
    // per esperar-nos que l'usuari coindidisca explícitament el permís)

    permission = await Geolocator.requestPermission();

    // Si l'usuari no ha coincidit el permís...
    if (permission == LocationPermission.denied) {
      // S'informa a l'usuari de que no hi ha permisos per obtenir la ubicació
      // La propera vegada es tornaran a preguntar
      return Future.error(
          'No es disposa de permisos per accedir a la ubicació');
    }
  }

  // Si els permisos estan denegats de forma permanent, llancem altre avís
  if (permission == LocationPermission.deniedForever) {
    return Future.error('''L'accés a la ubicació del dispositiu per part de 
l'aplicació està denegat de manera persistent.\n Si desitgeu modificar 
el permís, podeu fer-ho des de la configuració de l'aplicació''');
  }

  // Finalment, si tenim accés a la geolocalització, retornem aquesta:

  // Accés a la posició actual
  return await Geolocator.getCurrentPosition();

  // Accés a l'última posició coneguda
  // Recomanat per a Chrome
  // return await Geolocator.getLastKnownPosition();
}
