import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import '../../../const.dart';

class ShoulderDislocationReasons extends StatefulWidget {
  const ShoulderDislocationReasons({Key? key}) : super(key: key);

  @override
  State<ShoulderDislocationReasons> createState() =>
      _ShoulderDislocationReasonsState();
}

class _ShoulderDislocationReasonsState
    extends State<ShoulderDislocationReasons> {
  List<dynamic>? frontDislocationReasons;
  List<dynamic>? backDislocationReasons;
  List<dynamic>? underDislocationReasons;
  Future<List<dynamic>> underDislocationReasonsFun() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['dislocation'];
      return def['under_dislocation']['reasons'];
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> frontDislocationReasonsFun() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['dislocation'];
      return def['front_dislocation']['reasons'];
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> backDislocationReasonsFun() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['dislocation'];
      return def['back_dislocation']['reasons'];
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    frontDislocationReasonsFun().then((data) {
      setState(() {
        frontDislocationReasons = data;
      });
    }).catchError((error) {
      print('Error: $error');
    });
    backDislocationReasonsFun().then((data) {
      setState(() {
        backDislocationReasons = data;
      });
    }).catchError((error) {
      print('Error: $error');
    });
    underDislocationReasonsFun().then((data) {
      setState(() {
        underDislocationReasons = data;
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
        title: Text(
          "الأسباب",
        ),
      ),
      body: frontDislocationReasons != null &&
              backDislocationReasons != null &&
              underDislocationReasons != null
          ? SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                child: Column(
                  children: [
                    Text(
                      "اسباب حدوث خلع للكتف الأمامي",
                      style: TextStyle(color: Colors.blue, fontSize: 18.sp),
                    ),
                    SizedBox(
                        height: 120.h,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: frontDislocationReasons!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: EdgeInsets.symmetric(vertical: 6.h),
                                child: Text(
                                  "- ${frontDislocationReasons![index]}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16.sp),
                                ));
                          },
                        )),
                    const Divider(),
                    Text(
                      "اسباب حدوث خلع للكتف الخلفي",
                      style: TextStyle(color: Colors.blue, fontSize: 18.sp),
                    ),
                    SizedBox(
                      height: 120.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: backDislocationReasons!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Text(
                                "- ${backDislocationReasons![index]}",
                                style: TextStyle(fontSize: 16.sp),
                              ));
                        },
                      ),
                    ),
                    const Divider(),
                    Text(
                      "اسباب حدوث خلع للكتف السفلي",
                      style: TextStyle(color: Colors.blue, fontSize: 18.sp),
                    ),
                    SizedBox(
                      height: 50.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: underDislocationReasons!.length,
                        itemBuilder: (context, index) {
                          return Text(
                            "- ${underDislocationReasons![index]}",
                            style: TextStyle(fontSize: 16.sp),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
