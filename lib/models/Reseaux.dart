class Reseau {
  int id_reseau;
  String nom_reseau;
  
  Reseau({
    required this.id_reseau,
    required this.nom_reseau,
  });
  
  factory Reseau.fromJson(Map<String, dynamic> json) {
    return Reseau(id_reseau: json["id"], nom_reseau: json["nom"]);
  }

  static List<Reseau> getAllReseaux(Map<String, dynamic> json) {
    List<Reseau> reseaux = [];
    json["data"].map((i) => Reseau.fromJson(i)).forEach((e) => reseaux.add(e));
    return reseaux;
  }
}

