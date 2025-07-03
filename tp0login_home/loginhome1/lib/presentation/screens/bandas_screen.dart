import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loginhome1/entities/bandas.dart';
import 'package:loginhome1/presentation/providers/bandas_provider.dart';

// Pantalla que muestra la lista de bandas usando Riverpod para el manejo de estado
class BandasScreen extends ConsumerWidget {
  static const String name = 'bandas_screen';
  const BandasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Escucha el provider de bandas de forma reactiva
    final bandas = ref.watch(bandasProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Bandas"),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      // Lista de bandas
      body: ListView.builder(
        itemCount: bandas.length, // Número de bandas en la lista
        itemBuilder: (context, index) {
          final banda = bandas[index]; // Banda actual
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              onTap: () => {
                showDialog(
                  context: context,
                  builder: (context) {
                    // Muestra un diálogo con la información de la banda
                    return AlertDialog(
                      title: Text(banda.nombre),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Imagen de la banda si existe
                          if (banda.image != null && banda.image!.isNotEmpty)
                            Image.network(
                              banda.image!,
                              width: 100,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          const SizedBox(height: 8),
                          Text('Integrantes: ${banda.integrantes}'),
                          if (banda.origen != null)
                            Text('Origen: ${banda.origen}'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cerrar'),
                        ),
                      ],
                    );
                  },
                )
              },
              // Muestra la imagen si existe
              leading: (banda.image != null && banda.image!.isNotEmpty)
                  ? Image.network(
                      banda.image!,
                      width: 70,
                      height: 60,
                      fit: BoxFit.cover,
                    )
                  : null,
              // Nombre de la banda
              title: Text(
                banda.nombre,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              // Información adicional de la banda
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Integrantes: ${banda.integrantes}'),
                  if (banda.origen != null) Text('Origen: ${banda.origen}'),
                ],
              ),
              isThreeLine: true,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Botón para editar la banda | arriba del mismo iría un GestureDector con un onTap: ()
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    tooltip: 'Editar banda',
                    onPressed: () {
                      // Muestra un diálogo para editar la banda
                      showDialog(
                        context: context,
                        builder: (context) {
                          // Controladores para los campos del formulario
                          final nombreController =
                              TextEditingController(text: banda.nombre);
                          final integrantesController = TextEditingController(
                              text: banda.integrantes);
                          final imageController = TextEditingController(
                              text: banda.image ?? '');
                          final origenController = TextEditingController(
                              text: banda.origen ?? '');

                          return AlertDialog(
                            title: const Text('Editar Banda'),
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Campo para el nombre
                                  TextField(
                                    controller: nombreController,
                                    decoration:
                                        const InputDecoration(labelText: 'Nombre'),
                                  ),
                                  // Campo para los integrantes
                                  TextField(
                                    controller: integrantesController,
                                    decoration: const InputDecoration(
                                        labelText: 'Integrantes'),
                                  ),
                                  // Campo para la imagen
                                  TextField(
                                    controller: imageController,
                                    decoration:
                                        const InputDecoration(labelText: 'Imagen URL'),
                                  ),
                                  // Campo para el origen
                                  TextField(
                                    controller: origenController,
                                    decoration:
                                        const InputDecoration(labelText: 'Origen'),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              // Botón para cancelar la edición
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Cancelar'),
                              ),
                              // Botón para guardar los cambios
                              ElevatedButton(
                                onPressed: () {
                                  final nombre = nombreController.text.trim();
                                  final integrantes = integrantesController.text.trim();
                                  // Validación de campos obligatorios
                                  if (nombre.isEmpty || integrantes.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Nombre e integrantes son obligatorios'),
                                        backgroundColor: Colors.red,
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                    return;
                                  }
                                  // Crea una nueva instancia de Banda con los datos editados
                                  final nuevo = Banda(
                                    nombre: nombre,
                                    integrantes: integrantes,
                                    image: imageController.text.trim().isEmpty
                                        ? null
                                        : imageController.text.trim(),
                                    origen: origenController.text.trim().isEmpty
                                        ? null
                                        : origenController.text.trim(),
                                  );
                                  // Actualiza la banda en el provider
                                  ref.read(bandasProvider.notifier).update(banda, nuevo);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Guardar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  // Botón para eliminar la banda
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // Elimina la banda usando el notifier del provider
                      ref.read(bandasProvider.notifier).remove(banda);
                    },
                    tooltip: 'Eliminar banda',
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navega a la pantalla de agregar banda
          GoRouter.of(context).push('/add_band_screen');
        },
        tooltip: 'Agregar Banda',
        child: const Icon(Icons.add),
      ),
    );
  }
}