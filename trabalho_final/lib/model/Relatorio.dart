class Relatorio {
  String? id;
  String? nome;
  String? telefone;
  String? rua;
  String? bairro;
  String? pontoRef;
  String? problema;

  Relatorio() {
    id = null;
    nome = "";
    telefone = "";
    rua = "";
    bairro = "";
    pontoRef = "";
    problema = "";
  }

  Relatorio.init(this.id, this.nome, this.telefone, this.rua, this.bairro, this.pontoRef, this.problema);

  factory Relatorio.fromMap(Map<String, dynamic> json) {
    return Relatorio.init(
        json['_id'], json['nome'], json['telefone'], json['rua'], json['bairro'], 
        json['pontoRef'], json['problema'],);
  }

  Map<String, dynamic> toMap() =>
      {'_id': id, 'nome': nome, 'telefone': telefone, 'rua': rua, 
      'bairro': bairro, 'pontoRef': pontoRef, 'problema': problema};

  @override
  toString() {
    return '$nome';
  }

  bool operator ==(other) {
    return (other is Relatorio && other.id == id);
  }
}
