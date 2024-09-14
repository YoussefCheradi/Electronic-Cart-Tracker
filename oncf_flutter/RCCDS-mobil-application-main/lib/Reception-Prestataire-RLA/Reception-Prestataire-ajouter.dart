import 'package:database/Reception-Prestataire-RLA/Reception-Prestataire-tableau.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For restricting input types
import '../api/api_service.dart'; // Your ApiService for adding the data
import 'package:database/EnvoiRame/EnvoiRame-tableau.dart';
class Reception_Prestataire_AddRowPage extends StatefulWidget {
  @override
  _Reception_Prestataire_AddRowPageState createState() => _Reception_Prestataire_AddRowPageState();
}

class _Reception_Prestataire_AddRowPageState extends State<Reception_Prestataire_AddRowPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _code359Controller;
  late TextEditingController _serieController;
  late TextEditingController _carteModuleController;
  late TextEditingController _partieController;
  late TextEditingController _designationController;
  late TextEditingController _referenceController;
  late TextEditingController _dateEntreeController;
  late TextEditingController _prestataireRLAController;
  late TextEditingController _rapportDeReparationController;
  late TextEditingController _emplacementActuelController;

  @override
  @override
  void initState() {
    super.initState();

    _code359Controller = TextEditingController();
    _serieController = TextEditingController();
    _carteModuleController = TextEditingController();
    _partieController = TextEditingController();
    _designationController = TextEditingController();
    _referenceController = TextEditingController();
    _dateEntreeController = TextEditingController();
    _prestataireRLAController = TextEditingController();
    _rapportDeReparationController = TextEditingController();
    _emplacementActuelController = TextEditingController();
  }

  @override
  void dispose() {
    // Dispose des contrôleurs lorsque la page est détruite
    _code359Controller.dispose();
    _serieController.dispose();
    _carteModuleController.dispose();
    _partieController.dispose();
    _designationController.dispose();
    _referenceController.dispose();
    _dateEntreeController.dispose();
    _prestataireRLAController.dispose();
    _rapportDeReparationController.dispose();
    _emplacementActuelController.dispose();
    super.dispose();
  }

  Future<void> _onAdd() async {
    if (_formKey.currentState!.validate()) {
      // Create the new row data
      Map<String, dynamic> newRow = {
        'code_359': _code359Controller.text,
        'Serie': _serieController.text,
        'Carte_Module': _carteModuleController.text,
        'Partie': _partieController.text,
        'Designation': _designationController.text,
        'Reference': _referenceController.text,
        'Date_entree': _dateEntreeController.text,
        'Prestataire_RLA': _prestataireRLAController.text,
        'Rapport_de_reparation': _rapportDeReparationController.text,
        'Emplacement_actuel': _emplacementActuelController.text,
      };

      try {
        // Call the API to add the new row
        await ApiService().addReceptionPrestataireRla(newRow);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Nouvelle ligne ajoutée avec succès')),
        );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Reception_PrestataireTable())); // Go back to the table
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
                              controller: _code359Controller,
                              decoration: InputDecoration(
                                labelText: 'Code 359',
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
                              controller: _dateEntreeController,
                              decoration: InputDecoration(
                                labelText: 'Date d\'entrée',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.datetime,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _prestataireRLAController,
                              decoration: InputDecoration(
                                labelText: 'Prestataire RLA',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _rapportDeReparationController,
                              decoration: InputDecoration(
                                labelText: 'Rapport de Réparation',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _emplacementActuelController,
                              decoration: InputDecoration(
                                labelText: 'Emplacement Actuel',
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
