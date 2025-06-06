import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

class NotesDatabse {

  static final NotesDatabse instance = NotesDatabse._init();

  NotesDatabse._init();

  static sqflite.Database? _database;

  Future<sqflite.Database> _initDB(String filePath) async {
    final dbPath = await sqflite.getDatabasesPath();

    final path = join(dbPath, filePath);

    return await sqflite.openDatabase(
        path,
        version: 1,
        onCreate:
    )
  }

  Future -createDB(sqflite.Database db, int version)  async {
    await db.execute(
      CREATE TABLE notes(

    )
  }
}