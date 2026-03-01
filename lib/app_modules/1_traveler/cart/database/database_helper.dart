import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/cart_item_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'cart_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cart_items(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productId INTEGER NOT NULL,
        productName TEXT NOT NULL,
        productDescription TEXT NOT NULL,
        productPrice REAL NOT NULL,
        productImage TEXT NOT NULL,
        productBrand TEXT NOT NULL,
        size TEXT NOT NULL,
        color TEXT NOT NULL,
        rentalDays INTEGER NOT NULL,
        partnerId INTEGER NOT NULL,
        quantity INTEGER NOT NULL,
        addedAt INTEGER NOT NULL
      )
    ''');
  }

  // Add item to cart
  Future<int> addToCart(CartItem item) async {
    final db = await database;

    // Check if item already exists in cart
    final existingItems = await db.query(
      'cart_items',
      where: 'productId = ? AND size = ? AND rentalDays = ?',
      whereArgs: [item.productId, item.size, item.rentalDays],
    );

    if (existingItems.isNotEmpty) {
      // Update quantity if item exists
      final existingItem = CartItem.fromMap(existingItems.first);
      return await updateQuantity(
        existingItem.id!,
        existingItem.quantity + item.quantity,
      );
    } else {
      // Insert new item
      return await db.insert('cart_items', item.toMap());
    }
  }

  // Get all cart items
  Future<List<CartItem>> getCartItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'cart_items',
      orderBy: 'addedAt DESC',
    );
    return List.generate(maps.length, (i) => CartItem.fromMap(maps[i]));
  }

  // Update quantity
  Future<int> updateQuantity(int id, int newQuantity) async {
    final db = await database;
    return await db.update(
      'cart_items',
      {'quantity': newQuantity},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Remove item from cart
  Future<int> removeFromCart(int id) async {
    final db = await database;
    return await db.delete('cart_items', where: 'id = ?', whereArgs: [id]);
  }

  // Clear entire cart
  Future<int> clearCart() async {
    final db = await database;
    return await db.delete('cart_items');
  }

  // Get cart items count
  Future<int> getCartItemsCount() async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT SUM(quantity) as count FROM cart_items',
    );
    final count = result.first['count'] as int?;
    return count ?? 0;
  }

  // Get total cart value
  Future<double> getCartTotal() async {
    final db = await database;
    final result = await db.rawQuery('''
      SELECT SUM(productPrice * quantity * rentalDays) as total 
      FROM cart_items
    ''');
    final total = result.first['total'] as double?;
    return total ?? 0.0;
  }

  // Check if product exists in cart
  Future<bool> isProductInCart(
    int productId,
    String size,
    int rentalDays,
  ) async {
    final db = await database;
    final result = await db.query(
      'cart_items',
      where: 'productId = ? AND size = ? AND rentalDays = ?',
      whereArgs: [productId, size, rentalDays],
    );
    return result.isNotEmpty;
  }

  // Close database
  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
