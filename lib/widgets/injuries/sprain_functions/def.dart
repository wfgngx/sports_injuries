import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import '../../../const.dart';
import '../../videos/dislocation/dislocation_def.dart';

class SprainDef extends StatefulWidget {
  const SprainDef({Key? key}) : super(key: key);

  @override
  State<SprainDef> createState() => _SprainDefState();
}

class _SprainDefState extends State<SprainDef> {
  List<dynamic>? sprainDef;
  List<dynamic>? sprainAvoid;

  Future<List<dynamic>> sprainDefFun() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['sprain'];
      return def['def'];
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> sprainAvoidFun() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['sprain'];
      return def['elweqaya'];
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    sprainDefFun().then((data) {
      setState(() {
        sprainDef = data;
      });
    }).catchError((error) {
      print('Error: $error');
    });
    sprainAvoidFun().then((data) {
      setState(() {
        sprainAvoid = data;
      });
    }).catchError((error) {
      print('Error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("التعريف والوقايه"),
        centerTitle: true,
      ),
      body: sprainDef != null 
          ? SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DislocationDefVid(vidUrl: "assets/videos/sprain.mp4",),
                      SizedBox(
                        height: 300.h,
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: sprainDef!.length,
                          itemBuilder: (context, index) {
                            return Text(
                              "- ${sprainDef![index]}",
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
                        "الوقايه :-",
                        style: TextStyle(color: Colors.blue, fontSize: 22.sp),
                      ),
                      SizedBox(
                          height: 300.h,
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: sprainAvoid!.length,
                            itemBuilder: (context, index) {
                              return Text(
                                "- ${sprainAvoid![index]}",
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
