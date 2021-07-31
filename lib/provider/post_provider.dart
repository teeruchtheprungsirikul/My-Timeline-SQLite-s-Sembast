import 'package:flutter/foundation.dart';
import 'package:nextflow_personal_post/database/post_db.dart';
import 'package:nextflow_personal_post/database/post_db_sqlite.dart';
import 'package:nextflow_personal_post/models/post_model.dart';

//Withกำหนดคุณสมบัติให้กับclassPostProviderเลือกChangeNotifierเป็นfoundation
class PostProvider with ChangeNotifier{
  List<Post> _posts = [];
  PostDB _postDB;

  List<Post> get posts => _posts;

  PostProvider() {
    //_postDB = PostDB('app.db');
    //สลับมาใช้PostDBSQLite
    _postDB = PostDBSQLite('app.db');
  }
  
  //=>FatArrowFunctionทำการreturnWidgetให้กับFunctionได้เลย
  //List<String> get posts => _posts;

  addNewPost(String postMessage) async {
    //_posts.add(post); จะแสดงข้อผ่านที่เข้ามาก่อนอยู่ในบรรทัดบนสุด
    var post = Post(message: postMessage,createdDate:DateTime.now());
    //app.dbเป็นชื่อไฟล์ดาต้าเบส
    //var postDB = PostDB(databaseName: 'app.db');
    //var postDB = _postDB;
    await _postDB.save(post);
    var postFromDB = await _postDB.loadAllPosts();
    
    //_posts.insert(0, post);
    _posts = postFromDB;
    //แจ้งเตือนconsumer
    notifyListeners();
  }

  initData() async {
    //var _postDB = PostDB(databaseName: 'app.db');
    //var postFromDB = await postDB.loadAllPosts();
    //_posts = postFromDB;
    _posts = await _postDB.loadAllPosts();
    notifyListeners();
  }

  clearAllPost() async {
    //var _postDB = PostDB(databaseName: 'app.db' );
    await _postDB.clearPostData();
  //Updateข้อมูลใหม่แบบเปล่าหลังลบ
    _posts = [];
  //ทำการแจ้งข้อมูลที่ถูกลบให้Consumer
    notifyListeners();
  }
}