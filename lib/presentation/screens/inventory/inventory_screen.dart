import 'package:flutter/material.dart';
import 'tool_card.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final List<Tool> _tools = [
    Tool(
      name: "Taladro inalámbrico",
      code: "TL-001",
      imageUrl: "https://picsum.photos/200?random=1",
      quantity: 5,
      available: true,
    ),
    Tool(
      name: "Impresora 3D",
      code: "PR-002",
      imageUrl: "https://picsum.photos/200?random=2",
      quantity: 2,
      available: false,
    ),
  ];

  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final filteredTools = _tools
        .where((tool) =>
            tool.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            tool.code.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar herramienta...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: colors.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          const SizedBox(height: 8),


          Expanded(
            child: ListView.builder(
              itemCount: filteredTools.length,
              itemBuilder: (context, index) {
                return ToolCard(tool: filteredTools[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
