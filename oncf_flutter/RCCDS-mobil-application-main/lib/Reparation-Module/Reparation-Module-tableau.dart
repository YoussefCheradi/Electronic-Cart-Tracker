import 'dart:developer';
import 'package:database/EnvoiRame/EnvoiRame-ajouter.dart';
import 'package:database/Reception-Prestataire-RLA/Reception-Prestataire-ajouter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../api/api_model.dart';
import '../login.dart';
import '../main.dart';
import 'package:database/Envoi-Prestataire-RLA/Envoi-Prestataire-tableau.dart';
import 'package:database/Essai/Essai-tableau.dart';
import 'package:database/Reparation-Module/Reparation-Module-ajouter.dart';
import 'package:database/Envoi-Prestataire-RLA/Envoi-Prestataire-ajouter.dart';
import 'package:database/Reception-Prestataire-RLA/Reception-Prestataire-tableau.dart';
import 'package:database/EnvoiRame/EnvoiRame-tableau.dart';
import 'Reparation-Module-modifier.dart';
import 'package:database/ReceptionRame/ReceptionRame_tableaux.dart';
class Reparation_ModuleTable extends StatefulWidget {
  @override
  _Reparation_ModuleTableState createState() => _Reparation_ModuleTableState();
}

class _Reparation_ModuleTableState extends State<Reparation_ModuleTable> {
  bool _isLoading = true;
  List<Map<String, dynamic>> _data = [];
  late final ApiService _apiService;
  List<Map<String, dynamic>> _filteredData = []; // Liste filtrée
  String _searchText = ''; // Texte de recherche


  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<dynamic> dbData = await _apiService.getDbData('Réparation-Module');
      List<Map<String, dynamic>> selectedColumns = dbData.map((e) => {
        'index': e['index']?.toString() ?? 'N/A',
        'ID': e['ID']?.toString() ?? 'N/A',                          // Correspond à 'id'
        'Série': e['Serie'] ?? 'N/A',                               // Correspond à 'serie'
        'Partie': e['Partie'] ?? 'N/A',                             // Correspond à 'partie'
        'Désignation': e['Designation'] ?? 'N/A',                   // Correspond à 'designation'
        'Référence': e['Reference'] ?? 'N/A',                       // Correspond à 'reference'
        'Lieu_du_dépose': e['Lieu_du_depose'] ?? 'N/A',             // Correspond à 'lieuDuDepose'
        'Date_début': e['Date_debut']??'N/A',                     // Correspond à 'dateDebut'
        'Motif_de_réparation': e['Motif_de_reparation'] ?? 'N/A',   // Correspond à 'motifDeReparation'
        'R_Diagnostique': e['R_Diagnostique'] ?? 'N/A',            // Correspond à 'rDiagnostique'
        'Intervention': e['Intervention'] ?? 'N/A',                 // Correspond à 'intervention'
        'Réparateur': e['Reparateur'] ?? 'N/A',                     // Correspond à 'reparateur'
        'Date_fin': e['Date_fin'] ?? 'N/A',                         // Correspond à 'dateFin'
        'Emplacement': e['Emplacement'] ?? 'N/A',                   // Correspond à 'emplacement'
        'Nombre_de_Jour': e['Nombre_de_Jour']?.toString() ?? 'N/A',            // Correspond à 'nombreDeJour'
        'rowData': e,                                               // L'objet complet pour les actions futures
      }).toList();


