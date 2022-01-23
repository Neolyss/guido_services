// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Facture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FactureTruc _$FactureTrucFromJson(Map<String, dynamic> json) => FactureTruc()
  ..date = json['date_commande'] as String
  ..facture = json['factures'] == null
      ? null
      : Facture.fromJson(json['factures'] as Map<String, dynamic>)
  ..produits = (json['produits'] as List<dynamic>)
      .map((e) => Produit.fromJson(e as Map<String, dynamic>))
      .toList()
  ..client = json['client'] == null
      ? null
      : Client.fromJson(json['client'] as Map<String, dynamic>);

Map<String, dynamic> _$FactureTrucToJson(FactureTruc instance) =>
    <String, dynamic>{
      'date_commande': instance.date,
      'factures': instance.facture,
      'produits': instance.produits,
      'client': instance.client,
    };

Facture _$FactureFromJson(Map<String, dynamic> json) => Facture()
  ..idFacture = json['id_facture'] as String
  ..idCommande = json['commande'] as String
  ..dateFacture = json['date'] as String
  ..fraisService = json['fraisService'] as num
  ..fraisLivraison = json['fraisLivraison'] as num
  ..promo = json['promo'] as num;

Map<String, dynamic> _$FactureToJson(Facture instance) => <String, dynamic>{
      'id_facture': instance.idFacture,
      'commande': instance.idCommande,
      'date': instance.dateFacture,
      'fraisService': instance.fraisService,
      'fraisLivraison': instance.fraisLivraison,
      'promo': instance.promo,
    };

Produit _$ProduitFromJson(Map<String, dynamic> json) => Produit()
  ..nom = json['nom'] as String
  ..modele = json['modele'] as String
  ..prixUnitaire = json['prix_unitaire'] as num
  ..quantite = json['qtt'] as num
  ..prixTotal = json['prix_total'] as num
  ..etat = json['etat'] as String;

Map<String, dynamic> _$ProduitToJson(Produit instance) => <String, dynamic>{
      'nom': instance.nom,
      'modele': instance.modele,
      'prix_unitaire': instance.prixUnitaire,
      'qtt': instance.quantite,
      'prix_total': instance.prixTotal,
      'etat': instance.etat,
    };

Client _$ClientFromJson(Map<String, dynamic> json) => Client()
  ..idClient = json['id_client'] as String
  ..adresse = json['adresse'] as String
  ..telephone = json['telephone'] as String;

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id_client': instance.idClient,
      'adresse': instance.adresse,
      'telephone': instance.telephone,
    };
