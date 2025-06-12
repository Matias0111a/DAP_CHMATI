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
 List<Banda>  bandasList = [
  Banda(
    nombre: 'The Beatles',
    integrantes: 'John, Paul, George, Ringo',
    image: 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d8/The_Beatles_members_at_New_York_City_in_1964.jpg/960px-The_Beatles_members_at_New_York_City_in_1964.jpg',
    origen: 'Reino Unido', 
  ),
  Banda(
    nombre: 'Rolling Stones',
    integrantes: 'Mick, Keith, Charlie, Ronnie',
    image: 'https://tn.com.ar/resizer/v2/la-iconica-banda-lleva-seis-decadas-al-mas-alto-nivel-TMQOZJHKQJCFWLEUSYWQ4LDSD4.jpg?auth=130216f86665c506120e69445c95fc351bf7c84ff643915cfd963d9582b31467&width=1440',
    origen: 'Reino Unido',
  ),
  Banda(
    nombre: 'Seru Girán',
    integrantes: 'Charly, David, Oscar, Pedro',
    image: 'https://inamu.musica.ar/uploads/paginas/imagenes/lg/e4b2aadde1b2c527c76755c9d345b5e5.jpg',
    origen: 'Argentina',
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
