import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import 'csv_model.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  DatabaseHelper._createInstance();
  static Database _database;

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDataBase();
    }
    return _database;
  }

  Future<Database> initDataBase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'person.db';
    Database result = await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('CREATE TABLE person ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,'
          'name TEXT,'
          'address TEXT,'
          'email TEXT,'
          'photo BLOB,'
          'phone TEXT)');
    });
    return result;
  }

  // ignore: non_constant_identifier_names
  Future<List<Map<String, dynamic>>> PersonsDetails() async {
    Database db = await this.database;
    List<Map<String, dynamic>> result = await db.query("person");
    return result;
  }

  // ignore: non_constant_identifier_names
  Future<int> AddPerson(Person person) async {
    Database db = await this.database;
    var result = await db.insert("person", person.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

  Future<int> UpdatePerson(Person person, int id) async {
    Database db = await this.database;
    return await db.update("person", person.toMap(), where: 'id=?', whereArgs: [id]);
  }

  // ignore: missing_return
  Future<int> DeletePerson(int id) async {
    Database db = await this.database;
    return await db.delete(
      'person',
      where: "id= ?",
      whereArgs: [id],
    );
  }

  Future<List<Person>> PersonDetailTheClass() async {
    List<Map<String, dynamic>> Persons = await PersonsDetails();
    List<Person> persons = List<Person>();
    for (int i = 0; i < Persons.length; i++) {
      persons.add(Person.fromMapObject(Persons[i]));
    }
    return persons;
  }
}
