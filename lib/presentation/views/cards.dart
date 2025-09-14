import 'package:flutter/material.dart';

const cards = <Map<String, dynamic>>[
  {'icon': Icons.folder, 'label': 'Proyectos', 'value': '23'},
  {'icon': Icons.people, 'label': 'Usuarios', 'value': '50'},
  {'icon': Icons.article, 'label': 'Noticias', 'value': '10'},
  {'icon': Icons.pending_actions, 'label': 'Solicitudes Pendientes', 'value': '7'},
];

class CardsViews extends StatelessWidget {
  const CardsViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          return _CardsView(
            icon: card['icon'],
            label: card['label'],
            value: card['value'],
          );
        },
      ),
    );
  }
}

class _CardsView extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _CardsView({
    required this.icon,
    required this.label,
    required this.value,
  });

@override
Widget build(BuildContext context) {
  final colors = Theme.of(context).colorScheme;

  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: colors.primary.withAlpha(26),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(12),
            child: Icon(
              icon,
              size: 40,
              color: colors.primary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: colors.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          if (value.isNotEmpty) ...[
            const SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: colors.onSurface
              ),
            ),
          ],
        ],
      ),
    ),
  );
}
}