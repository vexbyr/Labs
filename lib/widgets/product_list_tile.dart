import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductListTile extends StatelessWidget {
  final Product product;
  const ProductListTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFF0EDF5))),
      child: Row(children: [
        ClipRRect(borderRadius: BorderRadius.circular(14), child: Image.network(product.imageUrl, width: 76, height: 82, fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(width: 76, height: 82, color: const Color(0xFFF1ECFF), child: const Icon(Icons.checkroom_rounded, color: Color(0xFF8B72E8))),
        )),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(product.category.toUpperCase(), style: const TextStyle(fontSize: 9, letterSpacing: 1, color: Color(0xFF927DE0), fontWeight: FontWeight.w800)),
          const SizedBox(height: 5),
          Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
          const SizedBox(height: 7),
          Row(children: [const Icon(Icons.star_rounded, color: Color(0xFFFFA83D), size: 15), const SizedBox(width: 3), Text(product.rating.toStringAsFixed(1), style: const TextStyle(fontSize: 11, color: Color(0xFF777286)))]),
        ])),
        Text('\$${product.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900)),
        const SizedBox(width: 5),
      ]),
    );
  }
}
