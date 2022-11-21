import '../../models/product.dart';

class ProductsManager {
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Nike_Air_Jordan_1_Retro_High_Og',
      description: 'Nike_air_jordan_1_retro_high_og',
      price: 160,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/4/44/Nike_air_jordan_1_retro_high_og.jpg',
      isFavorite: true,
    ),
    Product(
      id: 'p2',
      title: 'Nike_Air_Jordan_1_Zoom_Air_Comfort',
      description: 'Nike_Air_Jordan_1_Zoom_Air_Comfort',
      price: 170,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/4/47/Air_Jordan_1_Zoom_Air_Comfort.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Nike_Air_Jordan_1_High_Dior',
      description: 'Nike_Air_Jordan_1_High_Dior',
      price: 6.500,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/0/07/Nike_Air_Jordan_1_High_Dior.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Nike_Air_Jordan_1_High_OG_UNC_University_Blue',
      description: 'Nike_Air_Jordan_1_High_OG_UNC_University_Blue',
      price: 410,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/7/72/Nike_Air_Jordan_1_High_OG_UNC_University_Blue.jpg',
      isFavorite: true,
    )
  ];

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
}
