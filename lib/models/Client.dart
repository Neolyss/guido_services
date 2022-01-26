class Client {
  String _idClient;
  String _nomClient;
  String _prenomClient;
  String _emailClient;
  int _pointsFixeClient;
  List<ReseauClient> _reseaux;
  Adresse _adresse;
  TypeClient _type;
  //TODO commandes;

  Client(this._nomClient, this._prenomClient, this._emailClient, this._adresse, this._reseaux, this._type):
      this._pointsFixeClient = 0, this._idClient="";
}

class ReseauClient {
  ReseauSocial _reseauSocial;
  String _url;

  ReseauClient(this._reseauSocial, this._url);
}

class ReseauSocial {
  String _nomReseau;

  ReseauSocial(this._nomReseau);
}

class Adresse {
  int _idAdresse;
  int _numeroAdresse;
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
  String _nom;

  TypeClient(this._id, this._nom);

  int get id => _id;
  String get nom => _nom;

  factory TypeClient.fromJson(Map<String, dynamic> json) {
    return TypeClient(json["id"], json["nom"]);
  }

  static List<TypeClient> getListTypeClient(Map<String, dynamic> json) {
    List<TypeClient> types = [];
    json["data"].map((i) => TypeClient.fromJson(i)).forEach((e) => types.add(e));
    return types;
  }



}