
import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
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
   var pageCount = 1;

  var limitVal;

  var indexVal = 0;

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
            var totalData = excerdata.length ;
            // List<Excercise> newList;


            print('totalData');
            print(totalData);
            if(totalData % 10 == 0) {
              limitVal = totalData.toInt() /10;
            } else {
              limitVal = totalData.toInt() /10 + 1;
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      pageCount != 1
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              pageCount = pageCount - 1;
                              indexVal = indexVal - 10;
                            });
                          },
                          child: Icon(Icons.keyboard_arrow_left)) : Container(),
                      pageCount != limitVal
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              pageCount = pageCount + 1;
                              indexVal = indexVal + 10;
                            });
                          },
                          child: Icon(Icons.navigate_next)) : Container(),
                    ],
                  ),
                ),
                Expanded(child: buildExcercise(excerdata, indexVal)),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          // By default, show a loading spinner.
          return Center(child: const CircularProgressIndicator(color: Colors.purple,));
        },
      )
    );
  }

  Widget buildExcercise(List<Excercise> excercise, int index) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, i) {
          print(index);
          index = pageCount == 1 ? i : index + i;
          final excerciseData = excercise[index];
          return
            InkWell(
              onTap: () {
                excerciseId = excerciseData.id;
                Get.to(ExcerciseDetailScreen());
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 8),
                child: Card(
                  color: index % 2 == 0 ? Colors.grey.shade100 : Colors.green.shade50,
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
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width / 1.4,
                                        child: Text('${excerciseData.name}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        )),
                                    Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width / 1.4,
                                        child: Text(
                                          '${excerciseData.equipment}',
                                          style: TextStyle(fontSize: 15,
                                              color: Colors.grey),)
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
}
