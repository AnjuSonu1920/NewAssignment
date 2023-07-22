import 'dart:convert';
import 'package:new_assignment/Model/Exercise.dart';
import 'package:http/http.dart' as http;

Future<List<Excercise>> fetchExcercise() async {
  final response = await http
      .get(Uri.parse('https://exercisedb.p.rapidapi.com/exercises'),
      headers: {
        'X-RapidAPI-Key': '8e949a58fdmsh243896dd9ca0d60p1a0adajsnb164f4836ebb'
      });

  if (response.statusCode == 200) {
    print(response.body);
    var data = jsonDecode(response.body);
    return data.map<Excercise>(Excercise.fromJson).toList();
  } else {
    throw Exception('Failed to load value');
  }
}


