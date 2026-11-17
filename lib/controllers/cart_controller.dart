import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/cart_item_model.dart';
import '../services/hive_service.dart';

class CartController extends GetxController {
  Box<CartItem> get _box => Hive.box<CartItem>(HiveService.cartBoxName);

  
  var cartItems = <CartItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    
    _box.watch().listen((event) {
      loadCart();
    });
    loadCart(); 
  }

  
  void loadCart() {
    cartItems.assignAll(_box.values.toList());
  }

  
  List<CartItem> cartOf(String username) {
    return cartItems.where((e) => e.username == username).toList();
  }

  
  double totalOf(String username) {
    return cartOf(username).fold(0.0, (sum, e) => sum + e.price * e.quantity);
  }

    
  Future<bool> addToCart({
    required int productId,
    required String username,
    required String title,
    required double price,
    required String thumbnail,
    required int quantity,
    required int stock,
  }) async {
    CartItem? existing;
    for (final item in cartItems) {
      if (item.productId == productId && item.username == username) {
        existing = item;
        break;
      }
    }

    if (existing != null) {
      final newQty = existing.quantity + quantity;
      
      
      if (newQty > stock) {
        Get.snackbar(
          'Gagal',
          'Stok tidak mencukupi! Kamu sudah punya ${existing.quantity} di keranjang.',
          snackPosition: SnackPosition.TOP,
        );
        return false; 
      }
      
      existing.quantity = newQty;
      await existing.save();
    } else {
      
      if (quantity > stock) {
        Get.snackbar(
          'Gagal',
          'Stok tidak mencukupi!',
          snackPosition: SnackPosition.TOP,
        );
        return false;
      }
      
      final item = CartItem(
        productId: productId,
        username: username,
        title: title,
        price: price,
        thumbnail: thumbnail,
        quantity: quantity,
      );
      await _box.add(item);
    }
    loadCart(); 
    return true; 
  }

  Future<void> removeItem(CartItem item) async {
    await item.delete();
    loadCart(); 
  }
}