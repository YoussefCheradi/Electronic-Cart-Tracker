// models.dart

class ReceptionRameModel {
  final int? index;
  final int code215;
  final String Serie;
  final String carteModule;
  final String partie;
  final String Designation;
  final int Reference;
  final int dateEntree;
  final int Rame_du_depose;
  final String voiture;
  final String Motif_du_depose;
  final String emplacementActuel;

  ReceptionRameModel({
    this.index,
    required this.code215,
    required this.Serie,
    required this.carteModule,
    required this.partie,
    required this.Designation,
    required this.Reference,
    required this.dateEntree,
    required this.Rame_du_depose,
    required this.voiture,
    required this.Motif_du_depose,
    required this.emplacementActuel,
  });

  factory ReceptionRameModel.fromJson(Map<String, dynamic> json) {
    return ReceptionRameModel(
      index:json['index'],
      code215: json['code_215'],
      Serie: json['Série'],
      carteModule: json['Carte_Module'],
      partie: json['Partie'],
      Designation: json['Désignation'],
      Reference: json['Référence'],
      dateEntree: json['Date_entrée'],
      Rame_du_depose: json['Rame_du_dépose'],
      voiture: json['Voiture'],
      Motif_du_depose: json['Motif_du_dépose'],
      emplacementActuel: json['Emplacement_actuel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'code_215': code215,
      'Série': Serie,
      'Carte_Module': carteModule,
      'Partie': partie,
      'Désignation': Designation,
      'Référence': Reference,
      'Date_entrée': dateEntree,
      'Rame_du_dépose': Rame_du_depose,
      'Voiture': voiture,
      'Motif_du_dépose': Motif_du_depose,
      'Emplacement_actuel': emplacementActuel,
    };
  }
}

class EnvoiRameModel {
  final int? index;
  final int code234;
  final String serie;
  final String carteModule;
  final String partie;
  final String designation;
  final int reference;
  final int dateEnvoi;
  final int rameDuPose;
  final String voiture;
  final String organe;

  EnvoiRameModel({
    this.index,
    required this.code234,
    required this.serie,
    required this.carteModule,
    required this.partie,
    required this.designation,
    required this.reference,
    required this.dateEnvoi,
    required this.rameDuPose,
    required this.voiture,
    required this.organe,
  });

  factory EnvoiRameModel.fromJson(Map<String, dynamic> json) {
    return EnvoiRameModel(
      index:json['index'],
      code234: json['code_234'],
      serie: json['Série'],
      carteModule: json['Carte_Module'],
      partie: json['Partie'],
      designation: json['Désignation'],
      reference: json['Référence'],
      dateEnvoi: json['Date_envoi'],
      rameDuPose: json['Rame_du_pose'],
      voiture: json['Voiture'],
      organe: json['Organe'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'code_234': code234,
      'Série': serie,
      'Carte_Module': carteModule,
      'Partie': partie,
      'Désignation': designation,
      'Référence': reference,
      'Date_envoi': dateEnvoi,
      'Rame_du_pose': rameDuPose,
      'Voiture': voiture,
      'Organe': organe,
    };
  }
}

class ReceptionPrestataireRLAModel {
  final int? index;
  final int code359;
  final String serie;
  final String carteModule;
  final String partie;
  final String designation;
  final String reference;
  final String dateEntree;
  final String prestataireRLA;
  final String rapportDeReparation;
  final String emplacementActuel;

  ReceptionPrestataireRLAModel({
    this.index,
    required this.code359,
    required this.serie,
    required this.carteModule,
    required this.partie,
    required this.designation,
    required this.reference,
    required this.dateEntree,
    required this.prestataireRLA,
    required this.rapportDeReparation,
    required this.emplacementActuel,
  });

  factory ReceptionPrestataireRLAModel.fromJson(Map<String, dynamic> json) {
    return ReceptionPrestataireRLAModel(
      index:json['index'],
      code359: json['code_359'],
      serie: json['Série'],
      carteModule: json['Carte_Module'],
      partie: json['Partie'],
      designation: json['Désignation'],
      reference: json['Référence'],
      dateEntree: json['Date_entrée'],
      prestataireRLA: json['Prestataire_RLA'],
      rapportDeReparation: json['Rapport_de_réparation'],
      emplacementActuel: json['Emplacement_actuel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'code_359': code359,
      'Série': serie,
      'Carte_Module': carteModule,
      'Partie': partie,
      'Désignation': designation,
      'Référence': reference,
      'Date_entrée': dateEntree,
      'Prestataire_RLA': prestataireRLA,
      'Rapport_de_réparation': rapportDeReparation,
      'Emplacement_actuel': emplacementActuel,
    };
  }
}

class EnvoiPrestataireRLAModel {
  final int? index;
  final int code1568;
  final String serie;
  final String carteModule;
  final String partie;
  final String designation;
  final String reference;
  final String dateEnvoi;
  final String numeroBL;
  final String motifEnvoi;
  final String prestataireRLA;

