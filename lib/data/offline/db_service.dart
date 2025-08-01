import 'dart:io';
import 'package:api_testing_app/model/carts_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  DbService._();
  static final DbService _instance = DbService._();
  factory DbService() => _instance;

  Database? database;

  static const String CARTS_TABLE = "carts";
  static const String PRODUCTS_TABLE = "products";

  static const String COL_ID = "id";

  static const String COL_USER_ID = "userId";
  static const String COL_TOTAL = "total";
  static const String COL_DISCOUNTED_TOTAL = "discountedTotal";

  static const String COL_PK = "pk";
  static const String COL_PRODUCT_ID = "productId";
  static const String COL_CART_ID = "cartId";
  static const String COL_TITLE = "title";
  static const String COL_PRICE = "price";
  static const String COL_QUANTITY = "quantity";
  static const String COL_DISCOUNT_PERCENTAGE = "discountPercentage";
  static const String COL_THUMBNAIL = "thumbnail";

  Future<Database> initDB() async {
    database ??= await createDb();
    return database!;
  }

  Future<Database> createDb() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String path = join(appDir.path, "mydb.db");

    return openDatabase(path, version: 1,
        onCreate: (Database db, version) async {
      await db.execute('''
        CREATE TABLE $CARTS_TABLE (
          $COL_ID INTEGER PRIMARY KEY,
          $COL_USER_ID INTEGER,
          $COL_TOTAL REAL,
          $COL_DISCOUNTED_TOTAL REAL
        )
      ''');

      await db.execute('''
        CREATE TABLE $PRODUCTS_TABLE (
          $COL_PK INTEGER PRIMARY KEY AUTOINCREMENT,
          $COL_PRODUCT_ID INTEGER,
          $COL_CART_ID INTEGER,
          $COL_TITLE TEXT,
          $COL_PRICE REAL,
          $COL_QUANTITY INTEGER,
          $COL_TOTAL REAL,
          $COL_DISCOUNT_PERCENTAGE REAL,
          $COL_DISCOUNTED_TOTAL REAL,
          $COL_THUMBNAIL TEXT
        )
      ''');
    });
  }

  Future<void> cacheCarts(CartsModel model) async {
    final db = await initDB();
    await db.delete(CARTS_TABLE);
    await db.delete(PRODUCTS_TABLE);

    for (final cart in model.carts) {
      await db.insert(CARTS_TABLE, {
        COL_ID: cart.id,
        COL_USER_ID: cart.userId,
        COL_TOTAL: cart.total,
        COL_DISCOUNTED_TOTAL: cart.discountedTotal,
      });

      for (final p in cart.products) {
        await db.insert(PRODUCTS_TABLE, {
          COL_PRODUCT_ID: p.id,
          COL_CART_ID: cart.id,
          COL_TITLE: p.title,
          COL_PRICE: p.price,
          COL_QUANTITY: p.quantity,
          COL_TOTAL: p.total,
          COL_DISCOUNT_PERCENTAGE: p.discountPercentage,
          COL_DISCOUNTED_TOTAL: p.discountedTotal,
          COL_THUMBNAIL: p.thumbnail,
        });
      }
    }
  }

  Future<CartsModel?> getCachedCarts() async {
    final db = await initDB();
    final cartRows = await db.query(CARTS_TABLE);
    final productRows = await db.query(PRODUCTS_TABLE);

    if (cartRows.isEmpty) return null;

    final carts = cartRows.map((cartMap) {
      final products = productRows
          .where((p) => p[COL_CART_ID] == cartMap[COL_ID])
          .map((json) => Products.fromJson({
                "id": json[COL_PRODUCT_ID],
                "title": json[COL_TITLE],
                "price": json[COL_PRICE],
                "quantity": json[COL_QUANTITY],
                "total": json[COL_TOTAL],
                "discountPercentage": json[COL_DISCOUNT_PERCENTAGE],
                "discountedTotal": json[COL_DISCOUNTED_TOTAL],
                "thumbnail": json[COL_THUMBNAIL],
              }))
          .toList();

      return Carts(
        id: cartMap[COL_ID] as int,
        userId: cartMap[COL_USER_ID] as int,
        total: cartMap[COL_TOTAL] as num,
        discountedTotal: cartMap[COL_DISCOUNTED_TOTAL] as num,
        totalProducts: products.length,
        totalQuantity: products.fold(0, (sum, p) => sum + p.quantity),
        products: products,
      );
    }).toList();

    return CartsModel(
      carts: carts,
      total: carts.length,
      skip: 0,
      limit: carts.length,
    );
  }
}
