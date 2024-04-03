import 'package:flutter/material.dart';
import 'cadastra_ponto_fiscalizacao.dart';
import 'banco_dados_simulado.dart';
import 'detalhes_local.dart';

class Locais extends StatefulWidget {
  @override
  _LocaisState createState() => _LocaisState();
}

class _LocaisState extends State<Locais> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Locais de Fiscalização"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final resultado = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CadastraPontoFiscalizacao()),
              );
              if (resultado == true) {
                setState(
                    () {}); // Atualiza a lista automaticamente após adição ou edição
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: BancoDadosSimulado.cadastrosLocais.length,
        itemBuilder: (context, index) {
          var local = BancoDadosSimulado.cadastrosLocais[index];
          return ListTile(
            title: Text(local['nome']),
            subtitle: Text(
                '${local['endereco']}, ${local['cidade']}, ${local['estado']} - ${local['cep']}'),
            trailing: Text(local['observacao']),
            onTap: () async {
              final resultado = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetalhesLocal(local: local)),
              );
              if (resultado == true) {
                setState(
                    () {}); // Atualiza a lista automaticamente após remoção ou edição
              }
            },
          );
        },
      ),
    );
  }
}
