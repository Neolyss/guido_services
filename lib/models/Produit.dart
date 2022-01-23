class Produit {
  int _id;
  String _libelle;
  String _modele;

  Produit(this._id, this._libelle, this._modele);
  }

class Stock { //Aprovisionner
  Produit _produit;
  Fournisseur _fournisseur;
  String _reference;
  int _quantite;
  num _prixAchat;
  num _prixBoutique;

  Stock(this._produit, this._fournisseur, this._reference, this._quantite,
      this._prixAchat, this._prixBoutique);
}

class Fournisseur {
  int _id;
  String _nom;

  Fournisseur(this._id, this._nom);
}