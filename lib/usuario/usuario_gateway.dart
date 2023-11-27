/*import 'package:crud_app/usuario/usuario_model.dart';
import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

class UsuarioApiGateway {
  //O endereco 10.0.2.2 é necessário quando rodamos pelo emulador
  static const LOGIN_URL = "http://10.0.2.2:8080/publico/usuarios/login";
  final dio = Dio();
  final log = Logger('UsuarioApiGateway');

  Future<UsuarioModelo?> login(String usuario, String senha) async {
    try {
      var response = await dio.post(LOGIN_URL, data: {
        "usuario": usuario,
        "senha": senha,
      });
      if (response.statusCode == 200) {
        return UsuarioModelo(usuario, senha);
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        log.severe(e.response!.data);
        log.severe(e.response!.headers);
        log.severe(e.response!.requestOptions);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        log.severe(e.requestOptions);
        log.severe(e.message);
      }
    }
    return null;
  }
}*/
