import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:bk/scr/navbar/drawer.dart';
import 'package:bk/scr/navbar/navbar.dart';

class Producto extends StatefulWidget {
  @override
  _ProductoState createState() => _ProductoState();
}

class _ProductoState extends State<Producto> {
  List<dynamic> productos = [];

  @override
  void initState() {
    super.initState();
    obtenerProductos();
  }

  Future<void> obtenerProductos() async {
    final url = Uri.parse('http://localhost:8081/api/producto/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        productos = jsonDecode(response.body);
      });
    } else {
      print('Error al obtener los productos');
    }
  }

  void _showMessageDialog(BuildContext context, List<String> details) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Información'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: details
                .map(
                  (detail) => Align(
                    alignment: Alignment.centerLeft,
                    child: Text(detail),
                  ),
                )
                .toList(),
          ),
          actions: [
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> eliminarProducto(int productoId) async {
    final url = Uri.parse('http://localhost:8081/api/producto/$productoId/');
    final response = await http.delete(url);

    if (response.statusCode == 204) {
      obtenerProductos();
    } else {
      print('Error al eliminar el producto');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      backgroundColor: Colors.blue[600],
      body: Padding(
        padding: EdgeInsets.all(35.0),
        child: ListView.builder(
          itemCount: productos.length,
          itemBuilder: (BuildContext context, int index) {
            final producto = productos[index];
            return Dismissible(
              key: Key(producto['nombre']),
              direction: DismissDirection.horizontal,
              background: Container(
                color: Colors.red,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                ),
              ),
              secondaryBackground: Container(
                color: Colors.red,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                ),
              ),
              onDismissed: (direction) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Eliminar Producto'),
                      content: Text(
                        '¿Estás seguro de que deseas eliminar este producto?',
                      ),
                      actions: [
                        TextButton(
                          child: Text('Cancelar'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: Text('Eliminar'),
                          onPressed: () {
                            eliminarProducto(producto['id']);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Card(
                color: Color.fromARGB(255, 54, 240, 230),
                child: ListTile(
                  leading: Icon(Icons.shopping_cart, color: Colors.black),
                  title: GestureDetector(
                    child: Text(
                      producto['nombre'],
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      Navigator.popAndPushNamed(context, "/editarProductos");
                    },
                  ),
                  subtitle: Text(
                    producto['descripcion'],
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      _showMessageDialog(context, [
                        'Nombre: ${producto['nombre']}',
                        'Descripción: ${producto['descripcion']}',
                        'Precio: ${producto['precio']}',
                        'Stock: ${producto['stock']}',
                        'Cantidad: ${producto['cantidad']}',
                      ]);
                    },
                    child: Icon(Icons.remove_red_eye, color: Colors.black),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.popAndPushNamed(context, "/registrarProductos");
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Color.fromARGB(255, 54, 240, 230),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
