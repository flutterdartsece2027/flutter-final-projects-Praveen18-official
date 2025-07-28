import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../providers/cart_provider.dart';
import '../widgets/shimmer_loading.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String unit;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.unit,
  });
}

class BuyCropsScreen extends StatefulWidget {
  static const routeName = '/buy-crops';
  
  const BuyCropsScreen({super.key});

  @override
  State<BuyCropsScreen> createState() => _BuyCropsScreenState();
}

class _BuyCropsScreenState extends State<BuyCropsScreen> {
  bool _isLoading = true;
  final List<Product> _products = const [
    Product(
      id: '1',
      name: 'Tomatoes',
      description: 'Juicy, vine-ripened tomatoes',
      price: 3.49,
      unit: 'kg',
      imageUrl: 'https://images.pexels.com/photos/533360/pexels-photo-533360.jpeg',
    ),
    Product(
      id: '2',
      name: 'Potatoes',
      description: 'Fresh, creamy potatoes',
      price: 2.29,
      unit: 'kg',
      imageUrl: 'https://images.pexels.com/photos/144248/potatoes-vegetables-erdfrucht-bio-144248.jpeg',
    ),
    Product(
      id: '3',
      name: 'Carrots',
      description: 'Sweet and crunchy',
      price: 2.99,
      unit: 'bunch',
      imageUrl: 'https://images.pexels.com/photos/65174/pexels-photo-65174.jpeg',
    ),
    Product(
      id: '4',
      name: 'Apples',
      description: 'Sweet-tart and crisp',
      price: 4.99,
      unit: 'kg',
      imageUrl: 'https://images.pexels.com/photos/102104/pexels-photo-102104.jpeg',
    ),
    Product(
      id: '5',
      name: 'Bananas',
      description: 'Perfectly ripened',
      price: 1.29,
      unit: 'dozen',
      imageUrl: 'https://images.pexels.com/photos/1093038/pexels-photo-1093038.jpeg',
    ),
    Product(
      id: '6',
      name: 'Spinach',
      description: 'Tender and nutritious',
      price: 3.49,
      unit: '200g',
      imageUrl: 'https://images.pexels.com/photos/128420/pexels-photo-128420.jpeg',
    )
  ];

  @override
  void initState() {
    super.initState();
    // Simulate loading data
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Crops'),
        backgroundColor: Colors.green[800],
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Product grid with shimmer loading
          Expanded(
            child: _isLoading
                ? _buildShimmerGrid()
                : GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      final product = _products[index];
                      return _buildProductCard(context, product);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image with better error handling
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(
              height: 120,
              width: double.infinity,
              color: Colors.grey[100],
              child: Image.network(
                product.imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  padding: const EdgeInsets.all(20),
                  child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                ),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),
          // Product details
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  product.description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${product.price.toStringAsFixed(2)} / ${product.unit}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 14,
                      ),
                    ),
                    Consumer<CartProvider>(
                      builder: (context, cart, child) => IconButton(
                        icon: const Icon(Icons.add_shopping_cart, color: Colors.green),
                        onPressed: () {
                          cart.addItem(
                            product.id,
                            product.price,
                            product.name,
                            product.imageUrl,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product.name} added to cart!'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 6, // Number of shimmer placeholders
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shimmer for image
              const ShimmerLoading(
                height: 120,
                borderRadius: 12.0,
              ),
              // Shimmer for text
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ShimmerLoading(
                      height: 16,
                      width: 100,
                      borderRadius: 4.0,
                    ),
                    const SizedBox(height: 8),
                    const ShimmerLoading(
                      height: 14,
                      width: 80,
                      borderRadius: 4.0,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const ShimmerLoading(
                          height: 20,
                          width: 60,
                          borderRadius: 4.0,
                        ),
                        ShimmerLoading(
                          height: 36,
                          width: 36,
                          borderRadius: 18.0,
                          shape: BoxShape.circle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
