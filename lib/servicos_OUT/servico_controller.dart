/*import 'dart:collection';
import 'package:crud_app/servicos/servico_modelo.dart';
import 'package:flutter/material.dart';

class ServicoController extends ChangeNotifier {
  final HashMap<String, ServicoModelo> _servicos = HashMap();

  List<ServicoModelo> get servico => List.unmodifiable(_servicos.values);

  void salvar(ServicoModelo servico) {
    _servicos[servico.nome] = servico;
    notifyListeners();
  }

    void alterar(ServicoModelo servico) {
    _servicos.update(servico.nome, (existingServico){
      return servico;
    });
    notifyListeners();
  }


  void excluir(ServicoModelo servicos) {
    _servicos.remove(servicos.nome);
    notifyListeners();
  }
} */
