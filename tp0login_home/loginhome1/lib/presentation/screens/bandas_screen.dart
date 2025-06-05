import 'package:flutter/material.dart';
import 'package:loginhome1/entities/bandas.dart';

class BandasScreen extends StatefulWidget {
  static const String name = 'bandas_screen';
  const BandasScreen({super.key});
  @override
  State<BandasScreen> createState() => _BandasScreenState();
}

class _BandasScreenState extends State<BandasScreen> {
  @override
  Widget build(BuildContext context) {
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
      itemCount: bandasList.length,
      itemBuilder: (context, index) {
        final banda = bandasList[index];
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
            fontSize: 18),
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
    
  } // build
}