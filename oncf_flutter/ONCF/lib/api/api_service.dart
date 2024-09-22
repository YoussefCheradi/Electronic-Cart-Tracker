import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://localhost:8000/api/v1';

  Future<List<dynamic>> getExcelColumns(String sheetName) async {
    final response = await http.get(Uri.parse('$baseUrl/excel_columns?sheet_name=$sheetName'));

    if (response.statusCode == 200) {
      return json.decode(response.body)['columns'];
    } else {
      throw Exception('Erreur lors de la récupération des colonnes : ${response.body}');
    }
  }

  Future<List<dynamic>> getDbData(String sheetName) async {
    final response = await http.get(Uri.parse('$baseUrl/db_data?sheet_name=$sheetName'));

    if (response.statusCode == 200) {
      return json.decode(response.body)['db_data'];
    } else {
      throw Exception('Erreur lors de la récupération des données : ${response.body}');
    }
  }

  Future<void> deleteRow(String sheetName, int index) async {
    final response = await http.delete(Uri.parse('$baseUrl/db_data/$index?sheet_name=$sheetName'));

    if (response.statusCode != 200) {
      throw Exception('Erreur lors de la suppression de la ligne : ${response.body}');
    }
  }

  Future<List<String>> getExcelTables() async {
    final response = await http.get(Uri.parse('$baseUrl/excel_tables'));

    if (response.statusCode == 200) {
      return List<String>.from(json.decode(response.body)['tables']);
    } else {
      throw Exception('Erreur lors de la récupération des tables : ${response.body}');
    }
  }

  Future<void> addReceptionRame(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reception_rame'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Erreur lors de l\'ajout de la ligne dans Réception-Rame : ${response.body}');
    }
  }

  Future<void> updateReceptionRame(int index, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/reception_rame/$index'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Erreur lors de la mise à jour de la ligne dans Réception-Rame : ${response.body}');
    }
  }

  // Répéter les fonctions ci-dessus pour les autres endpoints
  // Exemple pour Envoi-Rame
  Future<void> addEnvoiRame(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/envoi_rame'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Erreur lors de l\'ajout de la ligne dans Envoi-Rame : ${response.body}');
    }
  }

  Future<void> updateEnvoiRame(int index, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/envoi_rame/$index'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Erreur lors de la mise à jour de la ligne dans Envoi-Rame : ${response.body}');
    }
  }

  Future<void> addReceptionPrestataireRla(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reception_prestataire_rla'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Erreur lors de l\'ajout de la ligne dans reception_prestataire_rla : ${response.body}');
    }
  }

  Future<void> updateReceptionPrestataireRla(int index, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/reception_prestataire_rla/$index'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Erreur lors de la mise à jour de la ligne dans reception_prestataire_rla : ${response.body}');
    }
  }

  Future<void> addEnvoiPrestataireRla(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/envoi_prestataire_rla'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Erreur lors de l\'ajout de la ligne dans envoi_prestataire_rla : ${response.body}');
    }
  }

  Future<void> updateEnvoiPrestataireRla(int index, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/envoi_prestataire_rla/$index'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Erreur lors de la mise à jour de la ligne dans envoi_prestataire_rla : ${response.body}');
    }
  }

  Future<void> addReparationModule(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reparation_module'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Erreur lors de l\'ajout de la ligne dans reparation_module : ${response.body}');
    }
  }

  Future<void> updateReparationModule(int index, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/reparation_module/$index'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Erreur lors de la mise à jour de la ligne dans reparation_module : ${response.body}');
    }
  }

  Future<void> addEssai(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/essai'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Erreur lors de l\'ajout de la ligne dans essai : ${response.body}');
    }
  }

  Future<void> updateEssai(int index, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/essai/$index'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Erreur lors de la mise à jour de la ligne dans essai : ${response.body}');
    }
  }

// Ajoutez les autres méthodes similaires pour tous les autres endpoints.
}
