
import 'package:flutter/material.dart';
import 'package:nextflow_personal_post/provider/post_provider.dart';
import 'package:provider/provider.dart';

class NewPostPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final postMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สร้างโพสใหม่'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                controller: postMessageController,
                autofocus: true,
                maxLines: 3,
                validator: (String text){
                  if(text.isEmpty){
                    return 'กรุณากรอกว่ากำลังทำอะไรอยู่นะจ๊ะ';
                  }

                  // if(text.length < 5){
                  //   return 'สถานะต้องมีความยาวไม่ต่ำกว่า 5 ตัวอักษร';
                  // }
                  return null;
                },
                decoration: InputDecoration(  
                  //ลบเส้นสีฟ้า
                  border: InputBorder.none,hintText: 'คุณกำลังทำอะไรอยู่'
                ),
              ),
            ),
              Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text('โพส'),
                    onPressed: () {

                      //ถ้า validate หรือเช็คข้อมูลใน Form Widget แล้วผ่าน
                      //validate() จะคืนค่าเป็น true
                      if(formKey.currentState.validate()){
                        var message = postMessageController.text;
                        print(message);

                         
                        Provider.of<PostProvider>(context, listen: false)
                          .addNewPost(message);
                        Navigator.pop(context);
                      } 
                      
                    },
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}