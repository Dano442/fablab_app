import 'package:fablab_app/presentation/views/cards.dart';
import 'package:flutter/material.dart';

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido al Panel Administrativoo'),
      ),

      body: CardsViews(),
    );
  }
}




