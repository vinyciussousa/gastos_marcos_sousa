//@dart=2.9
import 'package:flutter/material.dart';
import 'package:gastos_marcos_sousa/model/gasto.dart';

class GastoItem extends StatelessWidget {
  final Gasto _gasto;
  GastoItem(this._gasto);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.purple[300],
      child: ListTile(
        title: Text(
          _gasto.finalidade,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        subtitle: Text(
          "$_gasto",
          style: TextStyle(
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
}
