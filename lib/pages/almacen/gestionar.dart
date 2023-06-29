import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:bk/scr/navbar/drawer.dart';
import 'package:bk/scr/navbar/navbar.dart';

class Almacen extends StatefulWidget {
  @override
  _AlmacenState createState() => _AlmacenState();
}

class _AlmacenState extends State<Almacen> {
  List<dynamic> almacenes = [];

  @override
  void initState() {
    super.initState();
    obtenerAlmacenes();
  }

  Future<void> obtenerAlmacenes() async {
    final url = Uri.parse('http://localhost:8081/api/almacen/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        almacenes = jsonDecode(response.body);
      });
    } else {
      print('Error al obtener los almacenes');
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

  Future<void> eliminarAlmacen(int almacenId) async {
    final url = Uri.parse('http://localhost:8081/api/almacen/$almacenId/');
    final response = await http.delete(url);

    if (response.statusCode == 204) {
      obtenerAlmacenes();
    } else {
      print('Error al eliminar el almacén');
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
          itemCount: almacenes.length,
          itemBuilder: (BuildContext context, int index) {
            final almacen = almacenes[index];
            return Dismissible(
              key: Key(almacen['nombre']),
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
                      title: Text('Eliminar Almacén'),
                      content: Text(
                        '¿Estás seguro de que deseas eliminar este almacén?',
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
                            eliminarAlmacen(almacen['id']);
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
                  leading: Icon(Icons.store, color: Colors.black),
                  title: GestureDetector(
                    child: Text(
                      almacen['nombre'],
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      Navigator.popAndPushNamed(context, "/editAlmacen");
                    },
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      _showMessageDialog(context, [
                        'Nombre: ${almacen['nombre']}',
                        'Dirección: ${almacen['direccion']}',
                        'Capacidad: ${almacen['capacidad']}',
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
          Navigator.popAndPushNamed(context, "/registrarAlmacen");
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
