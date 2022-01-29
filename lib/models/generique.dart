import 'dart:convert';

import 'package:admin/models/CRUDAll.dart';
import 'package:dio/dio.dart';
import 'dart:developer' as developer;

class G {
  static Future<void> deleteClient (var idClient) async {
    try {
      String url = 'http://ensim.serveurtom.fr:7200/client/delete/'+idClient;
      await Dio().get(url);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
  }

  static Future<void> deleteAdresse (var idAdresse) async {
    try {
      String url = 'http://ensim.serveurtom.fr:7200/adresse/delete/'+idAdresse;
      await Dio().get(url);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
  }

  static Future<void> deleteMoyenPaiement (var idMoyen) async {
    try {
      String url = 'http://ensim.serveurtom.fr:7200/moyen_paiement/delete/'+idMoyen;
      await Dio().get(url);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
  }

  static Future<Map<String, dynamic>> recupAllInfoClient (var idClient) async {
    Response? response;
    try {
      String url = 'http://ensim.serveurtom.fr:7200/info/all/info/client/'+idClient;
      response = await Dio().get(url);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
    //developer.log(response.toString());
    return await jsonDecode(response!.data)['data'];
  }

  static Future<Map<String, dynamic>> recupAllInfoClients () async {
    Response? response;
    Map<String, dynamic> json;
    try {
      String url = 'http://ensim.serveurtom.fr:7200/info/all/client/get/';
      response = await Dio().get(url);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
    return await jsonDecode(response!.data);
  }

  static Future<String> createClient (String Nom_client, String  Prenom_client, String Email, int Points_fixe, int Id_type) async {
    Response? response;
    try {
      String url = 'http://ensim.serveurtom.fr:7200/client/create/';
      var params = {
        "Nom_client":Nom_client,
        "Prenom_client":Prenom_client,
        "Email":Email,
        "Points_fixe":Points_fixe,
        "Id_type":Id_type
      };
      response = await RequeteHttp.methodePost(url, params);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
    return await jsonDecode(response!.data)["data"]["id"];
  }

  static Future<void> createAdresse (String Numero, String Nom, String Complement, String Code_postal, String Ville,String Code_pays_tel, String Tel, String Id_client) async {
    try {
      String url = 'http://ensim.serveurtom.fr:7200/client/create/';
      var params = {
        "Numero":Numero,
        "Nom":Nom,
        "Complement": Complement,
        "Code_postal":Code_postal,
        "Ville":Ville,
        "Code_pays_tel":Code_pays_tel,
        "Tel":Tel,
        "Id_client":Id_client
      };
      await RequeteHttp.methodePost(url, params);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
  }

  static Future<void> createCommande (String Etat_commande, String Pseudo_responsable, String Id_client) async {
    try {
      String url = 'http://ensim.serveurtom.fr:7200/commande/create/';
      var params = {
        "Etat_commande":Etat_commande,
        "Pseudo_responsable":Pseudo_responsable,
        "Id_client":Id_client
      };
      await RequeteHttp.methodePost(url, params);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
  }

  static Future<void> createFacture (String Id_commande, String Frais_service, String Frais_livraison, String Promo) async {
    try {
      String url = 'http://ensim.serveurtom.fr:7200/facture/create/';
      var params = {
        "Id_commande":Id_commande,
        "Frais_service":Frais_service,
        "Frais_livraison":Frais_livraison,
        "Promo":Promo
      };
      await RequeteHttp.methodePost(url, params);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
  }

  static Future<void> createRespo (String Nom_respo, String Prenom_respo, String Email_respo, String Password_respo) async {
    try {
      String url = 'http://ensim.serveurtom.fr:7200/responsable/create/';
      var params = {
        "Nom_respo":Nom_respo,
        "Prenom_respo":Prenom_respo,
        "Email_respo":Email_respo,
        "Password_respo":Password_respo
      };
      await RequeteHttp.methodePost(url, params);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
  }

  static Future<void> createMoyenPayement (String Type, String Moyen) async {
    try {
      String url = 'http://ensim.serveurtom.fr:7200/moyen_payement/create';
      var params = {
        "Type":Type,
        "Moyen":Moyen
      };
      await RequeteHttp.methodePost(url, params);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
  }

  static Future<void> createFournisseur () async {
    try {
      String url = 'http://ensim.serveurtom.fr:7200/fournisseur/create/';
      var params = {};
      await RequeteHttp.methodePost(url, params);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
  }

  static Future<void> createPaiement (String Montant, String Id_moyen_paiement, String Id_commande, String Id_facture) async {
    try {
      String url = 'http://ensim.serveurtom.fr:7200/paiement/create/';
      var params = {
        "Montant":Montant,
        "Id_moyen_paiement":Id_moyen_paiement,
        "Id_commande":Id_commande,
        "Id_facture":Id_facture
      };
      await RequeteHttp.methodePost(url, params);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
  }

  static Future<void> createPoint (String Points, String Desc, String Date_expiration, String Id_client) async {
    try {
      String url = 'http://ensim.serveurtom.fr:7200/points/create/';
      var params = {
        "Points":Points,
        "Desc":Desc,
        "Date_expiration":Date_expiration,
        "Id_client":Id_client
      };
      await RequeteHttp.methodePost(url, params);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
  }

  static Future<void> createProduit (String Nom, String Modele) async {
    try {
      String url = 'http://ensim.serveurtom.fr:7200/produit/create/';
      var params = {
        "Nom":Nom,
        "Modele":Modele
      };
      await RequeteHttp.methodePost(url, params);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
  }

  static Future<void> addProduitCommande (String Id_commande, String Id_produit, String Qtt, String Prix_unitaire, String Etat) async {
    try {
      String url = 'http://ensim.serveurtom.fr:7200/commande/add/';
      var params = {
        "Id_commande":Id_commande,
        "Id_produit":Id_produit,
        "Qtt":Qtt,
        "Prix_unitaire":Prix_unitaire,
        "Etat":Etat
      };
      await RequeteHttp.methodePost(url, params);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
  }

  static Future<void> modificationClient (String id_client, String email_client, String nom_client, int points_fixe_client, String prenom_client) async {
    try {
      String url = 'http://ensim.serveurtom.fr:7200/users/update/user/data/';
      var params = {
        "id_client":id_client ,
        "email_client":email_client ,
        "nom_client":nom_client,
        "points_fixe_client":points_fixe_client ,
        "prenom_client":prenom_client ,
      };
      await RequeteHttp.methodePost(url, params);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
  }

  static Future<void> modifCommande (String id_client, String id_commande, String etat_commande, String pseudo_responsable) async {
    try {
      String url = 'http://ensim.serveurtom.fr:7200/users/modif/commande/';
      var params = {
        "id_client":id_client,
        "id_commande":id_commande,
        "etat_commande":etat_commande,
        "pseudo_responsable":pseudo_responsable
      };
      await RequeteHttp.methodePost(url, params);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
  }

  static Future<void> modifType (String id_type, String titre_rang) async {
    try {
      String url = 'http://ensim.serveurtom.fr:7200/users/modif/Type/';
      var params = {
        "id_type":id_type,
        "titre_rang":titre_rang
      };
      await RequeteHttp.methodePost(url, params);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
  }

  static Future<void> modifPoint (String id_points, String points, String description, String date_expiration, String id_client) async {
    try {
      String url = 'http://ensim.serveurtom.fr:7200/users/modif/Point/';
      var params = {
        "id_points":id_points,
        "points":points,
        "description":description,
        "date_expiration":date_expiration,
        "id_client":id_client
      };
      await RequeteHttp.methodePost(url, params);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
  }

  static Future<void> modifAdresse (int id_adresse, String numero_adresse, String nom_adresse, String complement, String code_postal, String ville, String code_pays_telephone, String telephone_adresse, String id_client) async {
    developer.log("bif");
    try {
      String url = 'http://ensim.serveurtom.fr:7200/users/modif/adresse/';
      var params = {
        "id_adresse":id_adresse,
        "numero_adresse":numero_adresse,
        "nom_adresse":nom_adresse,
        "complement":complement,
        "code_postal":code_postal,
        "ville":ville,
        "code_pays_telephone":code_pays_telephone,
        "telephone_adresse":telephone_adresse,
        "id_client":id_client
      };
      await RequeteHttp.methodePost(url, params);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
  }

  static Future<int> responsableCheck (String Pseudo,String MDP) async {
    Response? response;
    try {
      String url = 'http://ensim.serveurtom.fr:7200/responsable/check/';
      var params = {
        "Pseudo":Pseudo,
        "MDP":MDP
      };
      response = await RequeteHttp.methodePost(url, params);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
    return int.parse(response?.data);
  }

  static Future<Map<String, dynamic>> commandeInfo (id_commande) async {
    Response? response;
    try {
      String url = 'http://ensim.serveurtom.fr:7200/commande/info/'+id_commande;
      response = await Dio().get(url);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
    return response?.data;
  }


  static Future<void> creeTypeClient (id_type, id_client) async {
    try {
      String url = 'http://ensim.serveurtom.fr:7200/cree/type/client/'+id_type+'/'+id_client;
      await Dio().get(url);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
  }

  static Future<Map<String, dynamic>> commandeInfoAllResponsable (pseudo_responsable) async {
    Response? response;
    try {
      String url = 'http://ensim.serveurtom.fr:7200/commande/info/all/'+pseudo_responsable;
      response = await Dio().get(url);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
    return jsonDecode(response?.data);
  }

  static Future<Map<String, dynamic>> factureGetCommande (id_commande) async {
    Response? response;
    try {
      String url = 'http://ensim.serveurtom.fr:7200/facture/get/commande/'+id_commande;
      response = await Dio().get(url);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
    return jsonDecode(response?.data)['data'];
  }

  static Future<Map<String, dynamic>> getAllTypes() async {
    Response? response;
    try {
      String url = 'http://ensim.serveurtom.fr:7200/types/getAll/';
      response = await Dio().get(url);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
    return await jsonDecode(response?.data);
  }

  static Future<Map<String, dynamic>> getAllReseaux() async {
    Response? response;
    try {
      String url = 'http://ensim.serveurtom.fr:7200/reseaux/getAll/';
      response = await Dio().get(url);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
    return await jsonDecode(response?.data);
  }

}