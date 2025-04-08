class Product {
  final String id;
  final String name;
  final String price;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['product_name'],
      price: json['product_price'],
      description: json['product_description'],
    );
  }
}
