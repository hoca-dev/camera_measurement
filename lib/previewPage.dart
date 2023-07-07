import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';


class PreviewPage extends StatelessWidget {

 const PreviewPage({Key? key, required this.picture}) : super(key: key);

  final XFile picture;

  @override
  Widget build(BuildContext context) {
    const snackBarMessage = SnackBar(content:  Text('사진이 저장되었습니다'));
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black,),
          onPressed: ()=> Navigator.pop(context),
        ),
        actions: [
          MaterialButton(
            child: const Text('저장', style: TextStyle(color: Colors.blue, fontSize: 17),),
            onPressed: (){
              ScaffoldMessenger.of(context).showSnackBar(snackBarMessage);
              GallerySaver.saveImage(picture.path);
            }),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(

            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Image.file(File(picture.path,), fit: BoxFit.fitWidth,),
          ),
        ],
      ),
    );
  }
  
}
