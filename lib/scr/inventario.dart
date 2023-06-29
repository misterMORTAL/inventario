import 'package:flutter/material.dart';

class Inventario extends StatefulWidget {
  @override
  _InventarioState createState() => _InventarioState();
}

class _InventarioState extends State<Inventario> {
  int notificationCount = 3; // Cantidad de notificaciones

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fly Style',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.popAndPushNamed(context, "/notificacion");
                },
                color: Colors.black,
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    notificationCount.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                'Santiago',
                style: TextStyle(color: Colors.white),
              ),
              accountEmail: Text(
                'Santiago@gmail.com',
                style: TextStyle(color: Colors.white),
              ),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.asset('assets/logo-sec.png'),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue[900],
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle, color: Colors.blue),
              title: Text(
                'Gestion de usuarios',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, '/usuario');
              },
            ),
            ListTile(
              leading: Icon(Icons.accessibility, color: Colors.blue),
              title: Text(
                'Gestion de roles',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, '/roles');
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart, color: Colors.blue),
              title: Text(
                'Gestion de productos',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, "/productos");
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment, color: Colors.blue),
              title: Text(
                'Gestion de categorias',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, "/categoria");
              },
            ),
            ListTile(
              leading: Icon(Icons.groups, color: Colors.blue),
              title: Text(
                'Gestion de proveedores',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, "/provedores");
              },
            ),
            ListTile(
              leading: Icon(Icons.store, color: Colors.blue),
              title: Text(
                'Gestion de almacen',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                Navigator.popAndPushNamed(context, "/almacen");
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.blue[600],
      body: Padding(
        padding: EdgeInsets.all(35.0),
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return FractionallySizedBox(
                      widthFactor: 0.5,
                      child: Container(
                        height: constraints.maxWidth * 0.6,
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundColor: Colors.grey,
                          backgroundImage: AssetImage('assets/logo-sec.png'),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10.0),
                Text(
                  'Bienvenido',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'cursiva',
                    fontSize: 30.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.0),
            Card(
              color: Color.fromARGB(255, 54, 240, 230),
              child: ListTile(
                leading: Icon(Icons.account_circle, color: Colors.black),
                title: Text(
                  'Gestion de usuarios',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(context, "/usuario");
                },
              ),
            ),
            Card(
              color: Color.fromARGB(255, 54, 240, 230),
              child: ListTile(
                leading: Icon(Icons.accessibility, color: Colors.black),
                title: Text(
                  'Gestion de roles',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(context, "/roles");
                },
              ),
            ),
            Card(
              color: Color.fromARGB(255, 54, 240, 230),
              child: ListTile(
                leading: Icon(Icons.shopping_cart, color: Colors.black),
                title: Text(
                  'Gestion de productos',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(context, "/productos");
                },
              ),
            ),
            Card(
              color: Color.fromARGB(255, 54, 240, 230),
              child: ListTile(
                leading: Icon(Icons.assignment, color: Colors.black),
                title: Text(
                  'Gestion de categorias',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(context, "/categoria");
                },
              ),
            ),
            Card(
              color: Color.fromARGB(255, 54, 240, 230),
              child: ListTile(
                leading: Icon(Icons.groups, color: Colors.black),
                title: Text(
                  'Gestion de proveedores',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(context, "/provedores");
                },
              ),
            ),
            Card(
              color: Color.fromARGB(255, 54, 240, 230),
              child: ListTile(
                leading: Icon(Icons.store, color: Colors.black),
                title: Text(
                  'Gestion de almacen',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.popAndPushNamed(context, "/almacen");
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
