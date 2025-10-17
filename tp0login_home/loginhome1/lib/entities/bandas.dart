import 'package:cloud_firestore/cloud_firestore.dart';

class Banda {
  final String? id; // Puede ser null antes de guardarse en Firestore
  final String nombre;
  final String integrantes;
  final String? image;
  final String? origen;
  final String? descripcion;

  Banda({
    this.id,
    required this.nombre,
    required this.integrantes,
    this.image,
    this.origen,
    this.descripcion,
  });

  Banda copyWith({
    String? id,
    String? nombre,
    String? integrantes,
    String? image,
    String? origen,
    String? descripcion,
  }) {
    return Banda(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      integrantes: integrantes ?? this.integrantes,
      image: image ?? this.image,
      origen: origen ?? this.origen,
      descripcion: descripcion ?? this.descripcion,
    );
  }

  /// Convierte el objeto Banda en un mapa para Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'nombre': nombre,
      'integrantes': integrantes,
      'image': image,
      'origen': origen,
      'descripcion': descripcion,
    };
  }

  static Banda fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Banda(
      id: snapshot.id,
      nombre: data?['nombre'] ?? '',
      integrantes: data?['integrantes'] ?? '',
      image: data?['image'],
      origen: data?['origen'],
      descripcion: data?['descripcion'],
    );
  }
}
