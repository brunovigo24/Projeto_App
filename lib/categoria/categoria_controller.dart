import 'dart:collection';
import 'package:crud_app/categoria/categoria_modelo.dart';
import 'package:flutter/material.dart';

class CategoriaController extends ChangeNotifier {
  final HashMap<String, CategoriaModelo> _categorias = HashMap();

  List<CategoriaModelo> get categorias => List.unmodifiable(_categorias.values);

  void salvar(CategoriaModelo categoria) {
    _categorias[categoria.id] = categoria;
    notifyListeners();
  }

  void alterar(CategoriaModelo categoria) {
    _categorias.update(categoria.id, (existingCategoria) {
      return categoria;
    });
    notifyListeners();
  }

  void excluir(CategoriaModelo categoria) {
    _categorias.remove(categoria.id);
    notifyListeners();
  }
}
