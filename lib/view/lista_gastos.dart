//@dart=2.9
import 'package:flutter/material.dart';
import 'package:gastos_marcos_sousa/controller/gasto_controller.dart';
import 'package:gastos_marcos_sousa/view/busca.dart';
import 'package:gastos_marcos_sousa/view/cadastro_gastos.dart';
import 'package:gastos_marcos_sousa/view/gasto_item.dart';
import 'package:gastos_marcos_sousa/model/gasto.dart';

class ListaGasto extends StatefulWidget {
  @override
  _ListaGastoState createState() => _ListaGastoState();
}

class _ListaGastoState extends State<ListaGasto> {
  GastoController _gastoController = GastoController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Controle de Gastos"),
        backgroundColor: Colors.purple[300],
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BuscaGasto(),
                  ),
                );
              },
              icon: Icon(Icons.search)),
        ],
      ),
      body: FutureBuilder<List<Gasto>>(
        initialData: List(),
        future: _gastoController.findAll(),
        // ignore: missing_return
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("Carregando..."),
                  ],
                ),
              );
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Gasto> gastos = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Gasto gasto = gastos[index];
                  return GastoItem(gasto);
                },
                itemCount: gastos.length,
              );
              break;
          }
          return Text("Erro");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Cadastro(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple[300],
      ),
    );
  }
}
