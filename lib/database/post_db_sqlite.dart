

import 'dart:io';
import 'package:nextflow_personal_post/database/post_db.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:path/path.dart';
import 'package:sembast_sqflite/sembast_sqflite.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
//Class (Inheritance)
class PostDBSQLite extends PostDB {

  PostDBSQLite(String databaseName) : super(databaseName);

  @override
  Future<Database> openDatabase() async {
    Directory appDocumentDirectory = await getApplicationDocumentsDirectory();
    String databaseLocationInApp = 
      join(appDocumentDirectory.path, this.databaseName);

    var dbFactory = getDatabaseFactorySqflite(sqflite.databaseFactory);
    var db = dbFactory.openDatabase(databaseLocationInApp);
    return db;
  } 

}