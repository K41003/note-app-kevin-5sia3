import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/user_model.dart';
import '../models/note_model.dart';

class DatabaseHelper {
  // Singleton intance
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  // Configuration variables
  static Database? _database;
  final String databaseName = 'notes_5sia3.db';
  final int databaseVersion = 2;

  // Create user  table
  final String createUserTable = '''
    CREATE TABLE users (
      userId INTEGER PRIMARY KEY AUTOINCREMENT,
      userName TEXT UNIQUE NOT NULL,
      userPassword TEXT NOT NULL
    )
  ''';
  // Create note table
  final String createNoteTable = '''
    CREATE TABLE notes (
      noteId INTEGER PRIMARY KEY AUTOINCREMENT,
      noteTitle TEXT NOT NULL,
      noteContent TEXT NOT NULL,
      createdAt TEXT DEFAULT CURRENT_TIMESTAMP
    )
  ''';

  // Initialize the database
  Future<Database> initDB() async {
    try {
      final databasePath = await getDatabasesPath();
      final path = join(databasePath, databaseName);

      return openDatabase(
        path,
        version: databaseVersion,
        onCreate: (db, version) async {
          await db.execute(createUserTable);
          await db.execute(createNoteTable);
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  // Get the database instance
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    try {
      _database = await initDB();
      return _database!;
    } catch (e) {
      rethrow;
    }
  }

  // Login Method
  Future<bool> login(UserModel user) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'userName = ? AND userPassword = ?',
      whereArgs: [user.userName, user.userPassword],
    );
    return result.isNotEmpty;
  }
 
  // Create Account Method
  Future<int> createAccount(UserModel user) async {
    try {
      final Database db = await database;
      final result = await db.insert('users', user.toMap());
      return result;
    } catch (e) {
      // Handle specific SQLite exceptions
      if (e.toString().contains('UNIQUE constraint failed')) {
        throw Exception('Username already exists');
      }
      throw Exception('Failed to create account: ${e.toString()}');
    }
  }

  // Create Note Method
  Future<int> createNote(NoteModel note) async {
    final Database db = await database;

    return await db.insert('notes', note.toMap());
  }

  // Get Notes method
  Future<List<NoteModel>> getNotes() async {
    final db = await database;
    final result = await db.query('notes');

    return result.map((e) => NoteModel.fromMap(e)).toList();
  }
}
