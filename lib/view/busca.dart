//@dart=2.9

import 'package:flutter/material.dart';
import 'package:gastos_marcos_sousa/controller/gasto_controller.dart';
import 'package:gastos_marcos_sousa/view/cadastro_gastos.dart';
import 'package:gastos_marcos_sousa/view/gasto_item.dart';
import 'package:gastos_marcos_sousa/model/gasto.dart';
import 'package:gastos_marcos_sousa/component/cria_textfield.dart';
import 'package:gastos_marcos_sousa/component/cria_dropdown.dart';

class BuscaGasto extends StatefulWidget {
  //const BuscaGasto({ Key? key }) : super(key: key);

  @override
  _BuscaGastoState createState() => _BuscaGastoState();
}

class _BuscaGastoState extends State<BuscaGasto> {
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

  _alterarMes(String novoMesSelecionado) {
    _dropDownMesSelected(novoMesSelecionado);
    setState(() {
      this._mesSelecionado = novoMesSelecionado;
      _buscaMesController.text = this._mesSelecionado;
    });
  }

  _dropDownMesSelected(String novoMes) {
    setState(() {
      this._mesSelecionado = novoMes;
    });
  }

  TextEditingController _buscaAnoController = TextEditingController();
  TextEditingController _buscaMesController = TextEditingController();
  TextEditingController _buscaDiaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Controle de Gastos"),
        backgroundColor: Colors.purple[300],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: criaTextField(
                  "Dia", _buscaDiaController, TextInputType.number),
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
                  "Ano", _buscaAnoController, TextInputType.number),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Buscar"),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.purple[300]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
