class Imc {
  //atributos privados
  late String _nome = '';
  late int _peso = 0;
  late int _altura = 0;
  late double _imc = 0;

  //Construtores
  Imc();
  Imc.iniAll(this._nome, this._altura, this._peso, this._imc);

  //Metodos
  double getImc() {
    return _imc = (_altura * _altura) / _peso;
  }

  String getResultado() {
    return 'IMC = ${getImc().toString()}';
  }

  // getters and setters
  String get nome {
    return _nome;
  }

  set nome(String nome) {
    _nome = nome;
  }

  int get peso {
    return _peso;
  }

  set peso(int peso) {
    _peso = peso;
  }

  int get altura {
    return _altura;
  }

  set altura(int altura) {
    _altura = altura;
  }

  double get imc {
    return _imc;
  }

  set imc(double imc) {
    _imc = imc;
  }
}
