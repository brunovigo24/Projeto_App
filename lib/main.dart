import 'package:crud_app/categoria/categoria_controller.dart';
import 'package:crud_app/navegacao_controller.dart';
import 'package:crud_app/contatos/contatos_controller.dart';
import 'package:crud_app/pessoa/pessoa_controller.dart';
import 'package:crud_app/produtos/produto_controller.dart';
import 'package:crud_app/rotas.dart';
import 'package:crud_app/usuario/usuario_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PessoaController()),
        ChangeNotifierProvider(create: (context) => ProdutoController()),
        ChangeNotifierProvider(create: (context) => NavegacaoController()),
        ChangeNotifierProvider(create: (context) => UsuarioController()),
        ChangeNotifierProvider(create: (context) => CategoriaController()),
      ],
      child: MaterialApp(
        initialRoute: Rotas.LOGIN,
        //aqui definimos as rotas para todas as telas do app
        routes: Rotas.widgetsMap(),
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.lightBlue,
        ),
      ),
    );
  }
}
