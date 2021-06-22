import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_flutter/models/models.dart';

class DatabaseService {
  static const _userDatabase = 'users.sqlite3';
  static const _usersTable = 'usersTable';
  static const _idField = 'id';
  static const _nameField = 'name';

  late final Database _db;

  Future<void> initDB() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), _userDatabase),
      onCreate: (db, version) => db.execute(
        '''
           CREATE TABLE $_usersTable
           ($_idField INTEGER PRIMARY KEY, $_nameField TEXT) 
        ''',
      ),
      version: 1,
    );
  }

  Future<int> create(User user) async {
    try {
      return _db.insert(
        _usersTable,
        user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print(e.toString());
      throw Exception();
    }
  }

  Stream<List<User>> user() {
    return Stream.fromFuture(read());
  }

  Future<List<User>> read() async {
    var users = <User>[];
    try {
      var result = await _db.query(
        _usersTable,
      );

      users = result.map((e) => User.fromJson(e)).toList();
    } catch (e) {
      print(e.toString());
    }

    return users;
  }

  Future<void> removeData(int id) async {
    await _db.delete(
      _usersTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteATable() async {
    await _db.delete(
      _usersTable,
    );
  }

  Future<void> updateData(User user) async {
    await _db.update(
      _usersTable,
      user.toJson(),
      
    );
  }

  Future<void> close() async {
    await _db.close();
  }
}
