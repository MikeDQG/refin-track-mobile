class Dogodek {
  int id;
  String naziv;
  DateTime datum;
  String opis;
  bool aktiven;
  int stroj_id;

  Dogodek({
    required this.id,
    required this.naziv,
    required this.datum,
    required this.opis,
    this.aktiven = true,
    required this.stroj_id,
  });
}