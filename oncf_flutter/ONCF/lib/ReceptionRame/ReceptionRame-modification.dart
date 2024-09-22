import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For restricting input types
import '../api/api_service.dart'; // Your ApiService for updating the data
import 'ReceptionRame_tableaux.dart';

class ReceptionRame_EditRowPage extends StatefulWidget {
  final Map<String, dynamic> rowData; // Row data to modify

  ReceptionRame_EditRowPage({required this.rowData});

  @override
  _ReceptionRame_EditRowPageState createState() => _ReceptionRame_EditRowPageState();
}

class _ReceptionRame_EditRowPageState extends State<ReceptionRame_EditRowPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _indexController;
  late TextEditingController _code215Controller;
  late TextEditingController _serieController;
  late TextEditingController _carteModuleController;
  late TextEditingController _partieController;
  late TextEditingController _designationController;
  late TextEditingController _referenceController;
  late TextEditingController _dateEntreeController;
  late TextEditingController _rameDePoseController;
  late TextEditingController _voitureController;
  late TextEditingController _motifDePoseController;
  late TextEditingController _emplacementActuelController;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with the current row data
    _indexController = TextEditingController(
        text: widget.rowData['index']?.toString() ?? 'N/A');
    _code215Controller =
        TextEditingController(text: widget.rowData['code_215'].toString());
    _serieController = TextEditingController(text: widget.rowData['Série']);
    _carteModuleController =
        TextEditingController(text: widget.rowData['Carte_Module']);
    _partieController = TextEditingController(text: widget.rowData['Partie']);
    _designationController =
        TextEditingController(text: widget.rowData['Désignation']);
    _referenceController =
        TextEditingController(text: widget.rowData['Référence'].toString());
    _dateEntreeController =
        TextEditingController(text: widget.rowData['Date_entrée'].toString());
    _rameDePoseController = TextEditingController(
        text: widget.rowData['Rame_du_dépose'].toString());
    _voitureController = TextEditingController(text: widget.rowData['Voiture']);
    _motifDePoseController =
        TextEditingController(text: widget.rowData['Motif_du_dépose']);
    _emplacementActuelController =
        TextEditingController(text: widget.rowData['Emplacement_actuel']);
  }

  @override
  void dispose() {
    // Dispose controllers when the page is destroyed
    _indexController.dispose();
    _code215Controller.dispose();
    _serieController.dispose();
    _carteModuleController.dispose();
    _partieController.dispose();
    _designationController.dispose();
    _referenceController.dispose();
    _dateEntreeController.dispose();
    _rameDePoseController.dispose();
    _voitureController.dispose();
    _motifDePoseController.dispose();
    _emplacementActuelController.dispose();
    super.dispose();
  }

  Future<void> _onModify() async {
    if (_formKey.currentState!.validate()) {
      int indexInt = int.parse(_indexController.text);
      String indexString = indexInt
          .toString(); // Convertir de nouveau en chaîne de caractères pour l'API
      // Parsing 'code_215' as an integer and formatting 'Date_entrée' as a proper date string
      Map<String, dynamic> updatedRow = {
        'index':_indexController.text,
        'code_215': _code215Controller.text, // Convert to int
        'Serie': _serieController.text,
        'Carte_Module': _carteModuleController.text,
        'Partie': _partieController.text,
        'Designation': _designationController.text,
        'Reference': _referenceController.text,
        'Date_entree': _dateEntreeController.text, // Ensure proper date format
        'Rame_du_depose': _rameDePoseController.text,
        'Voiture': _voitureController.text,
        'Motif_du_depose': _motifDePoseController.text,
        'Emplacement_actuel': _emplacementActuelController.text,
      };

      try {
        // Utiliser l'entier pour l'index pour la mise à jour
        await ApiService().updateReceptionRame(indexInt, updatedRow);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ligne modifiée avec succès')),
        );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ReceptionRameTable()));
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
                  SizedBox(height: 50,),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _code215Controller,
                              decoration: InputDecoration(
                                labelText: 'Code 215',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
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
                                FilteringTextInputFormatter.digitsOnly
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
                              controller: _dateEntreeController,
                              decoration: InputDecoration(
                                labelText: 'Date d\'entrée',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _rameDePoseController,
                              decoration: InputDecoration(
                                labelText: 'Rame du dépose',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
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
                              controller: _motifDePoseController,
                              decoration: InputDecoration(
                                labelText: 'Motif du dépose',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _emplacementActuelController,
                              decoration: InputDecoration(
                                labelText: 'Emplacement actuel',
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
                        onPressed: _onCancel,
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
