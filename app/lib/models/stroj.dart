class Stroj {
  final int id;
  String naziv;
  String? opis;

  Stroj({required this.id, required this.naziv, this.opis = "/"});

  factory Stroj.fromJson(Map<String, dynamic> json) {
    return Stroj(
      id: json['id'] as int,
      naziv: json['naziv'] as String,
    );
  }
}