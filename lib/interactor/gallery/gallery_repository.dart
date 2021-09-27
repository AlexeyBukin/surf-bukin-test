import 'package:surf/domain/product.dart';

abstract class GalleryRepository {
  Future<List<Product>> getProducts({
    String? category,
    bool? reverseSort,
    int offset = 0,
    int? quantity,
  });

  Future<List<String>> getCategories();
}

class TestGalleryRepository implements GalleryRepository {
  List<String> categories = [
    for (int i = 0; i < 10; i++) 'Category $i',
  ];

  List<Product> products = [
    for (int i = 0; i < 100; i++)
      Product(id: i, name: 'Product $i', category: 'Category ${i % 10}'),
  ];

  TestGalleryRepository();

  @override
  Future<List<String>> getCategories() async {
    return categories;
  }

  @override
  Future<List<Product>> getProducts({
    int offset = 0,
    int? quantity,
    String? category,
    bool? reverseSort,
  }) async {
    var list = products;
    if (category != null) {
      list = products.where((product) => product.category == category).toList();
    }
    final trueOffset = offset > list.length ? list.length : offset;
    var trueQuantity = quantity ?? list.length;
    trueQuantity = trueOffset + trueQuantity > list.length
        ? list.length - trueOffset
        : trueQuantity;
    list = products.sublist(trueOffset, trueOffset + trueQuantity);
    if (reverseSort ?? false) {
      list = list.reversed.toList();
    }
    return list;
  }
}
