import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class EditMeme extends StatefulWidget {
  final String imageName;
  const EditMeme({ Key? key, required this.imageName }) : super(key: key);

  @override
  _EditMemeState createState() => _EditMemeState();
}

class _EditMemeState extends State<EditMeme> {
  String topText = '';
  String bottomText = '';
  GlobalKey globalKey =  new GlobalKey();

  void initState(){
    super.initState();
    topText = "Top text";
    bottomText = "Bottom text";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white,
     appBar: AppBar(
       elevation: 0,
       backgroundColor: Colors.white,
       leading: IconButton(
         onPressed: () {
          Navigator.pop(context);
         },
         icon: Icon(
           Icons.arrow_back_ios,
           color: Colors.black,
           ),
       ),
       title: Text(
         'Add Text',
         style: TextStyle(color: Colors.black),
      ),
     ),
    
    body: ListView(
      children: [
        RepaintBoundary(
          key: globalKey,
          child: Stack(
            children: [
              Image.asset('assets/meme/${widget.imageName}.jpg'),
              Positioned(
                top: 30,
                left: 60,
                child: buildStrokeText(topText),
              ),
              Positioned(
                top: 230,
                left: 60,
                child: buildStrokeText(bottomText),
              ),
            ],
          ),
        ),
        
        Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              SizedBox(height: 24),
              TextField(
                onChanged: (text){
                    setState(() {
                      topText = text;
                    });
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE8E8E6)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  filled: true,
                  fillColor: Color(0xFFF7F7F7),
                  hintText: "top text",
                ),
              ),
              SizedBox(height: 24),
              TextField(
                onChanged: (text){
                    setState(() {
                      bottomText = text;
                    });
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFE8E8E6)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  filled: true,
                  fillColor: Color(0xFFF7F7F7),
                  hintText: "bottom text",
                ),
              ),
              SizedBox(height: 24),
              Container(
                child: TextButton(
                  child: Text(
                    'Export', 
                    style: TextStyle(color: Colors.white),
                    ),
                  onPressed: (){
                    print('Export');
                    exportMeme();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  ),
              ),
            ],
          ),
        ),
      ],
    ),
    );
  }


  Stack buildStrokeText(String text) {
    return Stack(
      children: [
        Text(text,
            style: TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 6
                ..color = Colors.black,
            )),
        Text(text,
            style: TextStyle(
                fontSize: 52,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
      ],
    );
  }

  void exportMeme() async {
    try{
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();

    final directory = (await getApplicationDocumentsDirectory()).path;

    ByteData byteData =
        await image.toByteData(format: ui.ImageByteFormat.png) as ByteData;
    Uint8List pngByte = byteData.buffer.asUint8List();
    File imageFile = File('$directory/meme.png');
    imageFile.writeAsBytesSync(pngByte);

    Share.shareFiles(['$directory/meme.png']);
  }catch(e){

  }
}
}