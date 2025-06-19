import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loginhome1/entities/bandas.dart';
import 'package:go_router/go_router.dart';
import 'package:loginhome1/presentation/providers/bandas_provider.dart';
class AddScreen extends ConsumerStatefulWidget {
  static const String name = 'add_band_screen';
  const AddScreen({super.key});

  @override
  ConsumerState<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends ConsumerState<AddScreen> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController integrantesController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController originController = TextEditingController();

  @override
  void dispose() {
    nombreController.dispose();
    integrantesController.dispose();
    imageController.dispose();
    originController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Añadir Banda"),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              const Text('Ingrese los datos de la banda'),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: nombreController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Nombre',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: integrantesController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Integrantes',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: imageController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Imagen URL',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: originController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Origen',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final nombre = nombreController.text.trim();
                  final integrantes = integrantesController.text.trim();
                  if(nombre.isEmpty || integrantes.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Completar todos los campos'),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }
                  final nuevaBanda = Banda(
                    nombre: nombreController.text,
                    integrantes: integrantesController.text,
                    image: imageController.text,
                    origen: originController.text.isNotEmpty ? originController.text : null,
                  );
                  ref.read(bandasProvider.notifier).add(nuevaBanda);
                  GoRouter.of(context).go('/bandas');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Banda ${nuevaBanda.nombre} añadida correctamente'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text('Añadir Banda', style: TextStyle(fontSize: 20, color: Colors.black)),
              )
            ]
          )
        ), 
      ),
    );
  }
}