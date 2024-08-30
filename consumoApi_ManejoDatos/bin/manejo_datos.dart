import 'dart:convert';
import 'package:http/http.dart' as http;
import '../lib/user.dart';

void main() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/users');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body);

    List<User> users = jsonData.map((json) => User.fromJson(json)).toList();

    users.forEach((user) {
      print('ID: ${user.id}');
      print('Name: ${user.name}');
      print('Username: ${user.username}');
      print('Email: ${user.email}');
      print(
          'Address: street: ${user.address.street}, suite: ${user.address.suite}, city: ${user.address.city}, zipcode: ${user.address.zipcode}');
      print(
          'Geo: lat = ${user.address.geo.lat}, lng = ${user.address.geo.lng}');
      print('Phone: ${user.phone}');
      print('Website: ${user.website}');
      print(
          'Company: ${user.company.name}, CatchPhrase: ${user.company.catchPhrase}, bs: ${user.company.bs}');
      print('--------------------------------------------------------');
    });

    print('Usuarios con nombre de usuario con más de 6 caracteres:');
    filtrarUsuariosConUsernameLargo(users)
        .forEach((user) => print(user.username));

    int cantidadBizEmails = contarUsuariosConBizEmail(users);
    print(
        '\nCantidad de usuarios con email del dominio "biz": $cantidadBizEmails');
  } else {
    print('Error al obtener los datos: ${response.statusCode}');
  }
}

// Función para filtrar usuarios cuyo username contiene más de 6 caracteres
List<User> filtrarUsuariosConUsernameLargo(List<User> users) {
  return users.where((user) => user.username.length > 6).toList();
}

// Función para contar usuarios cuyo email pertenece al dominio 'biz'
int contarUsuariosConBizEmail(List<User> users) {
  return users.where((user) => user.email.endsWith('.biz')).length;
}
