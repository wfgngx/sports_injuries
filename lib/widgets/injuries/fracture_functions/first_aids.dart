import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';

import '../../../const.dart';

class FractureFirstAid extends StatefulWidget {
  const FractureFirstAid({Key? key}) : super(key: key);

  @override
  State<FractureFirstAid> createState() => _BruiseDefState();
}

class _BruiseDefState extends State<FractureFirstAid> {
  List<dynamic>? fractureTreatment;
  List<dynamic>? fractureFirstAid;

  Future<List<dynamic>> fractionTreatmentFunction() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['fracture'];
      return def['Treatment'];
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> fetchFirstAid() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['fracture'];
      return def['firstAid'];
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fractionTreatmentFunction().then((data) {
      setState(() {
        fractureTreatment = data;
      });
    }).catchError((error) {
      print('Error: $error');
    });
    fetchFirstAid().then((data) {
      setState(() {
        fractureFirstAid = data;
      });
    }).catchError((error) {
      print('Error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الإسعافات الأوليه والعلاج"),
        centerTitle: true,
      ),
      body: fractureTreatment != null && fractureFirstAid!=null
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
                          image: const AssetImage('assets/images/fraction_first_aid.jpg')),
                      Text(
                        'الإسعافات الأوليه :-',
                        style: TextStyle(color: Colors.blue, fontSize: 22.sp),
                      ),
                      SizedBox(
                        height: 400,
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: fractureTreatment!.length,
                          itemBuilder: (context, index) {
                            return Text(
                              "- ${fractureTreatment![index]}",
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
                        "العلاج :-",
                        style: TextStyle(color: Colors.blue, fontSize: 22.sp),
                      ),
                      SizedBox(
                          height: 400,
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: fractureFirstAid!.length,
                            itemBuilder: (context, index) {
                              return Text(
                                "- ${fractureFirstAid![index]}",
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
