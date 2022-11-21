import 'dart:convert';

class Driver {
  final String id;
  final String nom;
  final String prenom;
  final String codeChauffeur;
  final String numeroIm;
  final String photo;
  final String qrImage;


  Driver(
      {
        required this.id,
      required this.nom,
      required this.prenom,
      required this.codeChauffeur,
      required this.numeroIm,
      required this.photo,
      required this.qrImage,
 });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'codeChauffeur': codeChauffeur,
      'numeroIm': numeroIm,
      'photo': photo,
      'qrImage': qrImage,
      
    };
  }

  factory Driver.fromMap(Map<String, dynamic> map) {
    return Driver(
      id: map['id'] ?? '',
      nom: map['nom'] ?? '',
      prenom: map['prenom'] ?? '',
      codeChauffeur: map['codeChauffeur'] ?? '',
      numeroIm: map['numeroIm'] ?? '',
      photo: map['photo'] ?? '',
      qrImage: map['qrImage'] ?? '',
      
    );
  }

  String toJson() => json.encode(toMap());

  factory Driver.fromJson(String source) => Driver.fromMap(json.decode(source));
}
