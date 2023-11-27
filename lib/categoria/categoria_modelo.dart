class CategoriaModelo {
  final String nome;
  final String descricao;
  final String cor;

  CategoriaModelo({
    required this.nome,
    required this.descricao,
    required this.cor,
  });

  int get hashCode => descricao.hashCode;

  get id => null;

  @override
  bool operator ==(Object other) {
    if (CategoriaModelo != other.runtimeType) {
      return false;
    }
    other as CategoriaModelo;
    return descricao == other.descricao;
  }
}