      setState(() {
        _data = selectedColumns;
        _filteredData = _data;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors du chargement des données.')),
      );
    }
  }


  // Fonction pour supprimer une ligne
  Future<void> _deleteRow(String sheetName, int index) async {
    try {
      await _apiService.deleteRow(sheetName, index);
      setState(() {
        _data.removeAt(index); // Supprimez la ligne de l'interface après la suppression
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ligne supprimée avec succès.')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la suppression de la ligne.')),
      );
    }
  }

  void _confirmDelete(String sheetName, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmer la suppression'),
          content: Text('Voulez-vous vraiment supprimer cet élément ?'),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la pop-up sans supprimer
              },
            ),
            TextButton(
              child: Text('Supprimer'),
              onPressed: () {
                Navigator.of(context).pop(); // Fermer la pop-up
                _deleteRow(sheetName, index); // Supprimer la ligne
              },
            ),
          ],
        );
      },
    );
  }

  void _filterData(String query) {
    setState(() {
      _filteredData = _data.where((row) {
        return row.values.any((value) =>
            value.toString().toLowerCase().contains(query.toLowerCase()));
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tableau de Réparation Module'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu), // Icône de menu (hamburger)
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Ouvrir le Drawer
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                    ),
                  ),
                )
            ),
            ListTile(
              leading: Icon(Icons.table_chart),
              title: Text('Réception Rame'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReceptionRameTable(), // Pass the row data
                  ),
                );
              },
            ),
            ListTile(
                leading: Icon(Icons.table_chart),
                title: Text('Envoi Rame'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EnvoiRameTable(), // Pass the row data
                    ),
                  );
                }
            ),
            ListTile(
              leading: Icon(Icons.table_chart),
              title: Text('Réception Prestataire RLA'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Reception_PrestataireTable(), // Pass the row data
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.table_chart),
              title: Text('Envoi Prestataire RLA'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Envoi_PrestataireTable(), // Pass the row data
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.table_chart),
              title: Text('Réparation Module'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Reparation_ModuleTable(), // Pass the row data
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.table_chart),
              title: Text('Essai'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Essai_Table(), // Pass the row data
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text('Déconnexion'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => login(), // Pass the row data
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'tsawer/image-removebg-preview.png',
              width: 200, // Ajustez la largeur pour qu'elle ne dépasse pas
              fit: BoxFit.cover, // Ajustez la façon dont l'image s'adapte
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 300), // Ajouter un peu d'espacement vertical
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double screenWidth = MediaQuery.of(context).size.width;
                      double textFieldWidth = screenWidth * 0.2; // Ajuster la largeur en fonction de l'écran

                      return Row(
                        children: [
                          Center(
                            child: Container(
                              width: textFieldWidth, // Appliquer la largeur calculée ici
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Rechercher',
                                  prefixIcon: Icon(Icons.search),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                onChanged: (value) {
                                  _searchText = value;
                                  _filterData(_searchText);
                                },
                              ),
                            ),
                          ),
                        ],
                      );

                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(right: 90,left: 60),
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      headingRowColor: MaterialStateProperty.all<Color>(Colors.grey[300]!),
                      dataRowHeight: 40,
                      columnSpacing: 15,
                      headingTextStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      columns: [
                        DataColumn(label: Text('ID', style: TextStyle(fontSize: 12))),                // Correspond à 'id'
                        DataColumn(label: Text('Série', style: TextStyle(fontSize: 12))),            // Correspond à 'serie'
                        DataColumn(label: Text('Partie', style: TextStyle(fontSize: 12))),            // Correspond à 'partie'
                        DataColumn(label: Text('Désignation', style: TextStyle(fontSize: 12))),      // Correspond à 'designation'
                        DataColumn(label: Text('Référence', style: TextStyle(fontSize: 12))),        // Correspond à 'reference'
                        DataColumn(label: Text('Lieu du Dépose', style: TextStyle(fontSize: 12))),    // Correspond à 'lieuDuDepose'
                        DataColumn(label: Text('Date Début', style: TextStyle(fontSize: 12))),        // Correspond à 'dateDebut'
                        DataColumn(label: Text('Motif de Réparation', style: TextStyle(fontSize: 12))),// Correspond à 'motifDeReparation'
                        DataColumn(label: Text('R Diagnostic', style: TextStyle(fontSize: 12))),      // Correspond à 'rDiagnostique'
                        DataColumn(label: Text('Intervention', style: TextStyle(fontSize: 12))),      // Correspond à 'intervention'
                        DataColumn(label: Text('Réparateur', style: TextStyle(fontSize: 12))),        // Correspond à 'reparateur'
                        DataColumn(label: Text('Date Fin', style: TextStyle(fontSize: 12))),          // Correspond à 'dateFin'
                        DataColumn(label: Text('Emplacement', style: TextStyle(fontSize: 12))),       // Correspond à 'emplacement'
                        DataColumn(label: Text('Nombre de Jours', style: TextStyle(fontSize: 12))),   // Correspond à 'nombreDeJour'
                        DataColumn(label: Text('Actions', style: TextStyle(fontSize: 12))),           // Colonne des actions (restée inchangée)
                      ],


                      rows: List<DataRow>.generate(
                        _filteredData.length,
                            (index) => DataRow(
                              cells: [
                                DataCell(Text(_filteredData[index]['ID']?.toString() ?? 'N/A')),                // Correspond à 'ID'
                                DataCell(Text(_filteredData[index]['Série'] ?? 'N/A')),                        // Correspond à 'serie'
                                DataCell(Text(_filteredData[index]['Partie'] ?? 'N/A')),                        // Correspond à 'partie'
                                DataCell(Text(_filteredData[index]['Désignation'] ?? 'N/A')),                  // Correspond à 'designation'
                                DataCell(Text(_filteredData[index]['Référence'] ?? 'N/A')),                    // Correspond à 'reference'
                                DataCell(Text(_filteredData[index]['Lieu_du_dépose'] ?? 'N/A')),                // Correspond à 'lieuDuDepose'
                                DataCell(Text(_filteredData[index]['Date_début']?.toString() ?? 'N/A')),                   // Correspond à 'dateDebut'
                                DataCell(Text(_filteredData[index]['Motif_de_réparation'] ?? 'N/A')),           // Correspond à 'motifDeReparation'
                                DataCell(Text(_filteredData[index]['R_Diagnostique'] ?? 'N/A')),               // Correspond à 'rDiagnostique'
                                DataCell(Text(_filteredData[index]['Intervention'] ?? 'N/A')),                 // Correspond à 'intervention'
                                DataCell(Text(_filteredData[index]['Réparateur'] ?? 'N/A')),                   // Correspond à 'reparateur'
                                DataCell(Text(_filteredData[index]['Date_fin'] ?? 'N/A')),                     // Correspond à 'dateFin'
                                DataCell(Text(_filteredData[index]['Emplacement'] ?? 'N/A')),                  // Correspond à 'emplacement'
                                DataCell(Text(_filteredData[index]['Nombre_de_Jour']?.toString() ?? 'N/A')),             // Correspond à 'nombreDeJour'
                                DataCell(Row(
                                children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Reparation_Module_EditRowPage(rowData: _filteredData[index]),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    _confirmDelete('Réparation-Module', index);
                                  },
                                ),
                              ],
                            )),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Reparation_Module_AddRowPage()),
          );
        },
        backgroundColor: Colors.orange, // Optionnel, pour définir la couleur de fond
        child: Icon(
          Icons.add,
          color: Colors.black, // Définir la couleur de l'icône en orange
        ),
      ),
    );
  }
}
