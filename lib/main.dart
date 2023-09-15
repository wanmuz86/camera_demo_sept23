import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  XFile? _pickedImage;
  Uint8List? _imageBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Camera page"),),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            (_imageBytes == null) ? Placeholder() : Image.memory(_imageBytes!),
            ElevatedButton(onPressed: () async{
              final picker = ImagePicker();
              final pickedImage = await picker.pickImage(source: ImageSource.gallery);
              // I have to be sure that the image is Picked...
              if (pickedImage != null){
                var imageBytes = await pickedImage.readAsBytes();
                setState(() {
                  _pickedImage = pickedImage;
                  _imageBytes = imageBytes;
                });
              }
            }, child: Text("Get from photo library")),
            ElevatedButton(onPressed: () async {
              final picker = ImagePicker();
              final pickedImage = await picker.pickImage(source: ImageSource.camera);
              // I have to be sure that the image is Picked...
              if (pickedImage != null){
                var imageBytes = await pickedImage.readAsBytes();
                setState(() {
                  _pickedImage = pickedImage;
                  _imageBytes = imageBytes;
                });
              }


            }, child: Text("Get from camera"))
          ],
        ),
      ),
    );
  }
}
