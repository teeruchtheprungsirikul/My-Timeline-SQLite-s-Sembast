

import 'package:flutter/material.dart';
import 'package:nextflow_personal_post/provider/post_provider.dart';
import 'package:provider/provider.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({ Key key }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context, 
              builder: (BuildContext context){
                //return Text('จะลบจริงๆ ใช่ไหม');
                return AlertDialog(
                  title: Text('แน่ใจหรือ?'),
                  content: Text('นี่จะเป็นการลบข้อมูลทั้งหมดในไทม์ไลน์'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        //ย้อนไปคำสั่งก่อนหน้าที่จะกดลบทั้งหมดหน้าsetting
                        Provider.of<PostProvider>(context, listen: false)
                          .clearAllPost();
                        Navigator.pop(context);
                      },
                      child: Text('ยืนยัน'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); 
                      },
                      child: Text('ยกเลิก'),
                    ),
                  ],
                );
              });
              

          }, 
          child: Text('ลบข้อมูลทั้งหมด'),
        ),
      ));
  }
}