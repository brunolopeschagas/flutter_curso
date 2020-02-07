class Usuario {
  int _id;
  String _nome;
  String _senha;

  Usuario(this._nome, this._senha);

  Usuario.map(dynamic obj) {
    this._nome = obj['nome'];
    this._senha = obj['senha'];
    this._id = obj['id'];
  }

  Usuario.fromMap(Map<String, dynamic> map) {
    this._nome = map['nome'];
    this._senha = map['senha'];
    this._id = map['id'];
  }

  Map<String, dynamic> toMap() {
    Map map = new Map<String, dynamic>();
    map['nome'] = _nome;
    map['senha'] = _senha;

    if (id != null) {
      map['id'] = _id;
    }

    return map;
  }

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
