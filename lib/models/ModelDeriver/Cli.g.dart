// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Cli.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(Map<String, dynamic> json) => Client()
  ..id_client = json['id_client'] as String
  ..id_reseau = json['id_reseau'] as num
  ..nom_client = json['nom_client'] as String
  ..prenom_client = json['prenom_client'] as String
  ..email_client = json['email_client'] as String
  ..points_fixe = json['points_fixe'] as num?
  ..id_type = json['id_type'] as num
  ..auto_inc = json['auto_inc'] as num
  ..isActive = json['isActive'] as num
  ..id_adresse = json['id_adresse'] as num
  ..numero_adresse = json['numero_adresse'] as String
  ..nom_adresse = json['nom_adresse'] as String
  ..complement = json['complement'] as String
  ..code_postal = json['code_postal'] as String
  ..ville = json['ville'] as String
  ..code_pays_telephone = json['code_pays_telephone'] as String
  ..telephone_adresse = json['telephone_adresse'] as String
  ..url = json['url'] as String
  ..nom_reseau = json['nom_reseau'] as String
  ..id_commande = json['id_commande'] as String
  ..date_commande = json['date_commande'] as String
  ..etat_commande = json['etat_commande'] as String
  ..pseudo_responsable = json['pseudo_responsable'] as String
  ..id_points = json['id_points'] as num
  ..points = json['points'] as num
  ..description = json['description'] as String
  ..date_expiration = json['date_expiration'] as String;

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id_client': instance.id_client,
      'id_reseau': instance.id_reseau,
      'nom_client': instance.nom_client,
      'prenom_client': instance.prenom_client,
      'email_client': instance.email_client,
      'points_fixe': instance.points_fixe,
      'id_type': instance.id_type,
      'auto_inc': instance.auto_inc,
      'isActive': instance.isActive,
      'id_adresse': instance.id_adresse,
      'numero_adresse': instance.numero_adresse,
      'nom_adresse': instance.nom_adresse,
      'complement': instance.complement,
      'code_postal': instance.code_postal,
      'ville': instance.ville,
      'code_pays_telephone': instance.code_pays_telephone,
      'telephone_adresse': instance.telephone_adresse,
      'url': instance.url,
      'nom_reseau': instance.nom_reseau,
      'id_commande': instance.id_commande,
      'date_commande': instance.date_commande,
      'etat_commande': instance.etat_commande,
      'pseudo_responsable': instance.pseudo_responsable,
      'id_points': instance.id_points,
      'points': instance.points,
      'description': instance.description,
      'date_expiration': instance.date_expiration,
    };
