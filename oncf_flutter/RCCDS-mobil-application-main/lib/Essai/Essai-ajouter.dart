import 'package:database/Essai/Essai-tableau.dart';
import 'package:database/Reception-Prestataire-RLA/Reception-Prestataire-tableau.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For restricting input types
import '../api/api_service.dart'; // Your ApiService for adding the data
import 'package:database/EnvoiRame/EnvoiRame-tableau.dart';
class Essai_AddRowPage extends StatefulWidget {
  @override
  _Essai_AddRowPageState createState() => _Essai_AddRowPageState();
}

class _Essai_AddRowPageState extends State<Essai_AddRowPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _code189Controller;
  late TextEditingController _serieController;
  late TextEditingController _carteModuleController;
  late TextEditingController _partieController;
  late TextEditingController _designationController;
  late TextEditingController _referenceController;
  late TextEditingController _dateEssaiController;
  late TextEditingController _lieuEssaiController;
  late TextEditingController _resultatEssaiController;
  late TextEditingController _observationController;

  @override
  @override
  void initState() {
    super.initState();

    _code189Controller = TextEditingController();
    _serieController = TextEditingController();
    _carteModuleController = TextEditingController();
    _partieController = TextEditingController();
    _designationController = TextEditingController();
    _referenceController = TextEditingController();
    _dateEssaiController = TextEditingController();
    _lieuEssaiController = TextEditingController();
    _resultatEssaiController = TextEditingController();
    _observationController = TextEditingController();
  }

  @override
  void dispose() {
    // Dispose des contrôleurs lorsque la page est détruite
    _code189Controller.dispose();
    _serieController.dispose();
    _carteModuleController.dispose();
    _partieController.dispose();
    _designationController.dispose();
    _referenceController.dispose();
    _dateEssaiController.dispose();
    _lieuEssaiController.dispose();
    _resultatEssaiController.dispose();
    _observationController.dispose();
    super.dispose();
  }

  Future<void> _onAdd() async {
    if (_formKey.currentState!.validate()) {
      // Create the new row data
      Map<String, dynamic> newRow = {
        'code_189': _code189Controller.text,
        'Serie': _serieController.text,
        'Carte_Module': _carteModuleController.text,
        'Partie': _partieController.text,
        'Designation': _designationController.text,
        'Reference': _referenceController.text,
        'Date_essai': _dateEssaiController.text,
        'Lieu_essai': _lieuEssaiController.text,
        'Resultat_essai': _resultatEssaiController.text,
        'Observation': _observationController.text,
      };

      try {
        // Call the API to add the new row
        await ApiService().addEssai(newRow);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Nouvelle ligne ajoutée avec succès')),
        );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Essai_Table())); // Go back to the table
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
                              controller: _code189Controller,
                              decoration: InputDecoration(
                                labelText: 'Code 189',
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
                              controller: _dateEssaiController,
                              decoration: InputDecoration(
                                labelText: 'Date d\'essai',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.datetime,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _lieuEssaiController,
                              decoration: InputDecoration(
                                labelText: 'Lieu d\'essai',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _resultatEssaiController,
                              decoration: InputDecoration(
                                labelText: 'Résultat d\'essai',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              controller: _observationController,
                              decoration: InputDecoration(
                                labelText: 'Observation',
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
