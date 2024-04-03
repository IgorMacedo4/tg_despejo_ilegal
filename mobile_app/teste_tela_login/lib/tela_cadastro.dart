import 'package:flutter/material.dart';
import 'tela_login.dart'; // Importe a tela de login

class TelaCadastro extends StatefulWidget {
  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro")),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _usuarioController,
              decoration: InputDecoration(labelText: 'Usuário'),
            ),
            TextField(
              controller: _senhaController,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                // Aqui você pode adicionar a lógica que desejar para quando o botão for pressionado
                // Como o código para enviar os dados foi removido,
                // você pode usar este espaço para adicionar qualquer ação,
                // como navegar para outra tela.
              },
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usuarioController.dispose();
    _senhaController.dispose();
    super.dispose();
  }
}
