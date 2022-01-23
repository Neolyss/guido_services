// import 'dart:convert';
// import 'dart:io';
//
// import 'package:admin/models/CRUDAll.dart';
// import 'package:dio/dio.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// // part 'Client.g.dart';
//
// @JsonSerializable()
// class Client implements CRUDAll{
//   @JsonKey(name: 'id_client', required: false)
//   String _idClient = '';
//
//   @JsonKey(name: 'num_client', required: false)
//   String? _nomClient = '';
//
//   @JsonKey(name: 'prenom_client', required: false)
//   String? _prenomClient = '';
//
//   @JsonKey(name: 'email_client', required: false)
//   String? _emailClient = '';
//
//   @JsonKey(name: 'points_fixe', required: false)
//   int? _pointsFixeClient = 0;
//
//   @JsonKey(name: 'reseaux', required: false)
//   List<ReseauSocial> _reseaux = [];
//
//   @JsonKey(name: 'adresse', required: false)
//   Adresse? _adresse;
//
//   @JsonKey(name: 'registration_date_millis', required: false)
//   TypeClient? _type;
//
//   Client(this._nomClient, this._prenomClient, this._emailClient, this._adresse, this._reseaux, this._type):
//       this._pointsFixeClient = 0, this._idClient="";
//
//   factory Client.fromJson(Map<String, dynamic> json)=> _$ClientFromJson(json);
//
//   Map<String, dynamic> toJson() => _$ClientToJson(this);
//
//   @override
//   dynamic create() async {
//     Response? response;
//     try {
//       String url = 'http://ensim.serveurtom.fr:7200/client/create/';
//       var params = {'Nom_client': this._nomClient,
//         'Prenom_client': this._prenomClient,
//         'Email' : this._emailClient,
//         'Points_fixe' : '0',
//         'Id_type' : _type.id.toString()};
//       response = await RequeteHttp.methodePost(url, params);
//     } catch (error, stackTrace){
//       print("Exception occurred: $error  stackTrace: $stackTrace");
//     }
//     return response?.data.toString();
//   }
//
//   @override
//   void delete() {
//     // TODO: implement delete
//   }
//
//   @override
//   void read(var id) async {
//     Response? response;
//     try {
//       String url = 'http://ensim.serveurtom.fr:7200/info/all/info/client/'+id;
//       response = await Dio().get(url);
//
//     } catch (error, stackTrace){
//       print("Exception occurred: $error  stackTrace: $stackTrace");
//     }
//     print(response?.data.toString());
//   }
//
//   @override
//   void readAll() {
//     // TODO: implement readAll
//   }
//
//   @override
//   void update() {
//     // TODO: implement update
//   }
//
// }
//
// class ReseauSocial {
//   String _nomReseau;
//   String _url;
//   ReseauSocial(this._nomReseau, this._url);
// }
//
// class Adresse {
//   int? _idAdresse;
//   String? _numeroAdresse;
//   String? _nomAdresse;
//   String? _complement;
//   String? _codePostal;
//   String? _ville;
//   Telephone? _telephone;
//
//   Adresse(this._idAdresse, this._numeroAdresse, this._nomAdresse, this._codePostal, this._ville, this._telephone) :
//         this._complement = "";
// }
//
// class Telephone {
//   String _codePaysTelephone;
//   String _numeroTelephone;
//
//   Telephone(this._codePaysTelephone, this._numeroTelephone);
// }
//
// class TypeClient {
//   int _id;
//   String _titreTypeClient;
//
//   TypeClient(this._id, this._titreTypeClient);
//
//   String get titreTypeClient => _titreTypeClient;
//
//   set titreTypeClient(String value) {
//     _titreTypeClient = value;
//   }
//
//   int get id => _id;
//
//   set id(int value) {
//     _id = value;
//   }
//
//
// }