import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/cart_controller.dart';
import '../controllers/product_controller.dart';
import '../widgets/product_card.dart';
import 'cart_view.dart';
import 'detail_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    final productC = Get.find<ProductController>();
    final cartC = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('Hai, ${auth.username.value}')),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          Obx(() {
            final total = cartC.cartOf(auth.username.value).length;
            return Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () => Get.to(() => const CartView()),
                ),
                if (total > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      child: Text('$total',
                          style: const TextStyle(
                              fontSize: 10, color: Colors.white)),
                    ),
                  ),
              ],
            );
          }),
        ],
      ),
      body: Obx(() {
        if (productC.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (productC.error.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(productC.error.value),
                const SizedBox(height: 8),
                ElevatedButton(
                    onPressed: productC.loadProducts,
                    child: const Text('Coba Lagi')),
              ],
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: productC.loadProducts,
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: productC.products.length,
            itemBuilder: (_, i) {
              final p = productC.products[i];
              return ProductCard(
                product: p,
                onTap: () => Get.to(() => DetailView(product: p)),
              );
            },
          ),
        );
      }),
    );
  }
}