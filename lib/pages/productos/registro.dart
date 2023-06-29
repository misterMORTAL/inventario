import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bk/scr/navbar/drawer.dart';
import 'package:bk/scr/navbar/navbar.dart';
import 'package:decimal/decimal.dart';

class AgregarProductos extends StatefulWidget {
  @override
  _AgregarProductosState createState() => _AgregarProductosState();
}

class _AgregarProductosState extends State<AgregarProductos> {
  Decimal precioUnitario = Decimal.zero;
  int cantidad = 0;
  int stockMinimo = 0;

  Future<void> guardarProducto() async {
    final url = Uri.parse('http://localhost:8081/api/producto/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nombre': nombreController.text,
        'precio': precioUnitario.toString(),
        'descripcion': descripcionController.text,
        'stock': stockMinimo.toString(),
        'cantidad': cantidad.toString(),
      }),
    );

    if (response.statusCode == 201) {
      // Producto guardado exitosamente
      Navigator.popAndPushNamed(context, "/productos");
    } else {
      // Error al guardar el producto
      print('Error al guardar el producto');
      Navigator.popAndPushNamed(context, "/productos");
    }
  }

  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();

  @override
  void dispose() {
    nombreController.dispose();
    descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.4, 1.0],
            colors: [Colors.black, Color.fromARGB(255, 8, 144, 17)],
          ),
        ),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20.0),
            Text(
              'Registro',
              style: TextStyle(
                fontFamily: 'cursiva',
                fontSize: 30.0,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              width: 160.0,
              height: 15.0,
            ),
            SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              child: TextField(
                controller: nombreController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Nombre',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              child: TextField(
                controller: descripcionController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Descripcion',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              child: TextField(
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  setState(() {
                    precioUnitario = Decimal.tryParse(value) ?? Decimal.zero;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Precio unitario',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintStyle: TextStyle(color: Colors.black),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              child: TextField(
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  setState(() {
                    cantidad = int.tryParse(value) ?? 0;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Cantidad',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintStyle: TextStyle(color: Colors.black),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              child: TextField(
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  setState(() {
                    stockMinimo = int.tryParse(value) ?? 0;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Stock mínimo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintStyle: TextStyle(color: Colors.black),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: guardarProducto,
                  child: Text(
                    'Guardar',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
