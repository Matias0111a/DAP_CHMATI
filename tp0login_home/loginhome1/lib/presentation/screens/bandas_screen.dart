import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loginhome1/entities/bandas.dart';

final bandasProvider = Provider<List<Banda>>((ref) => bandasList);

class BandasScreen extends ConsumerWidget {
  static const String name = 'bandas_screen';
  const BandasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: ListView.builder(
        itemCount: bandas.length,
        itemBuilder: (context, index) {
          final banda = bandas[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              leading: Image.network(
                banda.image,
                width: 70,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Text(
                banda.nombre,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Integrantes: ${banda.integrantes}'),
                  if (banda.origen != null) Text('Origen: ${banda.origen}'),
                ],
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}