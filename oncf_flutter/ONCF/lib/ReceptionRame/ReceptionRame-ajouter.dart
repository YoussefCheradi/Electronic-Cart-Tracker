import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For restricting input types
import '../api/api_service.dart'; // Your ApiService for adding the data
import 'ReceptionRame_tableaux.dart';

class ReceptionRame_AddRowPage extends StatefulWidget {
  @override
  _ReceptionRame_AddRowPageState createState() => _ReceptionRame_AddRowPageState();
}

class _ReceptionRame_AddRowPageState extends State<ReceptionRame_AddRowPage> {
  final _formKey = GlobalKey<FormState>();
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

    // Initialize controllers with empty data for a new entry
    _code215Controller = TextEditingController();
    _serieController = TextEditingController();
    _carteModuleController = TextEditingController();
    _partieController = TextEditingController();
    _designationController = TextEditingController();
    _referenceController = TextEditingController();
    _dateEntreeController = TextEditingController();
    _rameDePoseController = TextEditingController();
    _voitureController = TextEditingController();
    _motifDePoseController = TextEditingController();
    _emplacementActuelController = TextEditingController();
  }

  @override
  void dispose() {
    // Dispose controllers when the page is destroyed
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

  Future<void> _onAdd() async {
    if (_formKey.currentState!.validate()) {
      // Create the new row data
      Map<String, dynamic> newRow = {
        'code_215': _code215Controller.text, // Convert to int if necessary
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
        // Call the API to add the new row
        await ApiService().addReceptionRame(newRow);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Nouvelle ligne ajoutée avec succès')),
        );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ReceptionRameTable())); // Go back to the table
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de l\'ajout: $error')),
        );
      }
    }
  }

  void _onCancel() {
    Navigator.pop(context); // Cancel and close the page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une nouvelle ligne'),
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
                              controller: _dateEntreeController,
                              decoration: InputDecoration(
                                labelText: 'Date d\'entrée',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.datetime,
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
                  const SizedBox(height: 60),
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
                        onPressed: _onAdd,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: Size(150, 50),
                        ),
                        child: Text(
                          'Ajouter',
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
