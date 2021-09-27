class Product {
  String name;
  String? category;
  int id;
  int? price;

  Product({
    required this.id,
    required this.name,
    this.category,
  });
}
