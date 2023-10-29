import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';

import '../../../const.dart';
import '../../videos/dislocation/dislocation_def.dart';

class ShoulderDislocationSymptoms extends StatefulWidget {
  const ShoulderDislocationSymptoms({Key? key}) : super(key: key);

  @override
  State<ShoulderDislocationSymptoms> createState() =>
      _ShoulderDislocationSymptomsState();
}

class _ShoulderDislocationSymptomsState
    extends State<ShoulderDislocationSymptoms> {
  List<dynamic>? frontDislocationSymptoms;
  List<dynamic>? backDislocationSymptoms;
  List<dynamic>? underDislocationSymptoms;
  Future<List<dynamic>> underDislocationSymptomsFun() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['dislocation'];
      return def['under_dislocation']['Symptoms'];
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> frontDislocationSymptomsFun() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['dislocation'];
      return def['front_dislocation']['Symptoms'];
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> backDislocationSymptomsFun() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['dislocation'];
      return def['back_dislocation']['Symptoms'];
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    frontDislocationSymptomsFun().then((data) {
      setState(() {
        frontDislocationSymptoms = data;
      });
    }).catchError((error) {
      print('Error: $error');
    });
    backDislocationSymptomsFun().then((data) {
      setState(() {
        backDislocationSymptoms = data;
      });
    }).catchError((error) {
      print('Error: $error');
    });
    underDislocationSymptomsFun().then((data) {
      setState(() {
        underDislocationSymptoms = data;
      });
    }).catchError((error) {
      print('Error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "الأعراض",
        ),
      ),
      body: frontDislocationSymptoms != null &&
              backDislocationSymptoms != null &&
              underDislocationSymptoms != null
          ? SingleChildScrollView(
              child: Padding(padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),child: Column(
                children: [
                  FadeInImage(
                      width: double.infinity,
                      height: 210.h,
                      fit: BoxFit.contain,
                      placeholder: MemoryImage(kTransparentImage),
                      image: const AssetImage('assets/images/ketf_makhlo32.jpg')),
                  Text("أعراض خلع الكتف الأمامي",
                      style: TextStyle(color: Colors.blue, fontSize: 18.sp)),
                  SizedBox(
                      height: 260.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: frontDislocationSymptoms!.length,
                        itemBuilder: (context, index) {
                          return Text(
                            "- ${frontDislocationSymptoms![index]}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.sp),
                          );
                        },
                      )),
                  const Divider(),
                  Text(
                    "أعراض خلع الكتف الخلفي",
                    style: TextStyle(color: Colors.blue, fontSize: 18.sp),
                  ),
                  SizedBox(
                    height: 80.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: backDislocationSymptoms!.length,
                      itemBuilder: (context, index) {
                        return Text(
                          "- ${backDislocationSymptoms![index]}",
                          style: TextStyle(fontSize: 16.sp),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  Text(
                    "أعراض خلع الكتف السفلي",
                    style: TextStyle(color: Colors.blue, fontSize: 18.sp),
                  ),
                  SizedBox(
                    height: 60.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: underDislocationSymptoms!.length,
                      itemBuilder: (context, index) {
                        return Text(
                          "- ${underDislocationSymptoms![index]}",
                          style: TextStyle(fontSize: 16.sp),
                        );
                      },
                    ),
                  ),
                  DislocationDefVid(vidUrl: "assets/videos/shoulder_dislocation_real_vid.mp4",),

                ],
              ),
            ))
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
