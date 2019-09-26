import 'package:managemoneybyday_ft/obj/MoneyManage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:async';
import 'package:async/async.dart';

class  SqliteUntil {
  SqliteUntil _sqliteUntil;
  Database _db;
  static final _DB_NAME = "MONEY_MANAGE.DB";
  //
  static final TB_MONEY_MANAGE = "TB_MONEY_MANAGE";
  static final TB_MONEY_DETAIL = "TB_MONEY_DETAIL";

  static final DB_NAME = "MONEY_MANAGE.DB";

  Future<SqliteUntil> openDB() async{
    if(_sqliteUntil == null)
      _sqliteUntil = new SqliteUntil();
    _db = await openDatabase(_DB_NAME);
    if(_db == null){
      createDB();
    }
    var dbPath = await getDatabasesPath();

        return _sqliteUntil;
  }

  Future<List<MoneyManage>> _getLstManage(Database db) async{
    var lstMoney =  List<MoneyManage>();
    try{

    }on Exception catch(e){
      print(e.toString());
    }finally{
      db.close();
    }

  }

  void createDB() {

  }
}