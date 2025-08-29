import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loginhome1/entities/bandas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final bandasProvider = StateNotifierProvider<BandasNotifier, List<Banda>>(
  (ref) => BandasNotifier(),
);

class BandasNotifier extends StateNotifier<List<Banda>> {
  final CollectionReference<Banda> _bandasRef =
      FirebaseFirestore.instance
          .collection('bandas')
          .withConverter<Banda>(
            fromFirestore: (snapshot, _) {
              final banda = Banda.fromFirestore(snapshot, options);              // Muy importante: asignamos el doc.id
              return banda.copyWith(id: snapshot.id);
            },
            toFirestore: (banda, options) => banda.toFirestore(),
          );

  BandasNotifier() : super([]) {
    // Escucha cambios en tiempo real y actualiza el estado
    _bandasRef.snapshots().listen((snapshot) {
      state = snapshot.docs.map((doc) {
        final banda = doc.data();
        return banda.copyWith(id: doc.id);
      }).toList();
    });
  }
  
  static SnapshotOptions? get options => null;

  /// Agregar banda a Firestore
  Future<void> add(Banda banda) async {
    await _bandasRef.add(banda);
  }

  /// Eliminar banda de Firestore
  Future<void> remove(Banda banda) async {
    if (banda.id == null) return;
    await _bandasRef.doc(banda.id).delete();
  }

  /// Actualizar banda en Firestore
  Future<void> update(Banda banda) async {
    if (banda.id == null) return;
    await _bandasRef.doc(banda.id).set(banda);
  }

  /// Subir todas las bandas locales a Firestore (solo si está vacío)
  Future<void> subirTodasBandas(List<Banda> bandasLocales) async {
    final snapshot = await _bandasRef.get();
    if (snapshot.docs.isEmpty) {
      for (final banda in bandasLocales) {
        await _bandasRef.add(banda);
      }
    }
  }
}
