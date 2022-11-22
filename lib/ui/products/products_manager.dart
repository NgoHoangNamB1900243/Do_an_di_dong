import 'package:flutter/foundation.dart';

import '../../models/product.dart';
import 'package:provider/provider.dart';
import '../products/edit_products_screen.dart';

import '../../models/auth_token.dart';
import '../../services/products_service.dart';

class ProductsManager with ChangeNotifier {
  List<Product> _items = [];

  final ProductsService _productsService;

  ProductsManager([AuthToken? authToken])
      : _productsService = ProductsService(authToken);

  set authToken(AuthToken? authToken) {
    _productsService.authToken = authToken;
  }

  Future<void> fetchProducts([bool filterByUser = false]) async {
    _items = await _productsService.fetchProducts(filterByUser);
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final newProduct = await _productsService.addProduct(product);
    if (newProduct != null) {
      _items.add(newProduct);
      notifyListeners();
    }
  }

  Future<void> updateProduct(Product product) async {
    final index = _items.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      if (await _productsService.updateProduct(product)) {
        _items[index] = product;
        notifyListeners();
      }
    }
  }

  Future<void> deleteProduct(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    Product? existingProduct = _items[index];
    _items.removeAt(index);
    notifyListeners();

    if (!await _productsService.deleteProduct(id)) {
      _items.insert(index, existingProduct);
      notifyListeners();
    }
  }

  Future<void> toggleFavoriteStatus(Product product) async {
    final savedStatus = product.isFavorite;
    product.isFavorite = !savedStatus;

    if (!await _productsService.saveFavoriteStatus(product)) {
      product.isFavorite = savedStatus;
    }
  }

  // final List<Product> _items = [
  //   Product(
  //     id: 'p1',
  //     title: 'Nike_Air_Jordan_1_Retro_High_Og',
  //     description: 'Nike_air_jordan_1_retro_high_og',
  //     price: 160,
  //     imageUrl:
  //         'https://upload.wikimedia.org/wikipedia/commons/4/44/Nike_air_jordan_1_retro_high_og.jpg',
  //     isFavorite: true,
  //   ),
  //   Product(
  //     id: 'p2',
  //     title: 'Nike_Air_Jordan_1_Zoom_Air_Comfort',
  //     description: 'Nike_Air_Jordan_1_Zoom_Air_Comfort',
  //     price: 170,
  //     imageUrl:
  //         'https://upload.wikimedia.org/wikipedia/commons/4/47/Air_Jordan_1_Zoom_Air_Comfort.jpg',
  //   ),
  //   Product(
  //     id: 'p3',
  //     title: 'Nike_Air_Jordan_1_High_Dior',
  //     description: 'Nike_Air_Jordan_1_High_Dior',
  //     price: 6.500,
  //     imageUrl:
  //         'https://upload.wikimedia.org/wikipedia/commons/0/07/Nike_Air_Jordan_1_High_Dior.jpg',
  //   ),
  //   Product(
  //     id: 'p4',
  //     title: 'Nike_Air_Jordan_1_High_OG_UNC_University_Blue',
  //     description: 'Nike_Air_Jordan_1_High_OG_UNC_University_Blue',
  //     price: 410,
  //     imageUrl:
  //         'https://upload.wikimedia.org/wikipedia/commons/7/72/Nike_Air_Jordan_1_High_OG_UNC_University_Blue.jpg',
  //     isFavorite: true,
  //   )
  // ];

  int get itemCount {
    return _items.length;
  }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((ProdItem) => ProdItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void addProduct(Product product) {
  //   _items.add(
  //     product.copyWith(
  //       id: 'p${DateTime.now().toIso8601String()}',
  //     ),
  //   );
  //   notifyListeners();
  // }

  // void updateProduct(Product product) {
  //   final index = _items.indexWhere((item) => item.id == product.id);
  //   if (index >= 0) {
  //     _items[index] = product;
  //     notifyListeners();
  //   }
  // }

  // void toggleFavoritesStatus(Product product) {
  //   final savedStatus = product.isFavorite;
  //   product.isFavorite = !savedStatus;
  // }

  // void deleteProduct(String id) {
  //   final index = _items.indexWhere((item) => item.id == id);
  //   _items.removeAt(index);
  //   notifyListeners();
  // }
}
