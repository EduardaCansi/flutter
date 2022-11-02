class DiasVividos {
  //atributos privados
  late String _nome = '';
  late int _idade = 0;

  //Construtores
  DiasVividos();
  DiasVividos.iniAll(this._nome, this._idade);
  DiasVividos.iniNome(this._nome) {
    this._idade = 0;
  }

  //Metodos
  int getDiasVividos() {
    return _idade * 356;
  }

  String getResultado() {
    return '$_nome viveu +- ${this.getDiasVividos().toString()} dias.';
  }

  // getters and setters
  String get nome {
    return _nome;
  }

  set nome(String nome) {
    _nome = nome;
  }

  int get idade {
    return _idade;
  }

  set idade(int idade) {
    _idade = idade;
  }
}
