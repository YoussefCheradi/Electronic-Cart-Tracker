import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For restricting input types
import '../api/api_service.dart'; // Your ApiService for updating the data
import 'package:database/EnvoiRame/EnvoiRame-tableau.dart';
class EnvoiRame_EditRowPage extends StatefulWidget {
  final Map<String, dynamic> rowData; // Row data to modify

  EnvoiRame_EditRowPage({required this.rowData});

  @override
  _EnvoiRame_EditRowPageState createState() => _EnvoiRame_EditRowPageState();
}

class _EnvoiRame_EditRowPageState extends State<EnvoiRame_EditRowPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _indexController;
  late TextEditingController _code234Controller;
  late TextEditingController _serieController;
  late TextEditingController _carteModuleController;
  late TextEditingController _partieController;
  late TextEditingController _designationController;
  late TextEditingController _referenceController;
  late TextEditingController _dateEnvoiController;
  late TextEditingController _rameDuPoseController;
  late TextEditingController _voitureController;
  late TextEditingController _organeController;

  @override
  void initState() {
    super.initState();

    // Initialisation des contrôleurs avec les données actuelles de la ligne
    _indexController = TextEditingController(
        text: widget.rowData['index']?.toString() ?? 'N/A');
    _code234Controller =
        TextEditingController(text: widget.rowData['code_234'].toString());
    _serieController = TextEditingController(text: widget.rowData['Série']);
    _carteModuleController =
        TextEditingController(text: widget.rowData['Carte_Module']);
    _partieController = TextEditingController(text: widget.rowData['Partie']);
    _designationController =
        TextEditingController(text: widget.rowData['Désignation']);
    _referenceController =
        TextEditingController(text: widget.rowData['Référence'].toString());
    _dateEnvoiController =
        TextEditingController(text: widget.rowData['Date_envoi'].toString());
    _rameDuPoseController =
        TextEditingController(text: widget.rowData['Rame_du_pose'].toString());
    _voitureController = TextEditingController(text: widget.rowData['Voiture']);
    _organeController = TextEditingController(text: widget.rowData['Organe']);
  }

  @override
  void dispose() {
    // Dispose des contrôleurs lorsque la page est détruite
    _indexController.dispose();
    _code234Controller.dispose();
    _serieController.dispose();
    _carteModuleController.dispose();
    _partieController.dispose();
    _designationController.dispose();
    _referenceController.dispose();
    _dateEnvoiController.dispose();
    _rameDuPoseController.dispose();
    _voitureController.dispose();
    _organeController.dispose();
    super.dispose();
  }

  Future<void> _onModify() async {
    if (_formKey.currentState!.validate()) {
      int indexInt = int.parse(_indexController.text);
      String indexString = indexInt
          .toString(); // Convertir de nouveau en chaîne de caractères pour l'API
      Map<String, dynamic> updatedRow = {
        'index':_indexController.text,
        'code_234': _code234Controller.text,
        'Serie': _serieController.text,
        'Carte_Module': _carteModuleController.text,
        'Partie': _partieController.text,
        'Designation': _designationController.text,
        'Reference': _referenceController.text,
        'Date_envoi': _dateEnvoiController.text,
        'Rame_du_pose': _rameDuPoseController.text,
        'Voiture': _voitureController.text,
        'Organe': _organeController.text,
      };

      try {
        // Utiliser l'entier pour l'index pour la mise à jour
        await ApiService().updateEnvoiRame(indexInt, updatedRow);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ligne modifiée avec succès')),
        );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EnvoiRameTable()));
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
                              controller: _code234Controller,
                              decoration: InputDecoration(
                                labelText: 'Code 234',
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
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
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
                              controller: _dateEnvoiController,
                              decoration: InputDecoration(
                                labelText: 'Date d\'envoi',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _rameDuPoseController,
                              decoration: InputDecoration(
                                labelText: 'Rame du pose',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _voitureController,
                              decoration: InputDecoration(
                                labelText: 'Voiture',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _organeController,
                              decoration: InputDecoration(
                                labelText: 'Organe',
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
