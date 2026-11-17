import 'package:hive_flutter/hive_flutter.dart';
import '../models/cart_item_model.dart';

class HiveService {
  static const String cartBoxName = 'cartBox';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CartItemAdapter());
    await Hive.openBox<CartItem>(cartBoxName);
  }
}