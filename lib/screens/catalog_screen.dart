import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/product_data.dart';
import '../widgets/empty_catalog.dart';
import '../widgets/product_grid_card.dart';
import '../widgets/product_list_tile.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final List<Product> _products = List<Product>.of(initialProducts);
  bool _isGridView = true;
  int _nextId = 13;

  Future<void> _refreshCatalog() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!mounted) return;

    final newProduct = Product(
      id: _nextId++,
      title: 'Fresh Drop',
      category: 'Tops',
      price: 39.00,
      rating: 4.8,
      imageUrl: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=900&q=85',
      description: 'A new everyday essential, just added to the collection.',
    );

    setState(() => _products.insert(0, newProduct));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('A fresh piece just dropped!')));
  }

  void _deleteProduct(Product product) {
    final originalIndex = _products.indexWhere((item) => item.id == product.id);
    if (originalIndex == -1) return;
    setState(() => _products.removeAt(originalIndex));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text('${product.title} removed'),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'UNDO',
          textColor: const Color(0xFFFFC66D),
          onPressed: () {
            if (!mounted) return;
            setState(() => _products.insert(originalIndex.clamp(0, _products.length).toInt(), product));
          },
        ),
      ));
  }

  void _resetCatalog() {
    setState(() {
      _products..clear()..addAll(initialProducts);
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The collection is back')));
  }

  Widget _dismissBackground() => Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    decoration: BoxDecoration(color: const Color(0xFFFF777D), borderRadius: BorderRadius.circular(20)),
    alignment: Alignment.centerRight,
    padding: const EdgeInsets.only(right: 22),
    child: const Icon(Icons.delete_outline_rounded, color: Colors.white, size: 27),
  );

  Widget _buildList() => ListView.separated(
    physics: const AlwaysScrollableScrollPhysics(),
    padding: const EdgeInsets.only(top: 10, bottom: 28),
    itemCount: _products.length,
    separatorBuilder: (_, __) => const SizedBox(height: 2),
    itemBuilder: (context, index) {
      final product = _products[index];
      return Dismissible(
        key: ValueKey(product.id),
        direction: DismissDirection.endToStart,
        background: _dismissBackground(),
        onDismissed: (_) => _deleteProduct(product),
        child: ProductListTile(product: product),
      );
    },
  );

  Widget _buildGrid() => GridView.builder(
    physics: const AlwaysScrollableScrollPhysics(),
    padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 13,
      mainAxisSpacing: 14,
      childAspectRatio: 0.72,
    ),
    itemCount: _products.length,
    itemBuilder: (context, index) {
      final product = _products[index];
      return Dismissible(
        key: ValueKey(product.id),
        direction: DismissDirection.endToStart,
        background: _dismissBackground(),
        onDismissed: (_) => _deleteProduct(product),
        child: ProductGridCard(product: product),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        backgroundColor: const Color(0xFFFFFCF8),
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: const SizedBox.shrink(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              tooltip: _isGridView ? 'Switch to list view' : 'Switch to grid view',
              onPressed: () => setState(() => _isGridView = !_isGridView),
              style: IconButton.styleFrom(
                backgroundColor: const Color(0xFFF2EEFF),
                foregroundColor: const Color(0xFF8069D7),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              icon: Icon(_isGridView ? Icons.view_list_rounded : Icons.grid_view_rounded),
            ),
          ),
        ],
      ),
      floatingActionButton: _products.isNotEmpty
          ? FloatingActionButton.small(
              onPressed: _resetCatalog,
              tooltip: 'Restore catalog',
              backgroundColor: const Color(0xFFFFC66D),
              foregroundColor: const Color(0xFF29243B),
              child: const Icon(Icons.refresh_rounded),
            )
          : null,
      body: SafeArea(
        top: false,
        child: _products.isEmpty
            ? EmptyCatalog(onReset: _resetCatalog)
            : RefreshIndicator(
                onRefresh: _refreshCatalog,
                color: const Color(0xFF8B72E8),
                backgroundColor: Colors.white,
                child: _isGridView ? _buildGrid() : _buildList(),
              ),
      ),
    );
  }
}
