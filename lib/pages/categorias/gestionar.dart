import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:bk/scr/navbar/drawer.dart';
import 'package:bk/scr/navbar/navbar.dart';

class Categoria extends StatefulWidget {
  @override
  _CategoriaState createState() => _CategoriaState();
}

class _CategoriaState extends State<Categoria> {
  List<dynamic> categorias = [];

  @override
  void initState() {
    super.initState();
    obtenerCategorias();
  }

  Future<void> obtenerCategorias() async {
    final url = Uri.parse('http://localhost:8081/api/categorias/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        categorias = jsonDecode(response.body);
      });
    } else {
      print('Error al obtener las categorías');
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

  Future<void> eliminarCategoria(int categoriaId) async {
    final url = Uri.parse('http://localhost:8081/api/categorias/$categoriaId/');
    final response = await http.delete(url);

    if (response.statusCode == 204) {
      obtenerCategorias();
    } else {
      print('Error al eliminar la categoría');
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
          itemCount: categorias.length,
          itemBuilder: (BuildContext context, int index) {
            final categoria = categorias[index];
            return Dismissible(
              key: Key(categoria['nombre']),
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
                      title: Text('Eliminar la Categoría'),
                      content: Text(
                        '¿Estás seguro de que deseas eliminar esta categoría?',
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
                            eliminarCategoria(categoria['id']);
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
                  leading: Icon(Icons.assignment_add, color: Colors.black),
                  title: GestureDetector(
                    child: Text(
                      categoria['nombre'],
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      Navigator.popAndPushNamed(context, "/editcategorias");
                    },
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      _showMessageDialog(context, [
                        'Nombre: ${categoria['nombre']}',
                        'Descripción: ${categoria['descripcion']}',
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
          Navigator.popAndPushNamed(context, "/registrarCategorias");
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
