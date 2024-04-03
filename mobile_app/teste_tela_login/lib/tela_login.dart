//tela_login.dart
import 'package:flutter/material.dart';
import 'tela_cadastro.dart'; // Certifique-se de criar este arquivo
import 'locais.dart';

class TelaLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(decoration: InputDecoration(labelText: 'Usuário')),
            TextField(
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true),
            ElevatedButton(
              onPressed: () {
                // Simulando o login e redirecionando para a tela de cadastro de ponto de fiscalização
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Locais()));
              },
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TelaCadastro()));
              },
              child: Text('Cadastre-se já'),
            ),
          ],
        ),
      ),
    );
  }
}
