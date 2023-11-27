import 'package:crud_app/pessoa/pessoa_controller.dart';
import 'package:crud_app/pessoa/pessoal_modelo.dart';
import 'package:crud_app/usuario/usuario_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class PessoaForm extends StatefulWidget {
  PessoaModelo? pessoaSelecionada;

  PessoaForm({super.key, this.pessoaSelecionada});

  @override
  _PessoaFormState createState() => _PessoaFormState(pessoaSelecionada);
}

class _PessoaFormState extends State<PessoaForm> {
  //Identificador global deste form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final formatoData = DateFormat('dd/MM/yyyy');
  final departamentos = ['Contábil', 'RH', 'TI'];
  static const Uuid geradorId = Uuid();

  String nome = '';
  DateTime? dataNascimento;
  String departamento = '';
  String email = '';
  String telefone = '';
  String endereco = '';
  String id = geradorId.v4();

  var usuarioLogado;

  _PessoaFormState(PessoaModelo? pessoa) {
    if (pessoa != null) {
      nome = pessoa.nome;
      dataNascimento = pessoa.dataNascimento;
      departamento = pessoa.departamento;
      email = pessoa.email;
      telefone = pessoa.telefone;
      endereco = pessoa.endereco;
      id = pessoa.id;
    } else {
      departamento = departamentos.first;
    }
  }

  // Função para mostrar o calendário
  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? selecionado = await showDatePicker(
      context: context,
      initialDate: dataNascimento ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selecionado != null && selecionado != dataNascimento) {
      setState(() {
        dataNascimento = selecionado;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //Para acessarmos o controller que gerencia os dados de pessoa
    final pessoaController = Provider.of<PessoaController>(context);

    final usuarioController = Provider.of<UsuarioController>(context);
    usuarioLogado = usuarioController.usuarioLogado;

    // Formatando a data selecionada para mostrar
    final dataNascimentoFormatada =
        dataNascimento == null ? '' : formatoData.format(dataNascimento!);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastrar Contato'),
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
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          decoration: const InputDecoration(
                              labelText: 'Data de Nascimento'),
                          controller: TextEditingController(
                              text: dataNascimentoFormatada),
                          validator: (value) {
                            if (dataNascimento == null) {
                              return 'Selecione a data de nascimento';
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
                  DropdownButton<String>(
                    isExpanded: true,
                    value: departamento,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    onChanged: (String? value) {
                      setState(() {
                        departamento = value!;
                      });
                    },
                    items: departamentos
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  TextFormField(
                    initialValue: email,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite o email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      email = value!;
                    },
                  ),
                  TextFormField(
                    initialValue: telefone,
                    decoration: const InputDecoration(labelText: 'Telefone'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite o telefone';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      telefone = value!;
                    },
                  ),
                  TextFormField(
                    initialValue: endereco,
                    decoration: const InputDecoration(labelText: 'Endereço'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Digite o endereço';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      endereco = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        pessoaController.salvar(
                          /*usuarioLogado,*/
                          PessoaModelo(
                              nome: nome,
                              email: email,
                              dataNascimento: dataNascimento!,
                              departamento: departamento,
                              telefone: telefone,
                              endereco: endereco,
                              id: id),
                        );
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
