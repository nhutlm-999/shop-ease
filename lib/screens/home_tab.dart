import 'package:flutter/material.dart';
import 'package:shop_ease/models/product.dart';
import 'package:shop_ease/repositories/product_repository.dart';
import 'package:shop_ease/widgets/product_card.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final _repo = ProductRepository();

  List<Product> _allProducts = [];
  List<Product> _filtered = [];
  String _searchQuery = '';
  String? _selectedCategory;

  // Danh sách categories lấy từ API
  final List<String> _categories = [
    'all',
    "electronics",
    "jewelery",
    "men's clothing",
    "women's clothing",
  ];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final products = await _repo.getProducts();
      setState(() {
        _allProducts = products;
        _filtered = products;
      });
    } catch (e) {
      // Handle error
      throw Exception('Error loading products: $e');
    }
  }

  // Áp dụng filter + search mỗi khi thay đổi
  void _applyFilters() {
    setState(() {
      _filtered = _allProducts.where((p) {
        final matchSearch = p.title.toLowerCase().contains(
          _searchQuery.toLowerCase(),
        );
        final matchCategory =
            _selectedCategory == null ||
            _selectedCategory == 'all' ||
            p.category == _selectedCategory;
        return matchSearch && matchCategory;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShopEase'),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Tìm sản phẩm...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (v) {
                _searchQuery = v;
                _applyFilters();
              },
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          // Dropdown filter
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final cat = _categories[i];
                final isSelected = (_selectedCategory ?? 'all') == cat;
                return FilterChip(
                  label: Text(cat == 'all' ? 'Tất cả' : cat),
                  selected: isSelected,
                  onSelected: (_) {
                    _selectedCategory = cat;
                    _applyFilters();
                  },
                );
              },
            ),
          ),

          // Product list
          // ── PRODUCT GRID ─────────────────────────
          Expanded(
            child: _filtered.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : LayoutBuilder(
                    builder: (context, constraints) {
                      final cols = constraints.maxWidth >= 600 ? 3 : 2;
                      return GridView.builder(
                        padding: const EdgeInsets.all(12),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: cols,
                          childAspectRatio: 0.68,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: _filtered.length,
                        itemBuilder: (_, i) =>
                            ProductCard(product: _filtered[i]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
