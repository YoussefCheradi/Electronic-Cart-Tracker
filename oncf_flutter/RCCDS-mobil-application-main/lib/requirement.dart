class Carte {
  int code215;
  String serie;
  String carteModule;
  String partie;
  String designation;
  String reference;
  String dateEntree;
  String rameDuDepose;
  String voiture;
  String motifDuDepose;
  String emplacementActuel;

  Carte({
    required this.code215,
    required this.serie,
    required this.carteModule,
    required this.partie,
    required this.designation,
    required this.reference,
    required this.dateEntree,
    required this.rameDuDepose,
    required this.voiture,
    required this.motifDuDepose,
    required this.emplacementActuel,
  });

  factory Carte.fromJson(Map<String, dynamic> json) {
    return Carte(
      code215: json['code_215'],
      serie: json['Série'],
      carteModule: json['Carte_Module'],
      partie: json['Partie'],
      designation: json['Désignation'],
      reference: json['Référence'],
      dateEntree: json['Date_entrée'],
      rameDuDepose: json['Rame_du_dépose'],
      voiture: json['Voiture'],
      motifDuDepose: json['Motif_du_dépose'],
      emplacementActuel: json['Emplacement_actuel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code_215': code215,
      'Série': serie,
      'Carte_Module': carteModule,
      'Partie': partie,
      'Désignation': designation,
      'Référence': reference,
      'Date_entrée': dateEntree,
      'Rame_du_dépose': rameDuDepose,
      'Voiture': voiture,
      'Motif_du_dépose': motifDuDepose,
      'Emplacement_actuel': emplacementActuel,
    };
  }
}
