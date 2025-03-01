import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Sqldb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initdb();
      return _db;
    } else {
      return _db;
    }
  }


  Future<Database> initdb() async {
    String dbpath = await getDatabasesPath();
    String path = join(dbpath, 'workouts.db');
    Database mydb = await openDatabase(
      path, 
      onCreate: _oncreate,version: 4);
    return mydb;
  }
  Future<void> _oncreate(Database db, int version) async {
    print("on create----------------");
    await db.execute('''
      CREATE TABLE workouts (
        name TEXT NOT NULL PRIMARY KEY
      )
    ''');

    await db.execute('''
      CREATE TABLE exercices (
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        reps integer,
        sets integer,
        rest integer,
        work integer,
        workout TEXT,
        FOREIGN KEY(workout) REFERENCES workouts(name)
      )
    ''');
  }

  Future<List<Map>> readData(String sql) async {
    Database? mydb = await db;
    return await mydb!.rawQuery(sql);
  }
  Future<int> insertData(String sql) async {
    Database? mydb = await db;
    return await mydb!.rawInsert(sql);
  }

  Future<int> updateData(String sql) async {
    Database? mydb = await db;
    return await mydb!.rawUpdate(sql);
  }

  Future<int> deleteData(String sql) async {
    Database? mydb = await db;
    return await mydb!.rawDelete(sql);
  }
  mydeletedatabase() async{
    String databasepath=await getDatabasesPath();
    String path=join(databasepath,'workouts.db');
    await deleteDatabase(path);
  }
}