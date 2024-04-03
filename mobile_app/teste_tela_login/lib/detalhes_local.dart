//detalhes_local.dart
import 'package:flutter/material.dart';
import 'banco_dados_simulado.dart';
import 'cadastra_ponto_fiscalizacao.dart'; // Certifique-se de que este import está correto
import 'config_camera.dart';

class DetalhesLocal extends StatelessWidget {
  final Map<String, dynamic> local;

  DetalhesLocal({Key? key, required this.local}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(local['nome']),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Endereço: ${local['endereco']}'),
            Text('Cidade: ${local['cidade']}'),
            Text('Estado: ${local['estado']}'),
            Text('CEP: ${local['cep']}'),
            Text('Observação: ${local['observacao']}'),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Pega o índice do local para passar para a tela de edição
                    int index =
                        BancoDadosSimulado.cadastrosLocais.indexOf(local);
                    // Navega para a tela de edição com os dados atuais do local
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CadastraPontoFiscalizacao(indiceEdicao: index),
                      ),
                    ).then((result) {
                      // Se a edição for bem-sucedida, result será true
                      if (result == true) {
                        Navigator.pop(context,
                            true); // Informa à tela anterior que uma atualização é necessária
                      }
                    });
                  },
                  child: Text('Editar Local'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ConfigCamera()), // Substitua ConfigCamera pelo nome correto da sua classe, se for diferente
                    );
                  },
                  child: Text('Iniciar Monitoramento'),
                ),
              ],
            ),
            Spacer(),
            Center(
              child: TextButton(
                onPressed: () {
                  // Lógica para remover o local
                  int indexToRemove =
                      BancoDadosSimulado.cadastrosLocais.indexOf(local);
                  if (indexToRemove != -1) {
                    BancoDadosSimulado.cadastrosLocais.removeAt(indexToRemove);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Local removido com sucesso!')));
                    Navigator.pop(context,
                        true); // Retorna true para sinalizar a remoção do local
                  }
                },
                child: Text(
                  'Remover Local',
                  style: TextStyle(color: Colors.red),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
