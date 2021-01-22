import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = 'neostore.db';

  static final _databaseVersion = 1;

  static final table = 'address_table';

  static final columnId = 'address_id';

  static final columnAddress = 'address_name';

  static final DatabaseHelper instance = DatabaseHelper._private();

  DatabaseHelper._private() {
    print('Db helper generated ');
  }

  static Database _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE $table ( $columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnAddress TEXT NOT NULL )''');
  }

  Future<int> insertAddress(Map<String, String> address) async {
    Database db = await instance.database;
    var data = db.insert(table, address);
    return data;
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    var data = await db.query(table);
    return data;
  }

  deleteAddress(int id) async {
    Database db = await instance.database;
    var data = await db.delete(table, where: 'address_id = ?', whereArgs: [id]);
    print(data);
  }
}
