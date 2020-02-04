class Usuario {
  int _id;
  String _nome;
  String _senha;

  Usuario(this._nome, this._senha);

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}
