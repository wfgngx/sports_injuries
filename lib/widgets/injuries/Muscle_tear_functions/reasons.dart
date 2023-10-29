import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:sportsInjuries/const.dart';

class MuscleReasons extends StatefulWidget {
  const MuscleReasons({Key? key}) : super(key: key);

  @override
  State<MuscleReasons> createState() => _BruiseDefState();
}

class _BruiseDefState extends State<MuscleReasons> {
  List<dynamic>? muscleReasons;

  Future<List<dynamic>> sprainReasonsFun() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['Muscle tear'];
      return def['reasons'];
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  // Future<List<dynamic>> sprainDangersFun() async {
  //   final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
  //       'BruisesInfo.json');
  //   final response = await http.get(url);
  //
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     print(data);
  //     final def = data['-Nhq3bkbIXlHqdkqK69x']['sprain'];
  //     return def['3wamel_elkhatar'];
  //   } else {
  //     throw Exception(
  //         'Failed to load data. Status code: ${response.statusCode}');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    sprainReasonsFun().then((data) {
      setState(() {
        muscleReasons = data;
      });
    }).catchError((error) {
      print('Error: $error');
    });
    // sprainDangersFun().then((data) {
    //   setState(() {
    //     sprainDanger = data;
    //   });
    // }).catchError((error) {
    //   print('Error: $error');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الأسباب"),
        centerTitle: true,
      ),
      body: muscleReasons != null
          ? SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الأسباب :-',
                        style: TextStyle(color: Colors.blue, fontSize: 22.sp),
                      ),
                      SizedBox(
                        height: 300.h,
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: muscleReasons!.length,
                          itemBuilder: (context, index) {
                            return Text(
                              "- ${muscleReasons![index]}",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.sp),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              indent: 30.w,
                              endIndent: 30.w,
                            );
                          },
                        ),
                      ),
                      // const Divider(),
                      // Text(
                      //   "عوامل الخطر :-",
                      //   style: TextStyle(color: Colors.blue, fontSize: 22.sp),
                      // ),
                      // SizedBox(
                      //     height: 300.h,
                      //     child: ListView.separated(
                      //       shrinkWrap: true,
                      //       physics: const NeverScrollableScrollPhysics(),
                      //       itemCount: sprainDanger!.length,
                      //       itemBuilder: (context, index) {
                      //         return Text(
                      //           "- ${sprainDanger![index]}",
                      //           style: TextStyle(
                      //               color: Colors.white, fontSize: 18.sp),
                      //         );
                      //       },
                      //       separatorBuilder:
                      //           (BuildContext context, int index) {
                      //         return Divider(
                      //           indent: 30.w,
                      //           endIndent: 30.w,
                      //         );
                      //       },
                      //     )),
                    ],
                  )))
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
