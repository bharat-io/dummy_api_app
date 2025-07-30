class CartsModel {
  List<Carts> carts;
  int total;
  int skip;
  int limit;
  CartsModel(
      {required this.carts,
      required this.total,
      required this.skip,
      required this.limit});

  factory CartsModel.fromjson(Map<String, dynamic> json) {
    List<Carts> cartList =
        (json["carts"] as List).map((e) => Carts.fromJson(e)).toList();

    // for (Map<String, dynamic> eachCarts in json["carts"]) {
    //   Carts carts = Carts.fromJson(eachCarts);
    //   cartList.add(carts);
    // }
    return CartsModel(
      carts: cartList,
      total: json["total"],
      skip: json["skip"],
      limit: json["limit"],
    );
  }
}

class Carts {
  int id;
  List<Products> products;
  num total;
  num discountedTotal;
  int userId;
  int totalProducts;
  int totalQuantity;

  Carts({
    required this.id,
    required this.products,
    required this.total,
    required this.discountedTotal,
    required this.userId,
    required this.totalProducts,
    required this.totalQuantity,
  });

  factory Carts.fromJson(Map<String, dynamic> json) {
    final List<Products> productsList = [];
    for (Map<String, dynamic> eachProducts in json["products"]) {
      Products products = Products.fromJson(eachProducts);
      productsList.add(products);
    }
    return Carts(
      id: json["id"],
      products: productsList,
      total: json["total"],
      discountedTotal: json["discountedTotal"],
      userId: json["userId"],
      totalProducts: json["totalProducts"],
      totalQuantity: json["totalQuantity"],
    );
  }
}

class Products {
  int id;
  String title;
  num price;
  int quantity;
  num total;
  num discountPercentage;
  num discountedTotal;
  String thumbnail;

  Products({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.total,
    required this.discountPercentage,
    required this.discountedTotal,
    required this.thumbnail,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        quantity: json["quantity"],
        total: json["total"],
        discountPercentage: json["discountPercentage"],
        discountedTotal: json["discountedTotal"],
        thumbnail: json["thumbnail"]);
  }
}
