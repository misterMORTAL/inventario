import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            color: Colors.blue[900], // Cambio de color a azul marino
            child: UserAccountsDrawerHeader(
              accountName: Text(
                'Santiago',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              accountEmail: Text(
                'Santiago@gmail.com',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.asset(
                    'assets/logo-sec.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.blue[900],
            ),
            title: Text(
              'Inicio',
              style: TextStyle(
                color: Colors.blue[900],
              ),
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, '/inventario');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: Colors.blue[900],
            ),
            title: Text(
              'Gestión de usuarios',
              style: TextStyle(
                color: Colors.blue[900],
              ),
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, '/usuario');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.accessibility,
              color: Colors.blue[900],
            ),
            title: Text(
              'Gestión de roles',
              style: TextStyle(
                color: Colors.blue[900],
              ),
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, '/roles');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_cart,
              color: Colors.blue[900],
            ),
            title: Text(
              'Gestión de productos',
              style: TextStyle(
                color: Colors.blue[900],
              ),
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, '/productos');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.assignment,
              color: Colors.blue[900],
            ),
            title: Text(
              'Gestión de categorías',
              style: TextStyle(
                color: Colors.blue[900],
              ),
            ),
            onTap: () {
              Navigator.popAndPushNamed(context, '/categoria');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.groups,
              color: Colors.blue[900],
            ),
            title: Text(
              'Gestión de proveedores',
              style: TextStyle(
                color: Colors.blue[900],
              ),
            ),
            onTap: () => Navigator.popAndPushNamed(context, '/provedores'),
          ),
          ListTile(
            leading: Icon(
              Icons.store,
              color: Colors.blue[900],
            ),
            title: Text(
              'Gestión de almacén',
              style: TextStyle(
                color: Colors.blue[900],
              ),
            ),
            onTap: () => Navigator.popAndPushNamed(context, '/almacen'),
          ),
        ],
      ),
    );
  }
}
