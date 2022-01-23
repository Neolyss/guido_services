import 'dart:convert';

import 'package:admin/models/CRUDAll.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Cli.g.dart';

@JsonSerializable()
class Client {
  String id_client = '';
  num id_reseau = 0;
  String nom_client = '';
  String prenom_client = '';
  String email_client = '';
  num? points_fixe = 0;
  num id_type = 0;
  num auto_inc = 0;
  num isActive = 0;
  num id_adresse = 0;
  String numero_adresse = '';
  String nom_adresse = '';
  String complement = '';
  String code_postal = '';
  String ville = '';
  String code_pays_telephone = '';
  String telephone_adresse = '';
  String url = '';
  String nom_reseau = '';
  String id_commande = '';
  String date_commande = '';
  String etat_commande = '';
  String pseudo_responsable = '' ;
  num id_points = 0;
  num points = 0;
  String description = '';
  String date_expiration = '';

  Client();

  factory Client.fromJson(Map<String, dynamic> json)=> _$ClientFromJson(json);

  Map<String, dynamic> toJson() => _$ClientToJson(this);

  static Future<Client?> read(id)  async {
    String url = "http://ensim.serveurtom.fr:7200/facture/get/commande/"+id;
    Response? response;
    // try {
    response = await Dio().get(url);
    print(jsonDecode(response.data)['data']);
    Client f = Client.fromJson(jsonDecode(response.data));
    // } catch (error, stackTrace){
    //   print("Exception occurred: $error  stackTrace: $stackTrace");
    // }
    return f;
  }

  static Future<List> readAll()  async {
    String url = "http://ensim.serveurtom.fr:7200/info/all/client/get";
    Response? response;
    List clients = [];
    // try {
    response = await Dio().get(url);
    print(jsonDecode(response.data));
    Client f = Client.fromJson(jsonDecode(response.data));
    // } catch (error, stackTrace){
    //   print("Exception occurred: $error  stackTrace: $stackTrace");
    // }
    return clients;
  }

  void create() async {
    try {
      String url = 'http://ensim.serveurtom.fr:7200/client/create/';
      var params = this.toJson();
      await RequeteHttp.methodePost(url, params);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
  }

  void update() async {
    try {
      String url = 'http://ensim.serveurtom.fr:7200/client/create/';
      var params = this.toJson();
      await RequeteHttp.methodePost(url, params);
    } catch (error, stackTrace){
      print("Exception occurred: $error  stackTrace: $stackTrace");
    }
  }

}