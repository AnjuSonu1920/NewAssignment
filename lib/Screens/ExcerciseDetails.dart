import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_assignment/Model/Exercise.dart';
import 'package:http/http.dart' as http;
import 'package:new_assignment/Screens/AllExcercise.dart';

class ExcerciseDetailScreen extends StatefulWidget {
  ExcerciseDetailScreen({super.key});

  @override
  State<ExcerciseDetailScreen> createState() => _ExcerciseScreenState();
}

Future<ExcerciseDetail> fetchExcerciseDetail() async {
  final response = await http
      .get(Uri.parse('https://exercisedb.p.rapidapi.com/exercises/exercise/$excerciseId'),
      headers: {
        'X-RapidAPI-Key': '8e949a58fdmsh243896dd9ca0d60p1a0adajsnb164f4836ebb'
      });

  if (response.statusCode == 200) {
    print(response.body);
    return ExcerciseDetail.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load value');
  }
}

class _ExcerciseScreenState extends State<ExcerciseDetailScreen> {

  late Future<ExcerciseDetail> future;

  @override
  void initState() {
    super.initState();
    future = fetchExcerciseDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: FutureBuilder<ExcerciseDetail>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var value = snapshot.data;
            return Card(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Text('${value!.id}',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage(value!.gifUrl)
                          )
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text('${value.name}',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    SizedBox(height: 5,),
                    Text('${value.equipment}',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 5,),
                    Text('${value.bodyPart}',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 5,),
                    Text('${value.target}',
                      style: TextStyle(fontSize: 15),
                    )
                  ],
            ),
              ),);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          // By default, show a loading spinner.
          return Center(child: const CircularProgressIndicator(color: Colors.purple,));
        },
      ),
    );
  }
}