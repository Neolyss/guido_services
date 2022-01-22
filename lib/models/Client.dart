

import 'package:admin/models/CRUDAll.dart';
import 'package:dio/dio.dart';

class Client implements CRUDAll{
  String _idClient;
  String _nomClient;
  String _prenomClient;
  String _emailClient;
  int _pointsFixeClient;
  List<ReseauSocial> _reseaux;
  Adresse _adresse;
  TypeClient _type;

  Client(this._nomClient, this._prenomClient, this._emailClient, this._adresse, this._reseaux, this._type):
      this._pointsFixeClient = 0, this._idClient="";

  @override
  dynamic create() async {
    dynamic response;
    try {
      // response = await Dio().get(
      //     'http://ensim.serveurtom.fr:7200/client/create/?'
      //         'Nom_client=' + this._nomClient +
      //         '&Prenom_client=' + this._prenomClient +
      //         '&Email=' + this._emailClient +
      //         '&Points_fixe=0'
      //             '&Id_type=' + _type.id.toString());
      print("azerty");
      response = await Dio().post('http://ensim.serveurtom.fr:7200/client/create/', data:
      {'Nom_client': this._nomClient,
        'Prenom_client': this._prenomClient,
        'Email' : this._emailClient,
        'Points_fixe' : '0',
        'Id_type' : _type.id.toString()},
         // options: Options(contentType: Headers.jsonContentType),
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        },
      );
      print(response.data.toString());
      // response = await Dio().post(url);
    } catch (e){
      print(e);
    }
    return response;
  }

  @override
  void delete() {
    // TODO: implement delete
  }

  @override
  void read(var id) {
    // TODO: implement read
  }

  @override
  void readAll() {
    // TODO: implement readAll
  }

  @override
  void update() {
    // TODO: implement update
  }



}

class ReseauSocial {
  String _nomReseau;
  String _url;
  ReseauSocial(this._nomReseau, this._url);
}

class Adresse {
  int _idAdresse;
  String _numeroAdresse;
  String _nomAdresse;
  String _complement;
  String _codePostal;
  String _ville;
  Telephone _telephone;

  Adresse(this._idAdresse, this._numeroAdresse, this._nomAdresse, this._codePostal, this._ville, this._telephone) :
        this._complement = "";
}

class Telephone {
  String _codePaysTelephone;
  String _numeroTelephone;

  Telephone(this._codePaysTelephone, this._numeroTelephone);
}

class TypeClient {
  int _id;
  String _titreTypeClient;

  TypeClient(this._id, this._titreTypeClient);

  String get titreTypeClient => _titreTypeClient;

  set titreTypeClient(String value) {
    _titreTypeClient = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }


}