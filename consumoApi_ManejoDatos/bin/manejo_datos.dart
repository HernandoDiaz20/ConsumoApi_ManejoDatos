import 'dart:convert';
import 'package:http/http.dart' as http;
import '../lib/user.dart';

void main() async {
  // URL de la API
  final url = Uri.parse('https://jsonplaceholder.typicode.com/users');

  // Realizar la petición GET
  final response = await http.get(url);

  // Verificar si la petición fue exitosa
  if (response.statusCode == 200) {
    // Parsear la respuesta JSON a una lista
    List<dynamic> jsonData = json.decode(response.body);

    // Crear una lista de User
    List<User> users = jsonData.map((json) => User.fromJson(json)).toList();

    // Mostrar los datos de los usuarios
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

    // Mostrar los resultados de las operaciones adicionales
    print('Usuarios con nombre de usuario con más de 6 caracteres:');
    filtrarUsuariosConUsernameLargo(users)
        .forEach((user) => print(user.username));

    int cantidadBizEmails = contarUsuariosConBizEmail(users);
    print(
        '\nCantidad de usuarios con email del dominio "biz": $cantidadBizEmails');
  } else {
    // Manejo de errores
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
