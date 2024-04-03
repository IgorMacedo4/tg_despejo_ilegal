//galeria_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'imagem_aumenta.dart';

class GalleryScreen extends StatelessWidget {
  final List<String> imagesPaths;

  const GalleryScreen({Key? key, required this.imagesPaths}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Galeria')),
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: imagesPaths.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    FullScreenImageScreen(imagePath: imagesPaths[index]),
              ));
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.file(File(imagesPaths[index]), fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
