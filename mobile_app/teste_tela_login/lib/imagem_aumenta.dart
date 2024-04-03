//imagem_aumenta.dart
import 'dart:io';
import 'package:flutter/material.dart';

class FullScreenImageScreen extends StatelessWidget {
  final String imagePath;

  const FullScreenImageScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop(); // Fecha a tela ao tocar na imagem
        },
        child: Center(
          child: Image.file(File(imagePath)),
        ),
      ),
    );
  }
}
