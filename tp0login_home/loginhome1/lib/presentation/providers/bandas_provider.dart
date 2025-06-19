// Importa el paquete flutter_riverpod para la gestión de estado.
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Importa la entidad Banda desde el archivo correspondiente.
import 'package:loginhome1/entities/bandas.dart';

// Define un StateNotifierProvider que expone una lista de Bandas y su notificador.
final bandasProvider = StateNotifierProvider<BandasNotifier, List<Banda>>(
  (ref) => BandasNotifier(),
);

// Clase que extiende StateNotifier para manejar una lista de Bandas.
class BandasNotifier extends StateNotifier<List<Banda>> {
  // Inicializa el estado con la lista de bandas existente.
  BandasNotifier() : super(bandasList);

  // Método para agregar una nueva banda a la lista.
  void add(Banda banda) {
    state = [...state, banda];
  }

  // Método para eliminar una banda de la lista.
  void remove(Banda banda) {
    state = state.where((b) => b != banda).toList();
  }

  // Método para actualizar una banda existente en la lista.
  void update(Banda oldBanda, Banda newBanda) {
    state = [
      for (final b in state) if (b == oldBanda) newBanda else b
    ];
  }
}
