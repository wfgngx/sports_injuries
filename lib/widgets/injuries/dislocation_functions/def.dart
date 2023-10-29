import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';

import '../../../const.dart';
import '../../videos/dislocation/dislocation_def.dart';

class DislocationDef extends StatefulWidget {
  const DislocationDef({Key? key}) : super(key: key);

  @override
  State<DislocationDef> createState() => _DislocationDefState();
}

class _DislocationDefState extends State<DislocationDef> {
  List<dynamic>? dislocationDef;
  List<dynamic>? dislocationkind;
  List<dynamic>? theMostDislocation;
  List<dynamic>? shoulderDislocation;
  List<dynamic>? shoulderDislocationKind;

  Future<List<dynamic>> shoulderDislocationKindFun() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['dislocation'];
      return def['shoulder_dislocation_kind'];
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> shoulderDislocationFun() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['dislocation'];
      return def['shoulder_dislocation'];
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> mostDislocationFun() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['dislocation'];
      return def['the_most'];
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> dislocationKindFun() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['dislocation'];
      return def['dislocation_kind'];
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> dislocationDefFun() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['dislocation'];
      return def['def'];
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    shoulderDislocationKindFun().then((data) {
      setState(() {
        shoulderDislocationKind = data;
      });
    }).catchError((error) {
      print('Error: $error');
    });

    dislocationDefFun().then((data) {
      setState(() {
        dislocationDef = data;
      });
    }).catchError((error) {
      print('Error: $error');
    });
    dislocationKindFun().then((data) {
      setState(() {
        dislocationkind = data;
      });
    }).catchError((error) {
      print('Error: $error');
    });
    mostDislocationFun().then((data) {
      setState(() {
        theMostDislocation = data;
      });
    }).catchError((error) {
      print('Error: $error');
    });
    shoulderDislocationFun().then((data) {
      setState(() {
        shoulderDislocation = data;
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
          "التعريف",
        ),
      ),
      body: dislocationDef != null && dislocationkind != null
          ? SingleChildScrollView(
              child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                children: [
                  FadeInImage(
                      width: double.infinity,
                      height: 200.h,
                      fit: BoxFit.contain,
                      placeholder: MemoryImage(kTransparentImage),
                      image: const AssetImage('assets/images/ketf_makhlo3.jpg')),
                  SizedBox(
                      height: 150.h,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: dislocationDef!.length,
                        itemBuilder: (context, index) {
                          return Text(
                            dislocationDef![index],
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.sp),
                          );
                        },
                      )),
                  const Divider(),
                  Text(
                    "أنواع الخلع",
                    style: TextStyle(color: Colors.blue, fontSize: 18.sp),
                  ),
                  SizedBox(
                    height: 100.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: dislocationkind!.length,
                      itemBuilder: (context, index) {
                        return Text(
                          "- ${dislocationkind![index]}",
                          style: TextStyle(fontSize: 16.sp),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  Text(
                    "أكثرهم شهره",
                    style: TextStyle(color: Colors.blue, fontSize: 18.sp),
                  ),
                  SizedBox(
                    height: 75.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: theMostDislocation!.length,
                      itemBuilder: (context, index) {
                        return Text(
                          "- ${theMostDislocation![index]}",
                          style: TextStyle(fontSize: 16.sp),
                        );
                      },
                    ),
                  ),
                  Divider(),
                  Text(
                    "مفصل الكتف",
                    style: TextStyle(color: Colors.blue, fontSize: 18.sp),
                  ),
                  SizedBox(
                    height: 70.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: shoulderDislocation!.length,
                      itemBuilder: (context, index) {
                        return Text(
                          "- ${shoulderDislocation![index]}",
                          style: TextStyle(fontSize: 16.sp),
                        );
                      },
                    ),
                  ),
                  Divider(),
                  Text(
                    "مفصل الكتف",
                    style: TextStyle(color: Colors.blue, fontSize: 18.sp),
                  ),
                  SizedBox(
                    height: 90.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: shoulderDislocationKind!.length,
                      itemBuilder: (context, index) {
                        return Text(
                          "- ${shoulderDislocationKind![index]}",
                          style: TextStyle(fontSize: 16.sp),
                        );
                      },
                    ),
                  ),
                  const DislocationDefVid(vidUrl:"assets/videos/shoulder_dislocation_def.mp4",),

                ],
              ),
            ))
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
