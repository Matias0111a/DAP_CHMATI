class Banda {
  final String nombre;
  final String integrantes;
  final String? image;
  final String? origen;

  Banda({
    required this.nombre,
    required this.integrantes,
    this.image,
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
    nombre: 'Serú Girán',
    integrantes: 'Charly, David, Oscar, Pedro',
    image: 'https://upload.wikimedia.org/wikipedia/commons/9/93/Seru_Giran_1978.jpg',
    origen: 'Argentina',
  ),
];
