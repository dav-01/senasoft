import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:notificaciones/models/parking_model.dart';


class AddScreen extends StatelessWidget {
  //object
  final parqueo = new Parking();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Comentario'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
          child: Column(
            children: [
              Text('DATOS'),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'placa',
                  prefixIcon: Icon(Icons.add),
                ),
                onChanged: (value) {
                  parqueo.placa = value;
                },
                maxLength: 20,
              ),
              SizedBox(height: 0.0),
              TextField(
                onChanged: (value) {
                  parqueo.cedula = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                  labelText: 'cedula',
                ),
              ),
              SizedBox(height: 15.0),

              ElevatedButton(
                  onPressed: () async {
                    final data = await enviarDatos(parqueo.toJson());
                    print(data);
                    if (data != null) {
                      print('enviado');
                    } else {
                      print('problemas');
                    }
                    
                  },
                  child: Text('ENVIAR'))
            ],
          ),
        ),
      ),
    );
  }

  Future<Parking> enviarDatos(Map json) async {
    final url = Uri.parse('https://f997-2803-1800-51c0-f8d-3855-1279-7788-fce4.ngrok.io/parking');
    final response = await http.post(url, body: json);
    print(response.body);
    if (response.statusCode == 200) {
      return parkingFromJson(response.body);
    } else {
      return null;
    }
  }
}