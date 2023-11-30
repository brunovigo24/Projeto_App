import 'package:crud_app/menu_navegacao.dart';
import 'package:crud_app/rotas.dart';
import 'package:crud_app/servicos_OUT/servico_controller.dart';
import 'package:crud_app/servicos_OUT/servico_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServicosLista extends StatelessWidget {
  const ServicosLista({super.key});

  @override
  Widget build(BuildContext context) {
    var servicoController = Provider.of<ServicoController>(context);

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const MenuNavegacao(),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 213, 228, 11),
          centerTitle: true,
          title: const Text('Cadastro de Serviços'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //aqui definimos a rota da tela a ser aberta
            Navigator.pushNamed(context, Rotas.SERVICOS_ADD);
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView.builder(
            itemCount: servicoController.servico.length,
            itemBuilder: (BuildContext context, int index) {
              final servico = servicoController.servico[index];
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
                                servicoController.excluir(servico);
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
                  title: Text('Nome: ${servico.nome}'),
                  subtitle: Text('Categoria: ${servico.categoria}'),
                  trailing: IconButton(
                    onPressed: () {
                      // Navegar para a tela de edição com o serviço selecionado
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              ServicoForm(servicoSelecionado: servico),
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
