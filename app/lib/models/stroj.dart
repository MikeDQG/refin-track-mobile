class Stroj {
  final int id;
  final String naziv;

  Stroj({required this.id, required this.naziv});

  factory Stroj.fromJson(Map<String, dynamic> json) {
    return Stroj(
      id: json['id'] as int,
      naziv: json['naziv'] as String,
    );
  }
}