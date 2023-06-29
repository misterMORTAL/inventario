import 'package:flutter/material.dart';
import 'package:bk/pages/Usuarios/adit_usuario.dart';
import 'package:bk/pages/Usuarios/gestionarClientes.dart';
import 'package:bk/pages/Usuarios/registrar.dart';
import 'package:bk/pages/almacen/editar.dart';
import 'package:bk/pages/almacen/gestionar.dart';
import 'package:bk/pages/almacen/registrar.dart';
import 'package:bk/pages/categorias/aditar.dart';
import 'package:bk/pages/categorias/gestionar.dart';
import 'package:bk/pages/categorias/registrar.dart';
import 'package:bk/pages/productos/editar.dart';
import 'package:bk/pages/productos/gestionar.dart';
import 'package:bk/pages/productos/registro.dart';
import 'package:bk/pages/provedores/editar.dart';
import 'package:bk/pages/provedores/gestionar.dart';
import 'package:bk/pages/provedores/registrar.dart';
import 'package:bk/pages/roles/editar.dart';
import 'package:bk/pages/roles/gestionar.dart';
import 'package:bk/pages/roles/registrar.dart';
import 'package:bk/scr/inventario.dart';
import 'package:bk/scr/login.dart';
import 'package:bk/scr/notificacion.dart';
import 'package:bk/scr/verMas.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _routes = {
    '/login': (context) => Login(),
    '/inventario': (context) => Inventario(),
    '/usuario': (context) => Usuario(),
    '/vermas': (context) => Vermas(),
    '/notificacion': (context) => Notificacion(),
    '/registrarUsuarios': (context) => AgregarUsuario(),
    '/editarusuario': (context) => EditarUsuario(),
    '/roles': (context) => Roles(),
    '/registrarRoles': (context) => AgregarRoles(),
    '/editroles': (context) => EditRoles(),
    '/productos': (context) => Producto(),
    '/registrarProductos': (context) => AgregarProductos(),
    '/editarProductos': (context) => EditProductos(),
    '/provedores': (context) => Proveedores(),
    '/registrarProvedores': (context) => AgregarProveedores(),
    '/editprovedores': (context) => EditProvedores(),
    '/almacen': (context) => Almacen(),
    '/registrarAlmacen': (context) => AgregarAlmacen(),
    '/editAlmacen': (contex) => EditAlamcen(),
    '/categoria': (contex) => Categoria(),
    '/registrarCategorias': (contex) => AgregarCategoria(),
    '/editcategorias': (contex) => EditCategoria(),

  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: ThemeData(
      //primarySwatch: Colors.blueGrey,
      //),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: '/login',
      routes: _routes,
    );
  }
}
