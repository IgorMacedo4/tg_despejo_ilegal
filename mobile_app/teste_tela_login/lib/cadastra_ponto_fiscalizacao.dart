import 'package:flutter/material.dart';
import 'banco_dados_simulado.dart'; // Certifique-se de importar corretamente

class CadastraPontoFiscalizacao extends StatefulWidget {
  final int?
      indiceEdicao; // Índice do local a ser editado, null se for cadastro

  CadastraPontoFiscalizacao({Key? key, this.indiceEdicao}) : super(key: key);

  @override
  _CadastraPontoFiscalizacaoState createState() =>
      _CadastraPontoFiscalizacaoState();
}

class _CadastraPontoFiscalizacaoState extends State<CadastraPontoFiscalizacao> {
  late TextEditingController _nomeController;
  late TextEditingController _enderecoController;
  late TextEditingController _cidadeController;
  late TextEditingController _estadoController;
  late TextEditingController _cepController;
  late TextEditingController _observacaoController;

  @override
  void initState() {
    super.initState();
    final local = widget.indiceEdicao != null
        ? BancoDadosSimulado.cadastrosLocais[widget.indiceEdicao!]
        : {};
    _nomeController = TextEditingController(text: local['nome'] ?? '');
    _enderecoController = TextEditingController(text: local['endereco'] ?? '');
    _cidadeController = TextEditingController(text: local['cidade'] ?? '');
    _estadoController = TextEditingController(text: local['estado'] ?? '');
    _cepController = TextEditingController(text: local['cep'] ?? '');
    _observacaoController =
        TextEditingController(text: local['observacao'] ?? '');
  }

  void _salvarLocal() {
    final novoLocal = {
      'nome': _nomeController.text,
      'endereco': _enderecoController.text,
      'cidade': _cidadeController.text,
      'estado': _estadoController.text,
      'cep': _cepController.text,
      'observacao': _observacaoController.text,
    };

    if (widget.indiceEdicao == null) {
      BancoDadosSimulado.cadastrosLocais.add(novoLocal);
    } else {
      BancoDadosSimulado.atualizarLocal(widget.indiceEdicao!, novoLocal);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(widget.indiceEdicao == null
              ? 'Local de Fiscalização salvo com sucesso!'
              : 'Local de Fiscalização atualizado com sucesso!')),
    );
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.indiceEdicao == null
            ? "Cadastrar Novo Local"
            : "Editar Local"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome')),
            TextField(
                controller: _enderecoController,
                decoration: InputDecoration(labelText: 'Endereço')),
            TextField(
                controller: _cidadeController,
                decoration: InputDecoration(labelText: 'Cidade')),
            TextField(
                controller: _estadoController,
                decoration: InputDecoration(labelText: 'Estado')),
            TextField(
                controller: _cepController,
                decoration: InputDecoration(labelText: 'CEP')),
            TextField(
                controller: _observacaoController,
                decoration: InputDecoration(labelText: 'Observação')),
            SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                onPressed: _salvarLocal,
                child: Text(widget.indiceEdicao == null
                    ? 'Salvar Local de Fiscalização'
                    : 'Atualizar Local de Fiscalização'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _enderecoController.dispose();
    _cidadeController.dispose();
    _estadoController.dispose();
    _cepController.dispose();
    _observacaoController.dispose();
    super.dispose();
  }
}
