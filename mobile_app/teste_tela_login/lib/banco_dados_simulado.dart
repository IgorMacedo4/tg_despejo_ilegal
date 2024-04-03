class BancoDadosSimulado {
  static final List<Map<String, dynamic>> cadastrosUsuarios = [];
  static final List<Map<String, dynamic>> cadastrosLocais = [];

  // Função para atualizar um local específico pelo índice
  static void atualizarLocal(int indice, Map<String, dynamic> novoLocal) {
    if (indice >= 0 && indice < cadastrosLocais.length) {
      cadastrosLocais[indice] = novoLocal;
    }
  }

  // Função para remover um local específico pelo índice
  static void removerLocal(int indice) {
    if (indice >= 0 && indice < cadastrosLocais.length) {
      cadastrosLocais.removeAt(indice);
    }
  }
}
