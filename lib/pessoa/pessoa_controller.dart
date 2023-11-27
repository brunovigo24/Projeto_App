import 'dart:collection';
import 'package:crud_app/pessoa/pessoal_modelo.dart';
import 'package:flutter/material.dart';

class PessoaController extends ChangeNotifier {
  final HashMap<String, PessoaModelo> _pessoas = HashMap();

  List<PessoaModelo> get pessoas => List.unmodifiable(_pessoas.values);

  /*void buscarPessoas(UsuarioModelo usuario, {bool forcar = false}) async {
    if (_pessoas == null || forcar) {
      _pessoas = await _pessoaApiGateway.fetchAllPessoas(usuario);
      notifyListeners();
    }
  }

  void salvar(UsuarioModelo usuario, PessoaModelo pessoa) async {
    var pessoaSalva = await _pessoaApiGateway.save(usuario, pessoa);
    if (pessoaSalva != null && _pessoas != null) {
      _pessoas!.add(pessoaSalva);
      notifyListeners();
    }
  }

  void excluir(PessoaModelo pessoa) {
    notifyListeners();
  }
  */
  void salvar(PessoaModelo pessoa) {
    _pessoas[pessoa.id] = pessoa;
    notifyListeners();
  }

  void excluir(PessoaModelo pessoa) {
    _pessoas.remove(pessoa.id);
    notifyListeners();
  }
}
