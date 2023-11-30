import 'dart:js';

import 'package:crud_app/categoria/categoria_form.dart';
import 'package:crud_app/categoria/categoria_lista.dart';
import 'package:crud_app/pessoa/pessoa_form.dart';
import 'package:crud_app/pessoa/pessoas_lista.dart';
import 'package:crud_app/produtos/produto_form.dart';
import 'package:crud_app/produtos/produtos_lista.dart';
import 'package:crud_app/servicos_OUT/servico_form.dart';
import 'package:crud_app/servicos_OUT/servico_lista.dart';
import 'package:crud_app/usuario/login_form.dart';
import 'package:flutter/material.dart';

class Rotas {
  //Rotas principais
  static const String LOGIN = '/login';
  static const String REGISTRAR = '/registrar';
  static const String PESSOAS = '/pessoas';
  static const String PRODUTOS = '/produtos';
  static const String CATEGORIAS = '/categorias';
  static const String SERVICOS = '/servicos';

  //Sub-rotas
  static const String PESSOAS_ADD = '/pessoas/add';
  static const String SERVICOS_ADD = '/servicos/add';
  static const String PRODUTOS_ADD = '/produtos/add';
  static const String CATEGORIA_ADD = '/categorias/add';
  static const String SERVICO_ADD = '/servicos/add';

  //Mapeamento de rotas para telas
  //Falta adicionar o servicos aqui
  static Map<String, WidgetBuilder> widgetsMap() {
    return {
      PESSOAS: (context) => const PessoasLista(),
      PESSOAS_ADD: (context) => PessoaForm(),
      LOGIN: (context) => const LoginForm(),
      PRODUTOS: (context) => const ProdutosLista(),
      PRODUTOS_ADD: (context) => ProdutoForm(),
      CATEGORIAS: (context) => const CategoriaLista(),
      CATEGORIA_ADD: (context) => CategoriaForm(),
      SERVICOS: (context) => const ServicosLista(),
      SERVICOS_ADD: (context) => ServicoForm(),
    };
  }
}
