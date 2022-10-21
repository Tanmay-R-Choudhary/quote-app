import 'package:quotes/utils/data_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseController {
  static const _databaseName = "quoteData.db";
  static const _databaseVersion = 1;
  static const table = "quotes";
  static const quoteId = 'id';
  static const quoteContent = 'content';
  static const quoteAuthor = 'author';
  DatabaseController._privateConstructor();

  static final DatabaseController instance =
      DatabaseController._privateConstructor();

  static late Database _database;
  bool isInitialised = false;

  Future<Database> get database async {
    if (isInitialised) return _database;
    _database = await _initDatabase();
    isInitialised = true;
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table ($quoteId STRING NOT NULL, $quoteContent STRING NOT NULL, $quoteAuthor STRING NOT NULL)
      ''');
  }

  Future<int> insert(Quote quote) async {
    Database db = await instance.database;
    var res = await db.insert(table, quote.toMap());
    return res;
  }

  Future<List<Map<String, dynamic>>> searchFilter(String searchText) async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        "SELECT * FROM $table WHERE $quoteContent like ?", ["%$searchText%"]);
    return res;
  }

  Future<List<Map<String, dynamic>>> getAllRows() async {
    Database db = await instance.database;
    var res = await db.query(table, orderBy: "$quoteId DESC");
    return res;
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String id) async {
    Database db = await instance.database;
    var res = await db.query(table, where: "$quoteId = ?", whereArgs: [id]);
    return res;
  }

  Future<int> delete(String id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$quoteId = ?', whereArgs: [id]);
  }
}
