import 'dart:io';
import 'package:nextflow_personal_post/models/post_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class PostDB {
  String databaseName;

  PostDB(this.databaseName);

  //เปิดไฟล์ดาต้าเบส,ค้นหาที่อยู่ดาต้าเบส
  Future<Database> openDatabase() async {
    Directory appDocumentDirectory = await getApplicationDocumentsDirectory();
    String databaseLocationInApp = 
      join(appDocumentDirectory.path, this.databaseName); 
    
   //เปิดการเชื่อมต่อดาต้าเบส 
    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(databaseLocationInApp);
    return db;        
  }
  //บันทึกข้อมูลแบบObject
  Future<int>save(Post post) async {
    //เปิดฐานข้อมูล,ระบุคำสั่งsembastที่อยู่ชุดของข้อมูลที่ชื่อว่าposts,แล้วเก็บไวในตัวแปรpostStore
    var database = await this.openDatabase();
    var postStore = intMapStoreFactory.store('posts'); //ที่เก็บข้อมูลที่ชื่อว่าposts
    //สั่งเพิ่มข้อมูลเป็นJSONผ่านตัวแปรpostStoreลงไปในdatabaseเสร็จแล้วจะคืนค่ากลับมาเป็นตัวเลข
    //สามารถใช้คลาสเรียกใช้งานฟังก์ชันในคลาสตัวเองได้Post.toJson(post)
    var dataId = await postStore.add(database, Post.toJson(post));

    await database.close();
    //primarykey
    return dataId;
  }
  //อ่านไฟล์ดาต้าเบส
  Future<List<Post>>loadAllPosts() async{
    //เปิดการเชื่อมต่อไปที่ฐานข้อมูล
    var database = await this.openDatabase();
    //บอกให้sembastเข้าไปยุ่งกับที่เก็บข้อมูลที่ชื่อว่าposts
    var postStore = intMapStoreFactory.store('posts');
    //ให้ไปหาข้อมูลในดาต้าเบส
    var snapshots = await postStore.find(
      database, 
      finder:Finder(
        sortOrders: [
          SortOrder(Field.key, false)
          ],
      ), 
    );
    // ignore: deprecated_member_use
    var postList = List<Post>();

    for(var record in snapshots) {
      var post = Post.fromRecord(record);
      postList.add(post);
    }
    return postList;
  }

  Future<void> clearPostData() async {
    var database = await this.openDatabase();
    var postStore = intMapStoreFactory.store('posts');
    await postStore.drop(database);
  }
}