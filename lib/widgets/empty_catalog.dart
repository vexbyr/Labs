import 'package:flutter/material.dart';

class EmptyCatalog extends StatelessWidget {
  final VoidCallback onReset;
  const EmptyCatalog({super.key, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: const BoxDecoration(color: Color(0xFFE7EFFF), shape: BoxShape.circle),
              child: const Icon(Icons.shopping_bag_outlined, size: 54, color: Color(0xFF2563EB)),
            ),
            const SizedBox(height: 20),
            const Text('Catalog is Empty', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            const Text('All products have been removed. Restore the catalog to see them again.',
                textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF64748B), height: 1.4)),
            const SizedBox(height: 20),
            FilledButton.icon(onPressed: onReset, icon: const Icon(Icons.refresh), label: const Text('Reset Catalog')),
          ],
        ),
      ),
    );
  }
}
