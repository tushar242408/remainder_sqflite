import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remainder/var.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'View.dart';

class dbhelper{
  var b=DateTime.now();
  static final databasename="my.db";
  static final databaseversion=1;
  static final table="mytable";
  static final columnId="Id";
  static final  columnname="name";
  static final columnremainder="remainder";
  static final columndate="date";
  static Database database;
   dbhelper.privateconstructor();
   static final dbhelper instance=dbhelper.privateconstructor();

  Future<Database> get db async{
    print(b);
    if(database!=null){
      return database;
    }
    database= await makedatabase();
    return database;

  }
  makedatabase() async{
    Directory directory= await getApplicationDocumentsDirectory();
    String path;
    path=join(directory.path,databasename);
    return openDatabase(path, version: databaseversion,onCreate: _oncreate);
  }
  Future _oncreate(Database db, int version) async{
    String sql="create table $table ($columnId INTEGER PRYMARY KEY AUTO INCREMENT,$columnname Text,$columnremainder Text ,Date)";
    await db.execute(sql);

  }
  Future<int> insert(Map<String,dynamic> row) async{
    Database datab=await instance.db;
    return datab.insert(table, row);

  }
  Future<int> delete(String s) async{
    print(s);
    Database datab=await instance.db;
    print(s);

    datab.delete(table, where: "$columnremainder=?",whereArgs: [s]);
    print(s);

  }
     alldata() async{

    Database datab=await instance.db;
    String sql="select * from $table";
    List<Map> r= await datab.rawQuery(sql);
    print(r.length);
    return r;
      }
    }

