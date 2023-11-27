import 'package:crud_app/categoria/categoria_modelo.dart';

class ProdutoModelo {
  String nome;
  final CategoriaModelo categoria;
  DateTime dataValidade;
  String valor;
  String estoque;
  String descricao;

  ProdutoModelo(
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
    if (ProdutoModelo != other.runtimeType) {
      return false;
    }
    other as ProdutoModelo;
    return categoria == other.categoria;
  }
}
