import 'package:crud_app/rotas.dart';
import 'package:crud_app/usuario/usuario_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _usuarioController;
  late TextEditingController _senhaController;
  late SharedPreferences _prefs;
  bool _salvarCredenciais = false;
  bool _mostrarSenha = false;

  @override
  void initState() {
    super.initState();
    _usuarioController = TextEditingController();
    _senhaController = TextEditingController();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _usuarioController.text = _prefs.getString('usuario') ?? '';
      _senhaController.text = _prefs.getString('senha') ?? '';
      _salvarCredenciais = _prefs.getBool('salvarCredenciais') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var usuarioController = Provider.of<UsuarioController>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Entrar no Sistema'),
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
                    controller: _usuarioController,
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'Usuário'),
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Informe o usuário';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _senhaController,
                    obscureText: !_mostrarSenha,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      suffixIcon: IconButton(
                        icon: Icon(_mostrarSenha
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _mostrarSenha = !_mostrarSenha;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if ((value ?? '').isEmpty) {
                        return 'Informe a senha';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Checkbox(
                        value: _salvarCredenciais,
                        onChanged: (value) {
                          setState(() {
                            _salvarCredenciais = value ?? false;
                          });
                        },
                      ),
                      const Text('Salvar Credenciais'),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        // Salvar credenciais se a opção estiver marcada
                        if (_salvarCredenciais) {
                          _prefs.setString('usuario', _usuarioController.text);
                          _prefs.setString('senha', _senhaController.text);
                          _prefs.setBool('salvarCredenciais', true);
                        } else {
                          // Caso contrário, limpar as credenciais salvas
                          _prefs.remove('usuario');
                          _prefs.remove('senha');
                          _prefs.remove('salvarCredenciais');
                        }

                        if (await usuarioController.login(
                            _usuarioController.text, _senhaController.text)) {
                          Navigator.pushReplacementNamed(
                              context, Rotas.PESSOAS);
                        } else {
                          const snackBar = SnackBar(
                            content: Text('Usuário ou senha inválidos!'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    child: const Text('Entrar'),
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
