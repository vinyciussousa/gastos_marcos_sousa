//@dart=2.9
import 'package:gastos_marcos_sousa/model/gasto.dart';
import 'package:gastos_marcos_sousa/persistence/gasto_dao.dart';

class GastoController {
  Future<String> salvar(Gasto gasto) async {
    int res = 0;
    if (gasto.id == null) {
      res = await GastoDao.inserir(gasto);
    } else {
      res = await GastoDao.alterar(gasto);
    }

    if (res == 0) {
      return "Erro ao salvar o registro.";
    } else {
      return "Salvo com sucesso.";
    }
  }

  Future<String> excluir(int id) async {
    int res = 0;
    res = await GastoDao.excluir(id);
    if (res == 0) {
      return "Erro ao excluir registro";
    } else {
      return "Excluído com sucesso.";
    }
  }

  Future<List<Gasto>> findAll() async {
    List<Gasto> gastos = await GastoDao.findAll();
    return gastos;
  }
}
