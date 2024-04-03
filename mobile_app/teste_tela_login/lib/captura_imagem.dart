import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:intl/intl.dart'; // Importe a biblioteca intl
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'galeria_screen.dart';
import 'firebase_service.dart'; // Este arquivo deve lidar com o upload para o Firebase

class CapturaImagem extends StatefulWidget {
  final CameraDescription camera;
  final int tempoDisparo;

  const CapturaImagem({
    Key? key,
    required this.camera,
    required this.tempoDisparo,
  }) : super(key: key);

  @override
  _CapturaImagemState createState() => _CapturaImagemState();
}

class _CapturaImagemState extends State<CapturaImagem> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  Timer? _captureTimer;
  Timer? _uploadTimer;
  List<File> _imagesToUpload = [];
  bool _flashIsOn = false;
  int lote = 1; // Variável para controlar o identificador do lote
  int _imageCounter = 0; // Contador de imagens capturadas no lote atual

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize().then((_) {
      setState(() {
        _controller.setFlashMode(FlashMode.off);
      });
      if (widget.tempoDisparo > 0) {
        _captureTimer = Timer.periodic(Duration(seconds: widget.tempoDisparo),
            (Timer t) => _takePicture());
      }
      _uploadTimer =
          Timer.periodic(Duration(seconds: 65), (Timer t) => _uploadImages());
    });
  }

  Future<void> _takePicture() async {
    if (!mounted || !_controller.value.isInitialized) return;

    try {
      if (!_controller.value.isTakingPicture) {
        final XFile? picture = await _controller.takePicture();
        if (picture != null) {
          final Directory appDirectory =
              await getApplicationDocumentsDirectory();
          final String pictureDirectory = '${appDirectory.path}/Pictures';
          await Directory(pictureDirectory).create(recursive: true);

          // Incrementa o contador e cria um nome de arquivo com o contador, lote e hora
          _imageCounter++;
          String fileName =
              'img${_imageCounter}_lote_${lote}_${DateFormat('yyyy-MM-dd_HH:mm:ss').format(DateTime.now())}_${path.basename(picture.path)}';
          final String newFilePath = '${pictureDirectory}/$fileName';

          await picture.saveTo(newFilePath);

          setState(() {
            _imagesToUpload.add(File(newFilePath));
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _uploadImages() async {
    List<File> imagesToUploadCopy = List.from(_imagesToUpload);
    if (imagesToUploadCopy.isNotEmpty) {
      FirebaseService firebaseService = FirebaseService();
      await firebaseService.uploadImages(imagesToUploadCopy, lote: lote);
      _imagesToUpload.clear();
      lote++; // Incrementa o identificador do lote após o upload
      _imageCounter = 0; // Reinicia o contador de imagens para o próximo lote
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tirar Foto'),
        actions: <Widget>[
          IconButton(
            icon: Icon(_flashIsOn ? Icons.flash_on : Icons.flash_off),
            onPressed: () {
              setState(() {
                _flashIsOn = !_flashIsOn;
                _controller
                    .setFlashMode(_flashIsOn ? FlashMode.torch : FlashMode.off);
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.photo_library),
            onPressed: () {
              _captureTimer?.cancel();
              _uploadTimer?.cancel();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GalleryScreen(
                      imagesPaths:
                          _imagesToUpload.map((file) => file.path).toList())));
            },
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: _takePicture,
      ),
    );
  }

  @override
  void dispose() {
    _captureTimer?.cancel();
    _uploadTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }
}
