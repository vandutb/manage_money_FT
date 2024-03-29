import 'dart:async';
import 'dart:async' as prefix0;

import 'package:managemoneybyday_ft/obj/DetailPay.dart';
import 'package:managemoneybyday_ft/obj/MoneyManage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:async';
import 'package:path/path.dart';

class  SqliteUntil {
  SqliteUntil _sqliteUntil;
  Database _db;
  static final _DB_NAME = "MONEY_MANAGE.DB";

  //
  static final TB_MONEY_DETAIL = "TB_MONEY_DETAIL";
  static final TB_MONEY_TOPIC = "TB_MONEY_TOPIC";

  static final DB_NAME = "MONEY_MANAGE.DB";

  static final CL_ID = "_ID";
  static final CL_NAME = "NAME";
  static final CL_IMAGE = "IMAGE";
  static final CL_DESCRIPTION = "DESCRIPTION";

  //column detail
  static final CL_ID_MANAGE = "ID_MANAGE";
  static final CL_COST = "COST";
  //dã trả tiền hay chưa
  //dùng cho chức năng lên lịch
  static final CL_WAS_PAY  = "IS_WAS_PAYMENT";
  static final SCHEDULE = "DAY_COST";

  //column TOPIC
  static final CL_NAME_TOPIC = "TOPIC_NAME";
  // theo dõi mục này
  static final CL_IS_FORCUS = "IS_FORCUS";


  //
  static final CREATE_DATE ="CREATE_DATE";
  static final UPDATE_DATE ="UPDATE_DATE";

  Future<SqliteUntil> openDB() async{
    if(_sqliteUntil == null)
      _sqliteUntil = new SqliteUntil();
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, '$DB_NAME');
    _db = await openDatabase(path, version: 1, onCreate: (Database db, int version)async{
      await db.execute(createDetailTB());
      await db.execute(createTOPICTB());
    });
    return _sqliteUntil;
  }

  String createDetailTB(){
    return "'CREATE TABLE $TB_MONEY_DETAIL"
        "($CL_ID INTERGER AUTOINCREMENT PRIMARY KEY AUTO ,"
        "$CL_ID_MANAGE INTERGER NOT NULL,"
        "$CL_NAME TEXT NOT NULL,"
        "$CL_IMAGE TEXT NULL,"
        "$CL_DESCRIPTION TEXT NULL,"
        "$CL_COST DOUBLE NULL,"
        "$CREATE_DATE default CURRENT_DATE,"
        "$UPDATE_DATE default CURRENT_DATE,"
        "$SCHEDULE DATETIME NOT NULL,"
        "$CL_WAS_PAY BOOLEAN NULL"
        ")'"
    ;
  }String createTOPICTB(){
    return "'CREATE TABLE $TB_MONEY_TOPIC"
        "($CL_ID INTERGER AUTOINCREMENT PRIMARY KEY AUTO ,"
        "$CL_NAME TEXT NOT NULL,"
        "$CL_IMAGE TEXT NOT NULL,"
        "$CL_DESCRIPTION TEXT NOT NULL,"
        "$CL_IS_FORCUS BOOLEAN NOT NULL,"
        "$CREATE_DATE DATETIME default CURRENT_DATE,"
        "$UPDATE_DATE DATETIME default CURRENT_DATE"
        ")'"
    ;
  }

  Future<bool> addTopic(MoneyManage moneyManage)async{
    var state = await _db.transaction((db) async{
        db.rawInsert("INSERT INTO $TB_MONEY_TOPIC("
            "$CL_NAME, "
            "$CL_IMAGE, "
            "$CL_DESCRIPTION, "
            "$CL_IS_FORCUS) "
            "VALUES ("
            "'${moneyManage.CL_NAME}', "
            "'${moneyManage.CL_IMAGE}', "
            "'${moneyManage.CL_DESCRIPTION}', "
            "'${moneyManage.CL_IS_FORCUS}'"
            ")");
    });
    return state != "-1";
  }

  Future<bool> addDetail(DetailPay detailPay)async{
    var state = await _db.transaction((db) async{
        db.rawInsert("INSERT INTO $TB_MONEY_DETAIL("
            "$CL_ID_MANAGE , "
            "$CL_NAME , "
            "$CL_IMAGE , "
            "$CL_DESCRIPTION, "
            "$CL_COST, "
            "$SCHEDULE, "
            "$CL_WAS_PAY ) "
            "VALUES ("
            "'${detailPay.ID_MANAGE}', "
            "'${detailPay.NAME}', "
            "'${detailPay.IMAGE}', "
            "'${detailPay.DESCRIPTION}', "
            "'${detailPay.COST}', "
            "'${detailPay.SCHEDULE_COST}', "
            "'${detailPay.WAS_PAY}' "
            ")");
    });
    return state != "-1";
  }



  Future<List<MoneyManage>> getLstManage(Database db) async{
    var lstMoney =  List<MoneyManage>();
    try{

    }on Exception catch(e){
      print(e.toString());
    }finally{
      db.close();
    }
  }

}