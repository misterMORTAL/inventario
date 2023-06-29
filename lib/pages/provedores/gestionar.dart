import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:bk/scr/navbar/drawer.dart';
import 'package:bk/scr/navbar/navbar.dart';

class Proveedores extends StatefulWidget {
  @override
  _ProveedoresState createState() => _ProveedoresState();
}

class _ProveedoresState extends State<Proveedores> {
  List<dynamic> proveedores = [];

  @override
  void initState() {
    super.initState();
    obtenerProveedores();
  }

  Future<void> obtenerProveedores() async {
    final url = Uri.parse('http://localhost:8081/api/proveedor/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        proveedores = jsonDecode(response.body);
      });
    } else {
      print('Error al obtener los proveedores');
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

  Future<void> eliminarProveedor(int proveedorId) async {
    final url = Uri.parse('http://localhost:8081/api/proveedor/$proveedorId/');
    final response = await http.delete(url);

    if (response.statusCode == 204) {
      obtenerProveedores();
    } else {
      print('Error al eliminar el proveedor');
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
          itemCount: proveedores.length,
          itemBuilder: (BuildContext context, int index) {
            final proveedor = proveedores[index];
            return Dismissible(
              key: Key(proveedor['nombre']),
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
                      title: Text('Eliminar Proveedor'),
                      content: Text(
                        '¿Estás seguro de que deseas eliminar este proveedor?',
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
                            eliminarProveedor(proveedor['id']);
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
                  leading: Icon(Icons.groups, color: Colors.black),
                  title: GestureDetector(
                    child: Text(
                      proveedor['nombre'],
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      Navigator.popAndPushNamed(context, "/editprovedores");
                    },
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      _showMessageDialog(context, [
                        'Nombre: ${proveedor['nombre']}',
                        'Dirección: ${proveedor['direccion']}',
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
          Navigator.popAndPushNamed(context, "/registrarProvedores");
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
