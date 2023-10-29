import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:sportsInjuries/const.dart';

class MuscleSymptoms extends StatefulWidget {
  const MuscleSymptoms({Key? key}) : super(key: key);

  @override
  State<MuscleSymptoms> createState() => _BruiseDefState();
}

class _BruiseDefState extends State<MuscleSymptoms> {
  List<dynamic>? muscleSymptoms;
  List<dynamic>? muscleTreatment;
  Future<List<dynamic>> fetchMuscleTreatment() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['Muscle tear'];
      return def['Symptoms'];
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> fetchMuscleSymptoms() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['Muscle tear'];
      return def['Symptoms'];
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    // postData();
    fetchMuscleTreatment().then((data) {
      setState(() {
        muscleTreatment = data;
      });
    }).catchError((error) {
      print('Error: $error');
    });
    fetchMuscleSymptoms().then((data) {
      setState(() {
        muscleSymptoms = data;
      });
    }).catchError((error) {
      print('Error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الأعراض"),
        centerTitle: true,
      ),
      body: muscleSymptoms != null
          ? ListView.separated(
              itemCount: muscleSymptoms!.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "- ${muscleSymptoms![index]}",
                      style: TextStyle(color: Colors.white, fontSize: 18.sp),
                    ));
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  indent: 30.w,
                  endIndent: 30.w,
                );
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
