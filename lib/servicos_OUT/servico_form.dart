/*import 'dart:io';
import 'package:crud_app/servicos/servico_modelo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class ServicoForm extends StatefulWidget {
  final ServicoModelo? servicoSelecionado;

  ServicoForm({super.key, this.servicoSelecionado})

  @override
  _ProdutoFormState createState() => _ProdutoFormState();
  String? savedImagePath;
  File? produtoImage;
}

class _ProdutoFormState extends State<ServicoForm> {
  //Identificador global deste form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final formatoData = DateFormat('dd/MM/yyyy');

  String nome = '';
  DateTime? dataValidade;
  String valor = '';
  String estoque = '';
  String descricao = '';

  File? savedImagePath;
  
  CategoriaModelo? categoriaSelecionada;
  

  @override
  void initState() {
    super.initState();
    if (widget.produtoSelecionado != null) {
      nome = widget.produtoSelecionado!.nome;
      dataValidade = widget.produtoSelecionado!.dataValidade;
      categoriaSelecionada = widget.produtoSelecionado!.categoria;
      valor = widget.produtoSelecionado!.valor;
      estoque = widget.produtoSelecionado!.estoque;
      descricao = widget.produtoSelecionado!.descricao;
    }
  }

  // Função para mostrar o calendário
  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? selecionado = await showDatePicker(
      context: context,
      initialDate: dataValidade ?? DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(2025),
    );
    if (selecionado != null && selecionado != dataValidade) {
      setState(() {
        dataValidade = selecionado;
      });
    }
  }
  Future<void> _tirarFoto() async {
  final picker = ImagePicker();
  final imageFile = await picker.getImage(source: ImageSource.camera);

  if (imageFile == null) {
    // O usuário cancelou a operação
    return;
  }

  final image = File(imageFile.path);
  // Faça algo com a imagem, como exibí-la na interface ou salvá-la no armazenamento.

  // Obtenha o diretório de documentos do aplicativo para salvar a imagem.
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  final imageFileName = '${DateTime.now()}.jpg';
  savedImagePath = await image.copy('${appDocumentDirectory.path}/$imageFileName');
}


  @override
  Widget build(BuildContext context) {
    //Para acessarmos o controller que gerencia os dados de pessoa
    final produtoController = Provider.of<ProdutoController>(context);
    final categoriaController = Provider.of<CategoriaController>(context);
    // Formatando a data selecionada para mostrar
    final dataValidadeFormatada =
        dataValidade == null ? '' : formatoData.format(dataValidade!);

//     var produto;
//     Container(
//     color: produto.categoria.cor, // Use a cor da categoria como cor de fundo
//     child: ListTile(
//     title: Text(produto.nome),
//     subtitle: Text(produto.descricao),
//     trailing: Text('\$${produto.valor.toStringAsFixed(2)}'),
//   ),
// );
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 241, 35, 8),
          centerTitle: true,
          title: const Text('Cadastrar Produto'),
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
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          decoration: const InputDecoration(
                              labelText: 'Data de Validade'),
                          controller: TextEditingController(
                              text: dataValidadeFormatada),
                          validator: (value) {
                            if (dataValidade == null) {
                              return 'Selecione a data de validade';
                            }
                            return null;
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_today),
                        onPressed: () {
                          _selecionarData(context);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  DropdownButton<CategoriaModelo>(
                    value: categoriaSelecionada,
                    items: categoriaController.categorias.map((CategoriaModelo categoria) {
                      return DropdownMenuItem<CategoriaModelo>(
                      value: categoria,
                      child: Text(categoria.nome),
                      );
                    })
                     .toList(),
                       onChanged: (CategoriaModelo? novaCategoria) {
                        setState(() {
                        categoriaSelecionada = novaCategoria;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Valor'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite o valor do produto';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      valor = value!;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Estoque'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite a quantidade de Estoque';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      estoque = value!;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Descrição'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Descricao';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      descricao = value!;
                    },
                  ),
                 ElevatedButton(
                    onPressed: () {
                    _tirarFoto();
                   },
                    child: const Text('Escolher Imagem'),
                  ),    
                const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        produtoController.salvar(ProdutoModelo(
                            nome: nome,
                            categoria: categoriaSelecionada!,
                            dataValidade: dataValidade!,
                            valor: valor,
                            estoque: estoque,
                            descricao: descricao));
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
}*/