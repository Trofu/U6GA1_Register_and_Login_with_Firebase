import 'dart:convert'; // Per realitzar conversions entre tipus de dades
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http; // Per realitzar peticions HTTP

Future<dynamic> obteClima(
    {required double longitud, required double latitud}) async {
  String url =
      'https://api.open-meteo.com/v1/forecast?latitude=$latitud&longitude=$longitud&current_weather=true';

  // Llancem una petició GET mitjançant el mètode http.get, i ens esperem a la resposta
  http.Response response = await http.get(Uri.parse(url));

  if (response.statusCode == HttpStatus.ok) {
    // Descodifiquem la resposta
    String body = utf8.decode(response.bodyBytes);
    final result = jsonDecode(body);
    // I la tornem
    return result;
  } else {
    // Si no carrega, llancem una excepció
    throw Exception('No s\'ha pogut connectar');
  }
}

Future<dynamic> obtenirComarques({required String provincia}) async{
  String url = "https://node-comarques-rest-server-production.up.railway.app/api/comarques/$provincia";
  http.Response response = await http.get(Uri.parse(url));
  if(response.statusCode == HttpStatus.ok){
    String body = utf8.decode(response.bodyBytes);
    final result = jsonDecode(body);
    return result;
  }else{
    throw Exception('No s\'ha pogut connectar');
  }
}

Future<dynamic> obtenirProvincies() async{
  String url = "https://node-comarques-rest-server-production.up.railway.app/api/comarques";
  http.Response response = await http.get(Uri.parse(url));
  if(response.statusCode == HttpStatus.ok){
    String body = utf8.decode(response.bodyBytes);
    final result = jsonDecode(body);
    return result;
  }else{
    throw Exception('No s\'ha pogut connectar');
  }
}

Future<dynamic> obtenirComarquesAmbImatge({required String provincia}) async{
  String url = "https://node-comarques-rest-server-production.up.railway.app/api/comarques/comarquesAmbImatge/$provincia";
  http.Response response = await http.get(Uri.parse(url));
  if(response.statusCode == HttpStatus.ok){
    String body = utf8.decode(response.bodyBytes);
    final result = jsonDecode(body);
    return result;
  }else{
    throw Exception('No s\'ha pogut connectar');
  }
}

Future<dynamic> obtenirInfoComarca({required String comarca}) async{
  String url = "https://node-comarques-rest-server-production.up.railway.app/api/comarques/infoComarca/$comarca";
  http.Response response = await http.get(Uri.parse(url));
  if(response.statusCode == HttpStatus.ok){
    String body = utf8.decode(response.bodyBytes);
    final result = jsonDecode(body);
    return result;
  }else{
    throw Exception('No s\'ha pogut connectar');
  }
}

Future<List<dynamic>> obtenirFavoritos() async {
  var id = FirebaseAuth.instance.currentUser?.uid ?? "";
  DatabaseReference ref = FirebaseDatabase.instance.ref("usuarios/$id/favoritos");

  final snapshot = await ref.get();
  if (!snapshot.exists) {
    return [];
  }

  List<Map<String, dynamic>> favoritos = [];
  Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
  data.forEach((key, value) {
    favoritos.add(Map<String, dynamic>.from(value));
  });

  List<Map<String, dynamic>> sifavoritos = favoritos.where((element) => element["favorito"] == true).toList();

  if (sifavoritos.isEmpty) {
    return [];
  }

  List<dynamic> listaFavoritos = [];

  for (var element in sifavoritos) {
    String? comarca = element["comarca"];

    if (comarca != null) {
      String url = "https://node-comarques-rest-server-production.up.railway.app/api/comarques/infoComarca/$comarca";

      try {
        http.Response response = await http.get(Uri.parse(url));

        if (response.statusCode == HttpStatus.ok) {
          String body = utf8.decode(response.bodyBytes);
          final result = jsonDecode(body);
          listaFavoritos.add(result);
        } else {
          print("Error al obtener datos de la API para $comarca");
        }
      } catch (e) {
        print("Error al conectar con la API: $e");
      }
    }
  }

  return listaFavoritos;
}



