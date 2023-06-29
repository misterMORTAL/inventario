import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AgregarProveedores extends StatefulWidget {
  @override
  _AgregarProveedoresState createState() => _AgregarProveedoresState();
}

class _AgregarProveedoresState extends State<AgregarProveedores> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController direccionController = TextEditingController();

  Future<void> guardarProveedor() async {
    final url = Uri.parse('http://localhost:8081/api/proveedor/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nombre': nombreController.text,
        'direccion': direccionController.text,
      }),
    );

    if (response.statusCode == 201) {
      // Proveedor guardado exitosamente
      Navigator.popAndPushNamed(context, "/provedores");
    } else {
      // Error al guardar el proveedor
      print('Error al guardar el proveedor');
      Navigator.popAndPushNamed(context, "/provedores");
    }
  }

  @override
  void dispose() {
    nombreController.dispose();
    direccionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Proveedor'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.green],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Registro de Proveedores',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: nombreController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Nombre',
                  suffixIcon: Icon(Icons.verified_user, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: direccionController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'Dirección',
                  suffixIcon: Icon(Icons.location_on, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintStyle: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: guardarProveedor,
                    child: Text(
                      'Guardar',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
      ),
    );
  }
}
