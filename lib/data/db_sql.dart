import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbSql {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'note.db'),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE note (id TEXT PRIMARY KEY, title TEXT, content TEXT, date TEXT)'),
        version: 1);
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await DbSql.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbSql.database();
    return db.query(table);
  }

  static Future delete(String id) async {
    final db = await DbSql.database();
    try {
      db.delete('note', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      return null;
    }
  }
}
