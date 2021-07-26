//@dart=2.9
import 'package:flutter/material.dart';
import 'package:gastos_marcos_sousa/component/cria_dropdown.dart';
import 'package:gastos_marcos_sousa/component/cria_textfield.dart';
import 'package:gastos_marcos_sousa/model/gasto.dart';
import 'package:gastos_marcos_sousa/controller/gasto_controller.dart';
import 'package:gastos_marcos_sousa/view/lista_gastos.dart';

class Cadastro extends StatefulWidget {
  //const Cadastro({Key? key}) : super(key: key);

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  var _mes = [
    "Janeiro",
    "Fevereiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro"
  ];
  var _mesSelecionado = 'Janeiro';
  TextEditingController _anoController = TextEditingController();
  TextEditingController _diaController = TextEditingController();
  TextEditingController _mesController = TextEditingController();
  TextEditingController _finalidadeController = TextEditingController();
  TextEditingController _valorController = TextEditingController();

  _alterarMes(String novoMesSelecionado) {
    _dropDownMesSelected(novoMesSelecionado);
    setState(() {
      this._mesSelecionado = novoMesSelecionado;
      _mesController.text = this._mesSelecionado;
    });
  }

  _dropDownMesSelected(String novoMes) {
    setState(() {
      this._mesSelecionado = novoMes;
    });
  }

  GastoController _gastoController = GastoController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _displaySnackBar(BuildContext context, String mensagem) {
    final snackBar = SnackBar(
      content: Text(mensagem),
      backgroundColor: Colors.green[900],
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  _inserir(BuildContext context) {
    Gasto gasto = Gasto(
        null,
        int.parse(_anoController.text),
        int.parse(_diaController.text),
        _mesSelecionado,
        _finalidadeController.text,
        double.parse(_valorController.text));
    setState(() {
      _gastoController.salvar(gasto).then((res) {
        setState(() {
          _displaySnackBar(context, res);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text("Controle de Gastos"),
          backgroundColor: Colors.purple[300],
          centerTitle: true,
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListaGasto()),
                );
              })),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: criaTextField("Ano", _anoController, TextInputType.number),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: criaTextField("Dia", _diaController, TextInputType.number),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                  ),
                  Text(
                    "Mês:",
                    style: TextStyle(color: Colors.purple[300]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child:
                        criaDropDownButton(_mes, _alterarMes, _mesSelecionado),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: criaTextField(
                  "Finalidade", _finalidadeController, TextInputType.text),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: criaTextField("Valor", _valorController,
                  TextInputType.numberWithOptions(decimal: true)),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.maxFinite,
                child: RaisedButton.icon(
                  onPressed: () {
                    _inserir(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  label: Text(
                    'Salvar',
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  textColor: Colors.white,
                  splashColor: Colors.green,
                  color: Colors.purple[300],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
