import 'package:database/Envoi-Prestataire-RLA/Envoi-Prestataire-tableau.dart';
import 'package:database/Reception-Prestataire-RLA/Reception-Prestataire-tableau.dart';
import 'package:database/Reparation-Module/Reparation-Module-tableau.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For restricting input types
import '../api/api_service.dart'; // Your ApiService for updating the data
import 'package:database/EnvoiRame/EnvoiRame-tableau.dart';
class Reparation_Module_EditRowPage extends StatefulWidget {
  final Map<String, dynamic> rowData; // Row data to modify

  Reparation_Module_EditRowPage({required this.rowData});

  @override
  _Reparation_Module_EditRowPageState createState() => _Reparation_Module_EditRowPageState();
}

class _Reparation_Module_EditRowPageState extends State<Reparation_Module_EditRowPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _indexController;
  late TextEditingController _idController;
  late TextEditingController _serieController;
  late TextEditingController _partieController;
  late TextEditingController _designationController;
  late TextEditingController _referenceController;
  late TextEditingController _lieuDuDeposeController;
  late TextEditingController _dateDebutController;
  late TextEditingController _motifDeReparationController;
  late TextEditingController _rDiagnostiqueController;
  late TextEditingController _interventionController;
  late TextEditingController _reparateurController;
  late TextEditingController _dateFinController;
  late TextEditingController _emplacementController;
  late TextEditingController _nombreDeJourController;

  @override
  void initState() {
    super.initState();

    // Initialisation des contrôleurs avec les données actuelles de la ligne
    _indexController = TextEditingController(
        text: widget.rowData['index']?.toString() ?? 'N/A');
    _idController = TextEditingController(
        text: widget.rowData['ID']?.toString() ?? 'N/A');
    _serieController = TextEditingController(
        text: widget.rowData['Série'] ?? 'N/A');
    _partieController = TextEditingController(
        text: widget.rowData['Partie'] ?? 'N/A');
    _designationController = TextEditingController(
        text: widget.rowData['Désignation'] ?? 'N/A');
    _referenceController = TextEditingController(
        text: widget.rowData['Référence'] ?? 'N/A');
    _lieuDuDeposeController = TextEditingController(
        text: widget.rowData['Lieu_du_dépose'] ?? 'N/A');
    _dateDebutController = TextEditingController(
        text: widget.rowData['Date_début'] ?? 'N/A');
    _motifDeReparationController = TextEditingController(
        text: widget.rowData['Motif_de_réparation'] ?? 'N/A');
    _rDiagnostiqueController = TextEditingController(
        text: widget.rowData['R_Diagnostique'] ?? 'N/A');
    _interventionController = TextEditingController(
        text: widget.rowData['Intervention'] ?? 'N/A');
    _reparateurController = TextEditingController(
        text: widget.rowData['Réparateur'] ?? 'N/A');
    _dateFinController = TextEditingController(
        text: widget.rowData['Date_fin'] ?? 'N/A');
    _emplacementController = TextEditingController(
        text: widget.rowData['Emplacement'] ?? 'N/A');
    _nombreDeJourController = TextEditingController(
        text: widget.rowData['Nombre_de_Jour']?.toString() ?? 'N/A');
  }


  @override
  void dispose() {
    // Dispose des contrôleurs lorsque la page est détruite
    _indexController.dispose();
    _idController.dispose();
    _serieController.dispose();
    _partieController.dispose();
    _designationController.dispose();
    _referenceController.dispose();
    _lieuDuDeposeController.dispose();
    _dateDebutController.dispose();
    _motifDeReparationController.dispose();
    _rDiagnostiqueController.dispose();
    _interventionController.dispose();
    _reparateurController.dispose();
    _dateFinController.dispose();
    _emplacementController.dispose();
    _nombreDeJourController.dispose();
    super.dispose();
  }

  Future<void> _onModify() async {
    if (_formKey.currentState!.validate()) {
      int indexInt = int.parse(_indexController.text);
      String indexString = indexInt
          .toString(); // Convertir de nouveau en chaîne de caractères pour l'API
      Map<String, dynamic> updatedRow = {
        'index':_indexController.text,
        'ID': _idController.text,
        'Serie': _serieController.text,
        'Partie': _partieController.text,
        'Designation': _designationController.text,
        'Reference': _referenceController.text,
        'Lieu_du_depose': _lieuDuDeposeController.text,
        'Date_debut': _dateDebutController.text,
        'Motif_de_reparation': _motifDeReparationController.text,
        'R_Diagnostique': _rDiagnostiqueController.text,
        'Intervention': _interventionController.text,
        'Reparateur': _reparateurController.text,
        'Date_fin': _dateFinController.text,
        'Emplacement': _emplacementController.text,
        'Nombre_de_Jour': _nombreDeJourController.text,
      };




      try {
        // Utiliser l'entier pour l'index pour la mise à jour
        await ApiService().updateReparationModule(indexInt, updatedRow);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ligne modifiée avec succès')),
        );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Reparation_ModuleTable()));
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la modification: $error')),
        );
      }
    }
  }

  // Method to show confirmation dialog
  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Voulez-vous vraiment modifier cette ligne ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Confirmer'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _onModify(); // Proceed with modification
              },
            ),
          ],
        );
      },
    );
  }

  void _onCancel() {
    Navigator.pop(context); // Cancel and close the page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modifier la ligne'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'tsawer/image-removebg-preview.png',
                    width: 250, // Ajustez la largeur pour qu'elle ne dépasse pas
                    fit: BoxFit.cover, // Ajustez la façon dont l'image s'adapte
                  ),
                  SizedBox(height: 50),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _idController,
                              decoration: InputDecoration(
                                labelText: 'ID',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _serieController,
                              decoration: InputDecoration(
                                labelText: 'Série',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _partieController,
                              decoration: InputDecoration(
                                labelText: 'Partie',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _designationController,
                              decoration: InputDecoration(
                                labelText: 'Désignation',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _referenceController,
                              decoration: InputDecoration(
                                labelText: 'Référence',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _lieuDuDeposeController, // Nouveau contrôleur
                              decoration: InputDecoration(
                                labelText: 'Lieu du dépose',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _dateDebutController, // Nouveau contrôleur
                              decoration: InputDecoration(
                                labelText: 'Date début',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.datetime,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _motifDeReparationController, // Nouveau contrôleur
                              decoration: InputDecoration(
                                labelText: 'Motif de réparation',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _rDiagnostiqueController, // Nouveau contrôleur
                              decoration: InputDecoration(
                                labelText: 'R Diagnostique',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _interventionController, // Nouveau contrôleur
                              decoration: InputDecoration(
                                labelText: 'Intervention',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _reparateurController, // Nouveau contrôleur
                              decoration: InputDecoration(
                                labelText: 'Réparateur',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _dateFinController, // Nouveau contrôleur
                              decoration: InputDecoration(
                                labelText: 'Date fin',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.datetime,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _emplacementController, // Nouveau contrôleur
                              decoration: InputDecoration(
                                labelText: 'Emplacement',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _nombreDeJourController, // Nouveau contrôleur
                              decoration: InputDecoration(
                                labelText: 'Nombre de jour',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),


                  SizedBox(height: 42.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: Size(150, 50),
                        ),
                        child: Text(
                          'Annuler',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _showConfirmationDialog,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: Size(150, 50),
                        ),
                        child: Text(
                          'Modifier',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
