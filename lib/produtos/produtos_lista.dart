import 'package:crud_app/menu_navegacao.dart';
import 'package:crud_app/produtos/produto_controller.dart';
import 'package:crud_app/produtos/produto_form.dart';
import 'package:crud_app/rotas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProdutosLista extends StatelessWidget {
  const ProdutosLista({super.key});

  @override
  Widget build(BuildContext context) {
    var produtoController = Provider.of<ProdutoController>(context);

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const MenuNavegacao(),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(11, 141, 228, 1),
          centerTitle: true,
          title: const Text('Cadastro de Produtos'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //aqui definimos a rota da tela a ser aberta
            Navigator.pushNamed(context, Rotas.PRODUTOS_ADD);
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView.builder(
            itemCount: produtoController.produto.length,
            itemBuilder: (BuildContext context, int index) {
              final produto = produtoController.produto[index];
              return Card(
                margin: const EdgeInsets.all(8),
                // incluir um botão para excluir neste card
                child: ListTile(
                  leading: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Confirmar Exclusão"),
                          content:
                              const Text("Tem certeza que deseja excluir?"),
                          actions: [
                            TextButton(
                              child: const Text('Confirmar'),
                              onPressed: () {
                                produtoController.excluir(produto);
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Cancelar'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  title: Text('Nome: ${produto.nome}'),
                  subtitle: Text('categoria: ${produto.categoria}'),
                  trailing: IconButton(
                    onPressed: () {
                      // Navegar para a tela de edição com o produto selecionado
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              ProdutoForm(produtoSelecionado: produto),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  onTap: () {
                    // Ação quando o ListTile é pressionado (se necessário)
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
