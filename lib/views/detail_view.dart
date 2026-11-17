import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/cart_controller.dart';
import '../models/product_model.dart';

class DetailView extends StatefulWidget {
  final Product product;
  const DetailView({super.key, required this.product});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    final auth = Get.find<AuthController>();
    final cartC = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(p.thumbnail, height: 250)),
            const SizedBox(height: 20),
            
            Text(p.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text('Brand: No Brand | Category: ${p.category}', style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 10),
            
            Text('\$${p.price}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
            const SizedBox(height: 10),
            
            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 20),
                Text(' 4.5 | Stok: ${p.stock}'),
              ],
            ),
            const Divider(height: 30),
            
            const Text('Deskripsi:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(p.description, style: const TextStyle(height: 1.5)),
            const SizedBox(height: 30),

            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                Row(
                  children: [
                    IconButton(
                      onPressed: qty > 1 ? () => setState(() => qty--) : null,
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Text('$qty', style: const TextStyle(fontSize: 18)),
                    IconButton(
                      onPressed: () {
                        
                        if (qty < p.stock) {
                          setState(() => qty++);
                        } else {
                          Get.snackbar('Info', 'Stok maksimal hanya ${p.stock}', snackPosition: SnackPosition.TOP);
                        }
                      },
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),

                
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  onPressed: () async {
                    
                    final berhasil = await cartC.addToCart(
                      productId: p.id, 
                      username: auth.username.value, 
                      title: p.title,
                      price: p.price, 
                      thumbnail: p.thumbnail, 
                      quantity: qty, 
                      stock: p.stock,
                    );
                    
                    
                    if (berhasil) {
                      Get.back(); 
                      Get.snackbar(
                        'Sukses', 
                        '$qty ${p.title} masuk ke keranjang!', 
                        snackPosition: SnackPosition.TOP,
                      );
                    }
                  },
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text('Add to Cart'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}