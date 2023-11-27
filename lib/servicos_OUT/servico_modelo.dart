/*

class ServicoModelo {
  String nome;
  //Criar classe de categoria, enquanto não criar não vai funcionar
  final CategoriaModelo categoria;
  DateTime dataValidade;
  String valor;
  String estoque;
  String descricao;

  ServicoModelo(
      {required this.nome,
      required this.categoria,
      required this.dataValidade,
      required this.valor,
      required this.estoque,
      required this.descricao});

  @override
  int get hashCode => categoria.hashCode;

  @override
  bool operator ==(Object other) {
    if (ServicoModelo != other.runtimeType) {
      return false;
    }
    other as ServicoModelo;
    return categoria == other.categoria;
  }
} */