import 'dart:io';

import 'package:deptech_assesment_flutter/models/admin.dart';
import 'package:deptech_assesment_flutter/models/cuti_pegawai.dart';
import 'package:deptech_assesment_flutter/models/pegawai.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'employee.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS admin(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name TEXT NOT NULL,
          last_name TEXT NOT NULL,
          email TEXT NOT NULL,
          password TEXT NOT NULL
      )''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS pegawai(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name TEXT NOT NULL,
          last_name TEXT NOT NULL,
          email TEXT NOT NULL,
          phone TEXT NOT NULL,
          address TEXT NOT NULL,
          gender TEXT NOT NULL
      )''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS cuti(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          id_pegawai INTEGER NOT NULL,
          reason TEXT NOT NULL,
          start_cuti TEXT NOT NULL,
          finish_cuti TEXT NOT NULL,
          FOREIGN KEY (id_pegawai) REFERENCES pegawai (id)
      )''');
  }

  Future<List<Admin>> getAdmin() async {
    Database db = await instance.database;
    var admin = await db.query('admin', orderBy: 'first_name');
    List<Admin> adminList = admin.isNotEmpty ? admin.map((c) => Admin.fromMap(c)).toList() : [];
    return adminList;
  }

  Future<bool> loginAdmin(String email, String password) async {
    Database db = await instance.database;
    try {
      var admin = await db.query('admin', where: "email = ? AND password = ?", whereArgs: [email, password]);
      List<Admin> adminList = admin.isNotEmpty ? admin.map((c) => Admin.fromMap(c)).toList() : [];
      if (admin.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<int> addAdmin(Admin admin) async {
    Database db = await instance.database;
    return await db.insert('admin', admin.toMap());
  }

  Future<int> removeAdmin(int id) async {
    Database db = await instance.database;
    return await db.delete('admin', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateAdmin(Admin admin) async {
    Database db = await instance.database;
    return await db.update('admin', admin.toMap(), where: "id = ?", whereArgs: [admin.id]);
  }

  Future<List<Pegawai>> getPegawai() async {
    Database db = await instance.database;
    var pegawai = await db.query('pegawai', orderBy: 'first_name');
    List<Pegawai> pegawaiList = pegawai.isNotEmpty ? pegawai.map((c) => Pegawai.fromMap(c)).toList() : [];
    return pegawaiList;
  }

  Future<List<CutiPegawai>> getCutibyPegawai() async {
    Database db = await instance.database;
    var pegawai = await db.rawQuery(
        'SELECT cuti.id, cuti.id_pegawai, cuti.reason, cuti.start_cuti, cuti.finish_cuti, pegawai.first_name, pegawai.last_name FROM cuti INNER JOIN pegawai ON pegawai.id = cuti.id_pegawai');
    List<CutiPegawai> pegawaiList = pegawai.isNotEmpty ? pegawai.map((c) => CutiPegawai.fromMap(c)).toList() : [];
    return pegawaiList;
  }

  Future<int> addPegawai(Pegawai pegawai) async {
    Database db = await instance.database;
    return await db.insert('pegawai', pegawai.toMap());
  }

  Future<int> removePegawai(int id) async {
    Database db = await instance.database;
    return await db.delete('pegawai', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updatePegawai(Pegawai pegawai) async {
    Database db = await instance.database;
    return await db.update('pegawai', pegawai.toMap(), where: "id = ?", whereArgs: [pegawai.id]);
  }

  Future<List<CutiPegawai>> getCuti() async {
    Database db = await instance.database;
    var cutiPegawai = await db.query(
      'cuti',
      orderBy: 'first_name',
    );
    List<CutiPegawai> cutiList = cutiPegawai.isNotEmpty ? cutiPegawai.map((c) => CutiPegawai.fromMap(c)).toList() : [];
    return cutiList;
  }

  Future<int> addCuti(CutiPegawai cuti) async {
    Database db = await instance.database;
    return await db.insert('cuti', cuti.toMap());
  }

  Future<int> removeCuti(int id) async {
    Database db = await instance.database;
    return await db.delete('cuti', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateCuti(CutiPegawai cuti) async {
    Database db = await instance.database;
    return await db.update('cuti', cuti.toMap(), where: "id = ?", whereArgs: [cuti.id]);
  }
}
