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
  String id = FirebaseAuth.instance.currentUser?.uid ?? "";
  if (id.isEmpty) return [];

  DatabaseReference ref = FirebaseDatabase.instance.ref("usuarios/$id/favoritos");
  final snapshot = await ref.get();

  if (!snapshot.exists || snapshot.value == null) {
    return [];
  }

  // Convertir snapshot a Map si es posible
  if (snapshot.value is! Map<dynamic, dynamic>) {
    return [];
  }

  Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
  List<Map<String, dynamic>> favoritos = [];

  // Filtrar y convertir datos
  for (var value in data.values) {
    if (value is Map<dynamic, dynamic>) {
      Map<String, dynamic> item = Map<String, dynamic>.from(value);
      if (item["favorito"] == true) {
        favoritos.add(item);
      }
    }
  }

  if (favoritos.isEmpty) return [];

  List<dynamic> listaFavoritos = [];

  for (var element in favoritos) {
    String? comarca = element["comarca"];
    if (comarca != null) {
      String url = "https://node-comarques-rest-server-production.up.railway.app/api/comarques/infoComarca/$comarca";

      try {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == HttpStatus.ok) {
          String body = utf8.decode(response.bodyBytes);
          final result = jsonDecode(body);
          listaFavoritos.add(result);
        } else {
          print("Error al obtener datos de la API para $comarca - Código: ${response.statusCode}");
        }
      } catch (e) {
        print("Error al conectar con la API: $e");
      }
    }
  }

  return listaFavoritos;
}



