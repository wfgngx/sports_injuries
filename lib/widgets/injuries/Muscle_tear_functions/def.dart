import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:sportsInjuries/const.dart';
import 'package:transparent_image/transparent_image.dart';

class MuscleDef extends StatefulWidget {
  const MuscleDef({Key? key}) : super(key: key);

  @override
  State<MuscleDef> createState() => _MuscleDefState();
}

class _MuscleDefState extends State<MuscleDef> {
  List<dynamic>? muscleDef;
  List<dynamic>? muscleLevels;

  Future<List<dynamic>> MuscleDefFun() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['Muscle tear'];
      return def['def'];
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> MuscleTreatFun() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['Muscle tear'];
      return def['Muscle tear levels'];
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    MuscleDefFun().then((data) {
      setState(() {
        muscleDef = data;
      });
    }).catchError((error) {
      print('Error: $error');
    });
    MuscleTreatFun().then((data) {
      setState(() {
        muscleLevels = data;
      });
    }).catchError((error) {
      print('Error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: muscleDef != null && muscleLevels != null
          ? SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInImage(
                          width: double.infinity,
                          height: 200.h,
                          fit: BoxFit.contain,
                          placeholder: MemoryImage(kTransparentImage),
                          image: const AssetImage('assets/images/tamazoq_3daly.jpg')),
                      SizedBox(
                        height: 140.h,
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: muscleDef!.length,
                          itemBuilder: (context, index) {
                            return Text(
                              "- ${muscleDef![index]}",
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
                      const Divider(),
                      Text(
                        "مستويات التمزق العضلي :-",
                        style: TextStyle(color: Colors.blue, fontSize: 22.sp),
                      ),
                      SizedBox(
                          height: 300.h,
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: muscleLevels!.length,
                            itemBuilder: (context, index) {
                              return Text(
                                "- ${muscleLevels![index]}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18.sp),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(
                                indent: 30.w,
                                endIndent: 30.w,
                              );
                            },
                          )),
                    ],
                  )))
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
//
