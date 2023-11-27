import 'package:crud_app/categoria/categoria_lista.dart';
import 'package:crud_app/navegacao_controller.dart';
import 'package:crud_app/pessoa/pessoas_lista.dart';
import 'package:crud_app/produtos/produtos_lista.dart';
import 'package:crud_app/rotas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuNavegacao extends StatefulWidget {
  const MenuNavegacao({super.key});

  @override
  State<MenuNavegacao> createState() => _MenuNavegacaoState();
}

class _MenuNavegacaoState extends State<MenuNavegacao> {
  Widget _getRotaSelecionada(int index) {
    return {
          0: PessoasLista(),
          1: ProdutosLista(),
          2: CategoriaLista(),
        }[index] ??
        PessoasLista();
  }

  @override
  Widget build(BuildContext context) {
    var navegacaoController = Provider.of<NavegacaoController>(context);

    return NavigationBar(
      onDestinationSelected: (int index) {
        navegacaoController.atualizarTelaSelecionada(index);
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                _getRotaSelecionada(index),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
      indicatorColor: Color.fromARGB(255, 47, 124, 175),
      selectedIndex: navegacaoController.telaSelecionada,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.person_2),
          icon: Icon(Icons.person_2_outlined),
          label: 'Pessoas',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.store),
          icon: Icon(Icons.store_outlined),
          label: 'Produtos',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.store),
          icon: Icon(Icons.store_outlined),
          label: 'Categorias',
        ),
      ],
    );
  }
}
