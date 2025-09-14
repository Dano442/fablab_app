import 'package:fablab_app/presentation/views/cards.dart';
import 'package:flutter/material.dart';

class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido al Panel Administrativo'),
      ),

      body: CardsViews(),
    );
  }
}




