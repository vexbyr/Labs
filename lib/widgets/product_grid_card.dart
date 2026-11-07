import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductGridCard extends StatelessWidget {
  final Product product;
  const ProductGridCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF0EDF5)),
        boxShadow: const [BoxShadow(color: Color(0x0D33264D), blurRadius: 16, offset: Offset(0, 7))],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          flex: 7,
          child: Stack(fit: StackFit.expand, children: [
            Image.network(product.imageUrl, fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: const Color(0xFFF1ECFF), child: const Icon(Icons.checkroom_rounded, size: 42, color: Color(0xFF8B72E8))),
              loadingBuilder: (context, child, progress) => progress == null ? child : Container(color: const Color(0xFFF5F1FF), alignment: Alignment.center, child: const CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF8B72E8))),
            ),
            Positioned(top: 9, right: 9, child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
              decoration: BoxDecoration(color: const Color(0xFFFFFDF9).withOpacity(.94), borderRadius: BorderRadius.circular(20)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.star_rounded, color: Color(0xFFFFA83D), size: 13), const SizedBox(width: 3), Text(product.rating.toStringAsFixed(1), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800))]),
            )),
          ]),
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(11, 9, 11, 8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(product.category.toUpperCase(), style: const TextStyle(fontSize: 9, letterSpacing: 1.1, fontWeight: FontWeight.w800, color: Color(0xFF927DE0))),
              Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF29243B))),
              Text('\$${product.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: Color(0xFF29243B))),
            ]),
          ),
        ),
      ]),
    );
  }
}
