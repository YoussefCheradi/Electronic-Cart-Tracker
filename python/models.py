from pydantic import BaseModel, Field
from typing import Optional

# Modèle pour Réception-Rame
class ReceptionRameModel(BaseModel):
    code_215: str 
    Serie: str
    Carte_Module: str
    Partie: str
    Designation: str
    Reference: str
    Date_entree: str
    Rame_du_depose: str 
    Voiture: str
    Motif_du_depose: str
    Emplacement_actuel: str
    

# Modèle pour Envoi-Rame
class EnvoiRameModel(BaseModel):
    code_234: str 
    Serie: str
    Carte_Module: str
    Partie: str
    Designation: str
    Reference: str
    Date_envoi: str
    Rame_du_pose: str
    Voiture: str
    Organe: str

# Modèle pour Réception-Prestataire-RLA
class ReceptionPrestataireRLAModel(BaseModel):
    code_359: str 
    Serie: str
    Carte_Module: str
    Partie: str
    Designation: str
    Reference: str
    Date_entree: str
    Prestataire_RLA: str
    Rapport_de_reparation: str
    Emplacement_actuel: str

# Modèle pour Envoi-Prestataire-RLA
class EnvoiPrestataireRLAModel(BaseModel):
    code_1568: str 
    Serie: str
    Carte_Module: str
    Partie: str
    Designation: str
    Reference: str
    Date_envoi: str
    Numero_BL: str
    Motif_envoi: str
    Prestataire_RLA: str

# Modèle pour Réparation Module
class ReparationModuleModel(BaseModel):
    ID: str
    Serie: str
    Partie: str
    Designation: str
    Reference: str
    Lieu_du_depose: str
    Date_debut: str
    Motif_de_reparation: str
    R_Diagnostique: str
    Intervention: str
    Reparateur: str
    Date_fin: str
    Emplacement: str
    Nombre_de_Jour: str

# Modèle pour Essai
class EssaiModel(BaseModel):
    code_189: str 
    Serie: str
    Carte_Module: str
    Partie: str
    Designation: str
    Reference: str
    Date_essai: str
    Lieu_essai: str
    Resultat_essai: str
    Observation: str
