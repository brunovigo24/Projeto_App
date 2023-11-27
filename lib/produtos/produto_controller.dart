import 'dart:collection';

import 'package:crud_app/produtos/produto_modelo.dart';
import 'package:flutter/material.dart';

class ProdutoController extends ChangeNotifier {
  final HashMap<String, ProdutoModelo> _produtos = HashMap();

  List<ProdutoModelo> get produto => List.unmodifiable(_produtos.values);

  void salvar(ProdutoModelo produto) {
    _produtos[produto.nome] = produto;
    notifyListeners();
  }

  void alterar(ProdutoModelo produto) {
    _produtos.update(produto.nome, (existingProduto) {
      return produto;
    });
    notifyListeners();
  }

  void excluir(ProdutoModelo produto) {
    _produtos.remove(produto.nome);
    notifyListeners();
  }
}
