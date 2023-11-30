import 'dart:io';

import 'package:crud_app/servicos_OUT/servico_controller.dart';
import 'package:crud_app/servicos_OUT/servico_modelo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ServicoForm extends StatefulWidget {
  final ServicoModelo? servicoSelecionado;

  ServicoForm({super.key, this.servicoSelecionado}) {
    // Inicializa o savedImagePath com uma string vazia se nenhum serviço for selecionado
    if (servicoSelecionado == null) {
      savedImagePath = '';
    }
  }

  @override
  _ServicoFormState createState() => _ServicoFormState();

  String? savedImagePath;
  File? servicoImage;
}

class _ServicoFormState extends State<ServicoForm> {
  // Identificador global deste form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String nome = '';
  String categoria = '';
  String descricao = '';
  String valor = '';
  String duracao = '';

  File? savedImagePath;

  //CategoriaServicoModelo? categoriaSelecionada;

  @override
  void initState() {
    super.initState();

    if (widget.servicoSelecionado != null) {
      nome = widget.servicoSelecionado!.nome;
      //Categoria vai entrar na proxima implementação
      //categoria = widget.servicoSelecionado!.categoria;
      descricao = widget.servicoSelecionado!.descricao;
      valor = widget.servicoSelecionado!.valor;
      duracao = widget.servicoSelecionado!.duracao;
      savedImagePath = widget.servicoSelecionado!.imagem;
      //Categoria vai entrar na proxima implementação
      //categoriaSelecionada = widget.servicoSelecionado!.categoriaServico;
    }
  }

  Future<void> _tirarFoto() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.camera);

    if (imageFile == null) {
      // O usuário cancelou a operação
      return;
    }

    final image = File(imageFile.path);
    // Faça algo com a imagem, como exibí-la na interface ou salvá-la no armazenamento.

    // Obtenha o diretório de documentos do aplicativo para salvar a imagem.
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    final imageFileName = '${DateTime.now()}.jpg';
    savedImagePath =
        await image.copy('${appDocumentDirectory.path}/$imageFileName');
  }

  @override
  Widget build(BuildContext context) {
    // Para acessarmos o controller que gerencia os dados de serviço
    final servicoController = Provider.of<ServicoController>(context);
    //Categoria vai entrar na proxima implementação
    //final categoriaController = Provider.of<ServicoController>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 241, 35, 8),
          centerTitle: true,
          title: const Text('Cadastrar Serviço'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'Nome'),
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Informe o nome do serviço';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      nome = value!;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Descrição'),
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Informe a descrição do serviço';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      descricao = value!;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Valor'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Informe o valor do serviço';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      valor = value!;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Duração'),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Informe a duração do serviço';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getApplicationDocumentsDirectory() {}
}
