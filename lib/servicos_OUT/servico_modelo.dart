import 'dart:io';

class ServicoModelo {
  String nome;
  final ServicoModelo categoria;
  String descricao;
  String valor;
  String duracao;

  ServicoModelo(
      {required this.nome,
      required this.categoria,
      required this.descricao,
      required this.valor,
      required this.duracao});

  @override
  int get hashCode => categoria.hashCode;

  File? get imagem => null;

  get categoriaServico => null;

  @override
  bool operator ==(Object other) {
    if (ServicoModelo != other.runtimeType) {
      return false;
    }
    other as ServicoModelo;
    return categoria == other.categoria;
  }
}
