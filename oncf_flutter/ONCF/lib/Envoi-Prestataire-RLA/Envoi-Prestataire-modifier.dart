import 'package:database/Envoi-Prestataire-RLA/Envoi-Prestataire-tableau.dart';
import 'package:database/Reception-Prestataire-RLA/Reception-Prestataire-tableau.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For restricting input types
import '../api/api_service.dart'; // Your ApiService for updating the data
import 'package:database/EnvoiRame/EnvoiRame-tableau.dart';
class Envoi_Prestataire_EditRowPage extends StatefulWidget {
  final Map<String, dynamic> rowData; // Row data to modify

  Envoi_Prestataire_EditRowPage({required this.rowData});

  @override
  _Envoi_Prestataire_EditRowPageState createState() => _Envoi_Prestataire_EditRowPageState();
}

class _Envoi_Prestataire_EditRowPageState extends State<Envoi_Prestataire_EditRowPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _indexController;
  late TextEditingController _code1568Controller;
  late TextEditingController _serieController;
  late TextEditingController _carteModuleController;
  late TextEditingController _partieController;
  late TextEditingController _designationController;
  late TextEditingController _referenceController;
  late TextEditingController _dateEnvoiController;
  late TextEditingController _numeroBLController;
  late TextEditingController _motifEnvoiController;
  late TextEditingController _prestataireRLAController;

  @override
  void initState() {
    super.initState();

    // Initialisation des contrôleurs avec les données actuelles de la ligne
    _indexController = TextEditingController(
        text: widget.rowData['index']?.toString() ?? 'N/A');
    _code1568Controller = TextEditingController(
        text: widget.rowData['code_1568'].toString());
    _serieController = TextEditingController(
        text: widget.rowData['Série'] ?? 'N/A');
    _carteModuleController = TextEditingController(
        text: widget.rowData['Carte_Module'] ?? 'N/A');
    _partieController = TextEditingController(
        text: widget.rowData['Partie'] ?? 'N/A');
    _designationController = TextEditingController(
        text: widget.rowData['Désignation'] ?? 'N/A');
    _referenceController = TextEditingController(
        text: widget.rowData['Référence'].toString());
    _dateEnvoiController = TextEditingController(
        text: widget.rowData['Date_envoi'].toString());
    _numeroBLController = TextEditingController(
        text: widget.rowData['Numéro_BL'].toString());
    _motifEnvoiController = TextEditingController(
        text: widget.rowData['Motif_envoi'] ?? 'N/A');
    _prestataireRLAController = TextEditingController(
        text: widget.rowData['Prestataire_RLA'] ?? 'N/A');
  }


  @override
  void dispose() {
    // Dispose des contrôleurs lorsque la page est détruite
    _indexController.dispose();
    _code1568Controller.dispose();
    _serieController.dispose();
    _carteModuleController.dispose();
    _partieController.dispose();
    _designationController.dispose();
    _referenceController.dispose();
    _dateEnvoiController.dispose();
    _numeroBLController.dispose();
    _motifEnvoiController.dispose();
    _prestataireRLAController.dispose();
    super.dispose();
  }

  Future<void> _onModify() async {
    if (_formKey.currentState!.validate()) {
      int indexInt = int.parse(_indexController.text);
      String indexString = indexInt
          .toString(); // Convertir de nouveau en chaîne de caractères pour l'API
      Map<String, dynamic> updatedRow = {
        'index':_indexController.text,
        'code_1568': _code1568Controller.text,
        'Serie': _serieController.text,
        'Carte_Module': _carteModuleController.text,
        'Partie': _partieController.text,
        'Designation': _designationController.text,
        'Reference': _referenceController.text,
        'Date_envoi': _dateEnvoiController.text,
        'Numero_BL': _numeroBLController.text,
        'Motif_envoi': _motifEnvoiController.text,
        'Prestataire_RLA': _prestataireRLAController.text,
      };



      try {
        // Utiliser l'entier pour l'index pour la mise à jour
        await ApiService().updateEnvoiPrestataireRla(indexInt, updatedRow);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ligne modifiée avec succès')),
        );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Envoi_PrestataireTable()));
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
                              controller: _code1568Controller,
                              decoration: InputDecoration(
                                labelText: 'Code 1568',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Ce champ est requis';
                                }
                                return null;
                              },
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
                              controller: _carteModuleController,
                              decoration: InputDecoration(
                                labelText: 'Carte Module',
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
                              keyboardType: TextInputType.text,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _dateEnvoiController,
                              decoration: InputDecoration(
                                labelText: 'Date d\'envoi',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.datetime,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _numeroBLController,
                              decoration: InputDecoration(
                                labelText: 'Numéro BL',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _motifEnvoiController,
                              decoration: InputDecoration(
                                labelText: 'Motif d\'envoi',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _prestataireRLAController,
                              decoration: InputDecoration(
                                labelText: 'Prestataire RLA',
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
