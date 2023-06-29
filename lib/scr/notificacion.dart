import 'package:flutter/material.dart';


class Notificacion extends StatefulWidget {
  @override
  _NotificacionState createState() => _NotificacionState();
}

class _NotificacionState extends State<Notificacion> {
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/usuario');
          },
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
            color: Colors.black,
          ),
        ],
      ),
      backgroundColor: Colors.blue[600],
      body: Padding(
        padding: EdgeInsets.all(35.0),
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10.0),
                Text(
                  'Notificaciones',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'cursiva',
                    fontSize: 30.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.0),
            Card(
              color: Color.fromARGB(255, 54, 240, 230),
              child: ListTile(
                title: Text(
                  'No hay productos en stock',
                  style: TextStyle(color: Colors.black),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(context, "");
                  },
                  child: Icon(Icons.warning, color: Colors.black),
                ),
              ),
            ),
            Card(
              color: Color.fromARGB(255, 54, 240, 230),
              child: ListTile(
                title: Text(
                  'No hay productos en stock',
                  style: TextStyle(color: Colors.black),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(context, "");
                  },
                  child: Icon(Icons.warning, color: Colors.black),
                ),
              ),
            ),
            Card(
              color: Color.fromARGB(255, 54, 240, 230),
              child: ListTile(
                title: Text(
                  'No hay productos en stock',
                  style: TextStyle(color: Colors.black),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(context, "");
                  },
                  child: Icon(Icons.warning, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}