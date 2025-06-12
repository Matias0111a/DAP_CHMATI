import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loginhome1/entities/bandas.dart';

final bandasProvider = Provider<List<Banda>>((ref) => bandasList);

class AddScreen extends ConsumerWidget {

  static const String name = 'add_band_screen';
  const AddScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Añadir Banda"),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      
        )
    );
  }

}