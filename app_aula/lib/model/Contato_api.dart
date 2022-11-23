class ContatoApi {
  String? id;
  String? nome;
  String? email;
  String? telefone;

  ContatoApi() {
    id = null;
    nome = "";
    email = "";
    telefone = "";
  }

  ContatoApi.init(this.id, this.nome, this.email, this.telefone);

  // do json para o objeto
  factory ContatoApi.fromMap(Map<String, dynamic> json) {
    return ContatoApi.init(
        json['_id'], json['nome'], json['email'], json['telefone']);
  }

  // do objeto para json
  Map<String, dynamic> toMap() =>
      {'_id': id, 'nome': nome, 'email': email, 'telefone': telefone};
}
