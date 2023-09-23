

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:weather_app/Models/database_modal.dart';
import 'package:weather_app/Res/Database%20Table/database_table.dart';

class DatabaseRepository {

  static final DatabaseRepository instance = DatabaseRepository._init();
  DatabaseRepository._init();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('todo.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
                        create table ${TableMataData.tableName} ( 
                        ${TableMataData.id} integer primary key autoincrement, 
                        ${TableMataData.cityName} text not null,
                        ${TableMataData.countryCode} text not null,
                        ${TableMataData.lat} text not null,
                        ${TableMataData.lon} text not null,
                        ${TableMataData.isDefault} boolean not null,
                        ${TableMataData.isSelected} boolean not null)
                     ''');
  }

  insert({required DatabaseCityModal databaseCityModal}) async{
    Database db = await instance.database;
    await db.insert(TableMataData.tableName, databaseCityModal.toMap());
  }

  Future<void> delete(int id) async {
    try {
      final db = await instance.database;
      await db.delete(
        TableMataData.tableName,
        where: '${TableMataData.id} = ?',
        whereArgs: [id],
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> update(DatabaseCityModal databaseCityModal) async {
    try {
      final db = await instance.database;
      db.update(
        TableMataData.tableName,
        databaseCityModal.toMap(),
        where: '${TableMataData.id} = ?',
        whereArgs: [databaseCityModal.id],
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<DatabaseCityModal>> getAllSelectedCities() async {
    final db = await instance.database;

    final result = await db.query(TableMataData.tableName);

    return result.map((json) => DatabaseCityModal.fromJson(json)).toList();
  }

  Future<dynamic> deleteAll() async {
    final db = await instance.database;
    return await db.rawDelete('Delete from ${TableMataData.tableName}');
  }

}