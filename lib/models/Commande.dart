import 'package:admin/models/Client.dart';
import 'package:admin/models/Produit.dart';
import 'package:admin/models/Responsable.dart';

class Commande {
  String _idCommande;
  DateTime _dateCommande;
  String _etatCommande;
  Responsable _responsable;
  Client _client;
  List<Ligne> _lignes;

  Commande(this._idCommande, this._dateCommande, this._etatCommande,
      this._responsable, this._client, this._lignes);
}

class Facture {
  String _idFacture;
  Commande _commande;
  DateTime _date;
  num _fraisService;
  num _fraislivraison;
  num _promo;

  Facture(this._idFacture, this._commande, this._date,
      this._fraisService, this._fraislivraison, this._promo);
}

class Ligne { //Contenir
  Produit _produit;
  int _quantite;
  num _prixUnitaire;
  String _etat;

  Ligne(this._produit, this._quantite, this._prixUnitaire,
      this._etat);
}