import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'tela_login.dart'; // Sua tela de login aqui

List<CameraDescription>? cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Solicita permissões
  await [Permission.camera].request();

  // Obtém a lista de câmeras disponíveis no dispositivo
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Erro ao obter lista de câmeras disponíveis: $e');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Protótipo de Cadastro',
      debugShowCheckedModeBanner: false,
      home: TelaLogin(), // TelaLogin é a primeira tela a ser exibida
    );
  }
}
