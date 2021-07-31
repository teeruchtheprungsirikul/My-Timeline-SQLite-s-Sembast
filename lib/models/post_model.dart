
import 'package:sembast/sembast.dart';
import 'package:timeago/timeago.dart' as timeago;
class Post {
  String message;
  DateTime createdDate;

  Post({this.message,this.createdDate});

  String get timeagoMessage{
    var now = DateTime.now();
    var duration = now.difference(this.createdDate);
    var ago = now.subtract(duration);
    var message = timeago.format(ago, locale: 'th');
    //var message = timeago.format(ago, locale: 'th_short');

    return message;
  }
  //ประกาศstaticเพื่อใช้งานกับข้อมูลpostตัวไหนก็ได้,ประกาศdatatypeเป็นMap
  //สามารถใช้คลาสเรียกใช้งานฟังก์ชันในคลาสตัวเองได้
  static Map<String, dynamic> toJson(Post post) {
    return{
      'message' : post.message,
      'createdDate' : post.createdDate.toIso8601String(),
    };
  }

  static Post fromRecord(RecordSnapshot record) {
    var post = Post(
      message: record['message'],
      createdDate: DateTime.parse(record['createdDate']));
    return post;
  }
}