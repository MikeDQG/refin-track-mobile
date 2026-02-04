// models/dogodek.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Dogodek {
  String id;  // Change from int to String for Firebase IDs
  String naziv;
  String opis;
  DateTime datum;
  bool aktiven;
  int stroj_id;
  
  Dogodek({
    required this.id,
    required this.naziv,
    required this.opis,
    required this.datum,
    this.aktiven = true,
    required this.stroj_id,
  });
  
  // Factory constructor for creating Dogodek from Firestore
  factory Dogodek.fromFirestore(Map<String, dynamic> data, String id) {
    return Dogodek(
      id: id, // Use document ID as dogodek_id
      naziv: data['naziv'] ?? '',
      opis: data['opis'] ?? '',
      datum: (data['datum'] as Timestamp).toDate(), // Convert Timestamp to DateTime
      aktiven: data['aktiven'] ?? false,
      stroj_id: data['stroj_id'] ?? 0,
    );
  }
  
  // Convert to map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'dogodek_id': id,
      'naziv': naziv,
      'opis': opis,
      'datum': Timestamp.fromDate(datum), // Convert DateTime to Timestamp
      'aktiven': aktiven,
      'stroj_id': stroj_id,
      'created_at': FieldValue.serverTimestamp(),
      'updated_at': FieldValue.serverTimestamp(),
    };
  }

  String displayDate() {
    return "${datum.year.toString()}-${datum.month.toString()}-${datum.day.toString()}";
  }
}