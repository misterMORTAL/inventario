import 'package:flutter/material.dart';

class Vermas extends StatefulWidget {
  @override
  _VermasState createState() => _VermasState();
}

class _VermasState extends State<Vermas> {
  Future<void> _showMessageDialog(BuildContext context, List<String> messages) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Información'),
          content: Container(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: messages.map((message) => Text(message, textAlign: TextAlign.left)).toList(),
            ),
          ),
          actions: <Widget>[
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
      drawer: Drawer(),
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
                leading: Icon(Icons.person, color: Colors.black),
                title: Text(
                  'leonardo',
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Text(
                  'leonardo@',
                  style: TextStyle(color: Colors.black),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    _showMessageDialog(context, ['Nombre', 'Fecha de nacimiento', 'Dirección', 'Correo electrónico']);
                  },
                  child: Icon(Icons.remove_red_eye, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}