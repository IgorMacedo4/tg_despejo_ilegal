//config_camera.dart
import 'package:flutter/material.dart';
import 'captura_imagem.dart'; // Certifique-se de que este arquivo esteja criado e corretamente importado
import 'main.dart'; // Importe o main.dart para acessar a variável global `cameras`

class ConfigCamera extends StatefulWidget {
  @override
  _ConfigCameraState createState() => _ConfigCameraState();
}

class _ConfigCameraState extends State<ConfigCamera> {
  final _tempoDisparoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuração da Câmera'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tela de configuração da câmera.'),
            SizedBox(height: 20),
            TextField(
              controller: _tempoDisparoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Tempo de disparo (segundos)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final tempoDisparo = int.tryParse(_tempoDisparoController.text);
                if (tempoDisparo != null &&
                    cameras != null &&
                    cameras!.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CapturaImagem(
                          camera: cameras!.first, tempoDisparo: tempoDisparo),
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Erro"),
                        content: Text(
                            "Por favor, insira um tempo válido e verifique se há câmeras disponíveis."),
                        actions: [
                          TextButton(
                            child: Text("OK"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Iniciar'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tempoDisparoController.dispose();
    super.dispose();
  }
}