  EnvoiPrestataireRLAModel({
    this.index,
    required this.code1568,
    required this.serie,
    required this.carteModule,
    required this.partie,
    required this.designation,
    required this.reference,
    required this.dateEnvoi,
    required this.numeroBL,
    required this.motifEnvoi,
    required this.prestataireRLA,
  });

  factory EnvoiPrestataireRLAModel.fromJson(Map<String, dynamic> json) {
    return EnvoiPrestataireRLAModel(
      index:json['index'],
      code1568: json['code_1568'],
      serie: json['Série'],
      carteModule: json['Carte_Module'],
      partie: json['Partie'],
      designation: json['Désignation'],
      reference: json['Référence'],
      dateEnvoi: json['Date_envoi'],
      numeroBL: json['Numéro_BL'],
      motifEnvoi: json['Motif_envoi'],
      prestataireRLA: json['Prestataire_RLA'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'code_1568': code1568,
      'Série': serie,
      'Carte_Module': carteModule,
      'Partie': partie,
      'Désignation': designation,
      'Référence': reference,
      'Date_envoi': dateEnvoi,
      'Numéro_BL': numeroBL,
      'Motif_envoi': motifEnvoi,
      'Prestataire_RLA': prestataireRLA,
    };
  }
}

class ReparationModuleModel {
  final int? index;
  final int? id;
  final String serie;
  final String partie;
  final String designation;
  final String reference;
  final String lieuDuDepose;
  final String dateDebut;
  final String motifDeReparation;
  final String rDiagnostique;
  final String intervention;
  final String reparateur;
  final String dateFin;
  final String emplacement;
  final String nombreDeJour;

  ReparationModuleModel({
    this.index,
    this.id,
    required this.serie,
    required this.partie,
    required this.designation,
    required this.reference,
    required this.lieuDuDepose,
    required this.dateDebut,
    required this.motifDeReparation,
    required this.rDiagnostique,
    required this.intervention,
    required this.reparateur,
    required this.dateFin,
    required this.emplacement,
    required this.nombreDeJour,
  });

  factory ReparationModuleModel.fromJson(Map<String, dynamic> json) {
    return ReparationModuleModel(
      index:json['index'],
      id: json['ID'],
      serie: json['Série'],
      partie: json['Partie'],
      designation: json['Désignation'],
      reference: json['Référence'],
      lieuDuDepose: json['Lieu_du_dépose'],
      dateDebut: json['Date_début'],
      motifDeReparation: json['Motif_de_réparation'],
      rDiagnostique: json['R_Diagnostique'],
      intervention: json['Intervention'],
      reparateur: json['Réparateur'],
      dateFin: json['Date_fin'],
      emplacement: json['Emplacement'],
      nombreDeJour: json['Nombre_de_Jour'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'ID': id,
      'Série': serie,
      'Partie': partie,
      'Désignation': designation,
      'Référence': reference,
      'Lieu_du_dépose': lieuDuDepose,
      'Date_début': dateDebut,
      'Motif_de_réparation': motifDeReparation,
      'R_Diagnostique': rDiagnostique,
      'Intervention': intervention,
      'Réparateur': reparateur,
      'Date_fin': dateFin,
      'Emplacement': emplacement,
      'Nombre_de_Jour': nombreDeJour,
    };
  }
}

class EssaiModel {
  final int? index;
  final int code189;
  final String serie;
  final String carteModule;
  final String partie;
  final String designation;
  final String reference;
  final String dateEssai;
  final String lieuEssai;
  final String resultatEssai;
  final String observation;

  EssaiModel({
    required this.index,
    required this.code189,
    required this.serie,
    required this.carteModule,
    required this.partie,
    required this.designation,
    required this.reference,
    required this.dateEssai,
    required this.lieuEssai,
    required this.resultatEssai,
    required this.observation,
  });

  factory EssaiModel.fromJson(Map<String, dynamic> json) {
    return EssaiModel(
      index:json['index'],
      code189: json['code_189'],
      serie: json['Série'],
      carteModule: json['Carte_Module'],
      partie: json['Partie'],
      designation: json['Désignation'],
      reference: json['Référence'],
      dateEssai: json['Date_essai'],
      lieuEssai: json['Lieu_essai'],
      resultatEssai: json['Résultat_essai'],
      observation: json['Observation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'index': index,
      'code_189': code189,
      'Série': serie,
      'Carte_Module': carteModule,
      'Partie': partie,
      'Désignation': designation,
      'Référence': reference,
      'Date_essai': dateEssai,
      'Lieu_essai': lieuEssai,
      'Résultat_essai': resultatEssai,
      'Observation': observation,
    };
  }
}
