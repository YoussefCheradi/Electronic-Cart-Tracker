import 'package:database/Reception-Prestataire-RLA/Reception-Prestataire-tableau.dart';
import 'package:database/Reparation-Module/Reparation-Module-tableau.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For restricting input types
import '../api/api_service.dart'; // Your ApiService for adding the data
import 'package:database/EnvoiRame/EnvoiRame-tableau.dart';
class Reparation_Module_AddRowPage extends StatefulWidget {
  @override
  _Reparation_Module_AddRowPageState createState() => _Reparation_Module_AddRowPageState();
}

class _Reparation_Module_AddRowPageState extends State<Reparation_Module_AddRowPage> {
  final _formKey = GlobalKey<FormState>();
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
  @override
  void initState() {
    super.initState();

    _idController = TextEditingController(); // Pour l'ID
    _serieController = TextEditingController();
    _partieController = TextEditingController();
    _designationController = TextEditingController();
    _referenceController = TextEditingController();
    _lieuDuDeposeController = TextEditingController();
    _dateDebutController = TextEditingController();
    _motifDeReparationController = TextEditingController();
    _rDiagnostiqueController = TextEditingController();
    _interventionController = TextEditingController();
    _reparateurController = TextEditingController();
    _dateFinController = TextEditingController();
    _emplacementController = TextEditingController();
    _nombreDeJourController = TextEditingController();

  }

  @override
  void dispose() {
    // Dispose des contrôleurs lorsque la page est détruite
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

  Future<void> _onAdd() async {
    if (_formKey.currentState!.validate()) {
      // Create the new row data
      Map<String, dynamic> newRow = {
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
        // Call the API to add the new row
        await ApiService().addReparationModule(newRow);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Nouvelle ligne ajoutée avec succès')),
        );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Reparation_ModuleTable())); // Go back to the table
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
