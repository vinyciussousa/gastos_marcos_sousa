//@dart=2.9
class Gasto {
  int _id;
  int _ano;
  int _dia;
  String _mes;
  String _finalidade;
  double _valor;

  Gasto(
      this._id, this._ano, this._dia, this._mes, this._finalidade, this._valor);

  int get id => _id;
  int get ano => _ano;
  int get dia => _dia;
  String get mes => _mes;
  String get finalidade => _finalidade;
  double get valor => _valor;

  set id(int value) {
    _id = value;
  }

  Map getGasto() {
    Map<String, dynamic> gasto = Map();
    gasto["_id"] = _id;
    gasto["ano"] = _ano;
    gasto["dia"] = _dia;
    gasto["mes"] = _mes;
    gasto["finalidade"] = _finalidade;
    gasto["valor"] = _valor;
    return gasto;
  }

  @override
  String toString() {
    return "Ano: $_ano \n Dia: $_dia \n Mês: $_mes \n Finalidade: $_finalidade \n Valor: $_valor";
  }
}
