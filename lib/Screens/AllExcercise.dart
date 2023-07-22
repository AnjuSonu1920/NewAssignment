
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_assignment/Model/Exercise.dart';
import 'package:new_assignment/Service/apiProvider.dart';

import 'ExcerciseDetails.dart';

var excerciseId;
class AllExcerciseScreen extends StatefulWidget {
  const AllExcerciseScreen({super.key});

  @override
  State<AllExcerciseScreen> createState() => _AllExcerciseScreenState();
}
class _AllExcerciseScreenState extends State<AllExcerciseScreen> {
   Future<List<Excercise>> excerciseData = fetchExcercise();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercise Data"),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: FutureBuilder<List<Excercise>>(
        future: excerciseData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final excerdata = snapshot.data!;
            return buildExcercise(excerdata);
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          // By default, show a loading spinner.
          return Center(child: const CircularProgressIndicator(color: Colors.purple,));
        },
      )
    );
  }

  Widget buildExcercise(List<Excercise> excercise) =>
      ListView.builder(
          itemCount: excercise.length,
          itemBuilder: (context, index) {
            final excerciseData = excercise[index];
            return InkWell(
              onTap: () {
                excerciseId = excerciseData.id;
                Get.to(ExcerciseDetailScreen());
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 8),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: NetworkImage(excerciseData.gifUrl)
                                  )
                                ),
                            ),
                            SizedBox(width: 5,),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                        width: MediaQuery.of(context).size.width/1.4,
                                        child: Text('${excerciseData.name}',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                                        )),
                                    Container(
                                        width: MediaQuery.of(context).size.width/1.4,
                                        child: Text('${excerciseData.equipment}',
                                      style: TextStyle( fontSize: 15, color: Colors.grey),)
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
      );
}
