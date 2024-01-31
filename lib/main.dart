import 'package:flutter/material.dart';

import 'screen/list-cars.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista Carros',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const ListaCars(titulo: 'Race cars'),
    );
  }
}