import 'package:crud_app/categoria/categoria_controller.dart';
import 'package:crud_app/categoria/categoria_modelo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriaForm extends StatefulWidget {
  final CategoriaModelo? categoriaSelecionada;

  CategoriaForm({this.categoriaSelecionada});

  @override
  _CategoriaFormState createState() => _CategoriaFormState();
}

class _CategoriaFormState extends State<CategoriaForm> {
  //Identificador global deste form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String nome = '';
  String descricao = '';
  String cor = '';

  @override
  void initState() {
    super.initState();
    if (widget.categoriaSelecionada != null) {
      nome = widget.categoriaSelecionada!.nome;
      descricao = widget.categoriaSelecionada!.descricao;
      cor = widget.categoriaSelecionada!.cor;
    }
  }

  @override
  Widget build(BuildContext context) {
    //Para acessarmos o controller que gerencia os dados de pessoa
    final categoriaController = Provider.of<CategoriaController>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 241, 35, 8),
          centerTitle: true,
          title: const Text('Categoria de Produtos'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            //aqui especificamos o identificador do form
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    initialValue: nome,
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'Nome'),
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Informe o nome';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      nome = value!;
                    },
                  ),
                  TextFormField(
                    initialValue: descricao,
                    decoration: const InputDecoration(labelText: 'Descrição'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe a Descrição';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      descricao = value!;
                    },
                  ),
                  TextFormField(
                    initialValue: cor,
                    decoration: const InputDecoration(labelText: 'Cor'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe a Cor';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      cor = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        categoriaController.salvar(CategoriaModelo(
                            nome: nome, descricao: descricao, cor: cor));
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Salvar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
