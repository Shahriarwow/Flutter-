class ProductSort {
  static const latest = 0;
  static const popular = 1;
  static const priceHightTolow = 2;
  static const pricelowTohight = 3;
}

class ProductEntity {
  final int id;
  final String title;
  final int price;
  final int discount;
  final String imageURL;
  final int previousPrice;

  ProductEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        price = json['price'],
        discount = json['price'],
        imageURL = json['image'],
        previousPrice = json['previous_price'] ?? json['price'];
}
