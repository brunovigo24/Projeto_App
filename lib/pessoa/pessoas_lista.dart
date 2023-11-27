import 'package:crud_app/menu_navegacao.dart';
import 'package:crud_app/pessoa/pessoa_controller.dart';
import 'package:crud_app/pessoa/pessoa_form.dart';
import 'package:crud_app/rotas.dart';
import 'package:crud_app/usuario/usuario_controller.dart';
import 'package:crud_app/usuario/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PessoasLista extends StatefulWidget {
  const PessoasLista({super.key});

  @override
  State<PessoasLista> createState() => _PessoasListaState();
}

class _PessoasListaState extends State<PessoasLista> {
  UsuarioModelo? usuarioLogado;

  @override
  Widget build(BuildContext context) {
    var pessoaController = Provider.of<PessoaController>(context);
    var usuarioController = Provider.of<UsuarioController>(context);
    usuarioLogado = usuarioController.usuarioLogado;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const MenuNavegacao(),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(11, 141, 228, 1),
          centerTitle: true,
          title: const Text('Cadastro de Contatos'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, Rotas.PESSOAS_ADD);
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView.builder(
            itemCount: pessoaController.pessoas.length,
            itemBuilder: (BuildContext context, int index) {
              final pessoa = pessoaController.pessoas[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text('Nome: ${pessoa.nome}'),
                  subtitle: Text('Email: ${pessoa.email}'),
                  trailing: IconButton(
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
                                pessoaController.excluir(pessoa);
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            PessoaForm(pessoaSelecionada: pessoa),
                      ),
                    );
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
