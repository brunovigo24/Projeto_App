class PessoaModelo {
  String nome;
  String email;
  DateTime dataNascimento;
  String departamento;
  String telefone;
  String endereco;
  String id;

  PessoaModelo(
      {required this.nome,
      required this.email,
      required this.dataNascimento,
      required this.departamento,
      required this.telefone,
      required this.endereco,
      required this.id});

  @override
  int get hashCode => email.hashCode;

  @override
  bool operator ==(Object other) {
    if (PessoaModelo != other.runtimeType) {
      return false;
    }
    other as PessoaModelo;
    return id == other.id;
  }

  factory PessoaModelo.fromJson(Map<String, dynamic> json) => PessoaModelo(
        id: json["id"],
        nome: json["nome"],
        email: json["email"],
        dataNascimento: DateTime.parse(json["dataNascimento"]),
        departamento: json["departamento"],
        telefone: json["telefone"],
        endereco: json["endereco"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nome": nome,
        "email": email,
        "dataNascimento":
            "${dataNascimento.year}-${dataNascimento.month}-${dataNascimento.day}",
        "departamento": departamento,
        "telefone": telefone,
        "endereco": endereco,
      };
}
