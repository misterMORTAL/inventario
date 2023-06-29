import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:bk/scr/navbar/drawer.dart';
import 'package:bk/scr/navbar/navbar.dart';

class Usuario extends StatefulWidget {
  @override
  _UsuarioState createState() => _UsuarioState();
}

class _UsuarioState extends State<Usuario> {
  List<dynamic> usuarios = [];

  @override
  void initState() {
    super.initState();
    obtenerUsuarios();
  }

  Future<void> obtenerUsuarios() async {
    final url = Uri.parse('http://localhost:8081/api/usuario/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        usuarios = jsonDecode(response.body);
      });
    } else {
      print('Error al obtener los usuarios');
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

  Future<void> eliminarUsuario(int usuarioId) async {
    final url = Uri.parse('http://localhost:8081/api/usuario/$usuarioId/');
    final response = await http.delete(url);

    if (response.statusCode == 204) {
      obtenerUsuarios();
    } else {
      print('Error al eliminar el usuario');
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
          itemCount: usuarios.length,
          itemBuilder: (BuildContext context, int index) {
            final usuario = usuarios[index];
            return Dismissible(
              key: Key(usuario['id'].toString()),
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
                      title: Text('Eliminar Usuario'),
                      content: Text(
                        '¿Estás seguro de que deseas eliminar este usuario?',
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
                            eliminarUsuario(usuario['id']);
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
                  leading: Icon(Icons.person, color: Colors.black),
                  title: GestureDetector(
                    child: Text(
                      usuario['nombre'] ?? '',
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      Navigator.popAndPushNamed(context, "/editarusuario");
                    },
                  ),
                  subtitle: Text(
                    usuario['correoElectronico'] ?? '',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      _showMessageDialog(context, [
                        'Nombre: ${usuario['nombre'] ?? ''}',
                        'Fecha de nacimiento: ${usuario['fechaNacimiento'] ?? ''}',
                        'Dirección: ${usuario['direccion'] ?? ''}',
                        'Correo electrónico: ${usuario['correoElectronico'] ?? ''}',
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
          Navigator.popAndPushNamed(context, "/registrarUsuarios");
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
