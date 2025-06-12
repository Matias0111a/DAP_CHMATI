import 'package:flutter_riverpod/flutter_riverpod.dart';

class Banda {
  final String nombre;
  final String integrantes;
  final String image;
  final String? origen;

  Banda({
    required this.nombre,
    required this.integrantes,
    required this.image,
    this.origen,
  });

}

List<Banda> bandasList = [
  Banda(
    nombre: 'The Beatles',
    integrantes: 'John, Paul, George, Ringo',
    image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d8/The_Beatles_members_at_New_York_City_in_1964.jpg/960px-The_Beatles_members_at_New_York_City_in_1964.jpg',
    origen: 'Reino Unido', 
  ),
  Banda(
    nombre: 'Pescado Rabioso',
    integrantes: 'Luis Alberto, Patricia, Osvaldo',
    image: 'https://upload.wikimedia.org/wikipedia/commons/a/a3/Pescado_Rabioso_1972-3.jpg',
    origen: 'Argentina',
  ),  
  Banda(
    nombre: 'Soda Stereo',
    integrantes: 'Gustavo, Zeta, Charly',
    image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-olJLNbKWGKB19zAcm6X7wBxp7pR4oY2HjA&s',
    origen: 'Argentina',
  ),
];

//MOVER PROVIDER A CARPETA PROVIDER !
final bandasProvider = StateNotifierProvider<BandasNotifier, List<Banda>>(
  (ref) => BandasNotifier(),
);

class BandasNotifier extends StateNotifier<List<Banda>> {
  BandasNotifier() : super(bandasList);

  void add(Banda banda) {
    state = [...state, banda];
  }
}
