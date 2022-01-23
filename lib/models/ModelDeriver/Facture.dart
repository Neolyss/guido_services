

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

import '../CRUDAll.dart';

part 'Facture.g.dart';

@JsonSerializable()
class FactureTruc {
  @JsonKey(name: 'date_commande', required: false)
   String date = '';

  @JsonKey(name: 'factures', required: false)
   Facture? facture;

  @JsonKey(name: 'produits', required: false)
   List<Produit> produits = [];

  @JsonKey(name: 'client', required: false)
   Client? client;

  FactureTruc();

  factory FactureTruc.fromJson(Map<String, dynamic> json)=> _$FactureTrucFromJson(json);

   Map<String, dynamic> toJson() => _$FactureTrucToJson(this);

   static Future<FactureTruc?> read(id)  async {
    String url = "http://ensim.serveurtom.fr:7200/facture/get/commande/"+id;
    Response? response;
    // FactureTruc? f;
    // try {
      response = await Dio().get(url);
      print(jsonDecode(response.data)['data']);
    FactureTruc f = FactureTruc.fromJson(jsonDecode(response.data)['data']);
    // } catch (error, stackTrace){
    //   print("Exception occurred: $error  stackTrace: $stackTrace");
    // }
    return f;
  }

  void create() async {
    String url = "";
    try {
      String url = 'http://ensim.serveurtom.fr:7200/client/create/';
      var params = this.toJson();
      await RequeteHttp.methodePost(url, params);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
  }
}

@JsonSerializable()
class Facture {
  @JsonKey(name: 'id_facture', required: false)
  String idFacture = '';

  @JsonKey(name: 'commande', required: false)
  String idCommande = '';

  @JsonKey(name: 'date', required: false)
  String dateFacture = '';

  @JsonKey(name: 'fraisService', required: false)
  num fraisService = .0;

  @JsonKey(name: 'fraisLivraison', required: false)
  num fraisLivraison = .0;

  @JsonKey(name: 'promo', required: false)
  num promo = .0;

  Facture();

  factory Facture.fromJson(Map<String, dynamic> json)=> _$FactureFromJson(json);

  Map<String, dynamic> toJson() => _$FactureToJson(this);

}

@JsonSerializable()
class Produit {
  @JsonKey(name: 'nom', required: false)
  String nom = '';

  @JsonKey(name: 'modele', required: false)
  String modele = '';

  @JsonKey(name: 'prix_unitaire', required: false)
  num prixUnitaire = .0;

  @JsonKey(name: 'qtt', required: false)
  num quantite = 0;

  @JsonKey(name: 'prix_total', required: false)
  num prixTotal = .0;

  @JsonKey(name: 'etat', required: false)
  String etat = '';


  Produit();

  factory Produit.fromJson(Map<String, dynamic> json)=> _$ProduitFromJson(json);

  Map<String, dynamic> toJson() => _$ProduitToJson(this);

}

@JsonSerializable()
class Client {
  @JsonKey(name: 'id_client', required: false)
  String idClient = '';

  @JsonKey(name: 'adresse', required: false)
  String adresse = '';

  @JsonKey(name: 'telephone', required: false)
  String telephone = '';


  Client();

  factory Client.fromJson(Map<String, dynamic> json)=> _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);

}