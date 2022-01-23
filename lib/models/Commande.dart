// import 'package:admin/models/ClientOld.dart';
// import 'package:admin/models/Produit.dart';
// import 'package:admin/models/Responsable.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// part 'Commande.g.dart';
//
// @JsonSerializable()
// class Commande {
//   @JsonKey(name: 'commande', required: false)
//   String _idCommande = '';
//
//   @JsonKey(name: 'date_commande', required: false)
//   DateTime _dateCommande = DateTime.now();
//
//   @JsonKey(name: 'etat_commande', required: false)
//   String _etatCommande = '';
//
//   @JsonKey(name: 'client', required: false)
//   Client _client;
//
//   @JsonKey(name: 'produits', required: false)
//   List<Ligne> _lignes;
//
//   Commande(this._idCommande, this._dateCommande, this._etatCommande,
//       this._responsable, this._client, this._lignes);
//
//   factory Commande.fromJson(Map<String, dynamic> json)=> _$CommandeFromJson(json);
//
//   Map<String, dynamic> toJson() => _$CommandeToJson(this);
// }
//
// @JsonSerializable()
// class Facture {
//   @JsonKey(name: 'commande', required: false)
//   String _idFacture;
//
//   @JsonKey(name: 'commande', required: false)
//   Commande _commande;
//
//   @JsonKey(name: 'commande', required: false)
//   DateTime _date;
//
//   @JsonKey(name: 'commande', required: false)
//   num _fraisService;
//
//   @JsonKey(name: 'commande', required: false)
//   num _fraislivraison;
//
//   @JsonKey(name: 'commande', required: false)
//   num _promo;
//
//   Facture(this._idFacture, this._commande, this._date,
//       this._fraisService, this._fraislivraison, this._promo);
//
//   factory Facture.fromJson(Map<String, dynamic> json)=> _$FactureFromJson(json);
//
//   Map<String, dynamic> toJson() => _$FactureToJson(this);
// }
//
// @JsonSerializable()
// class Ligne { //Contenir
//   @JsonKey(name: 'produits', required: false)
//   Produit _produit;
//
//   @JsonKey(name: 'qtt', required: false)
//   int _quantite;
//
//   @JsonKey(name: 'commande', required: false)
//   num _prixUnitaire;
//
//   @JsonKey(name: 'commande', required: false)
//   String _etat;
//
//   Ligne(this._produit, this._quantite, this._prixUnitaire,
//       this._etat);
//
//   factory Ligne.fromJson(Map<String, dynamic> json)=> _$LigneFromJson(json);
//
//   Map<String, dynamic> toJson() => _$LigneToJson(this);
// }