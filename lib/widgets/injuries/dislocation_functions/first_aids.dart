import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:sportsInjuries/widgets/videos/dislocation/dislocation_def.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../const.dart';

class ShoulderDislocationFirstAid extends StatefulWidget {
  const ShoulderDislocationFirstAid({Key? key}) : super(key: key);

  @override
  State<ShoulderDislocationFirstAid> createState() =>
      _ShoulderDislocationFirstAidState();
}

class _ShoulderDislocationFirstAidState
    extends State<ShoulderDislocationFirstAid> {
  List<dynamic>? frontDislocationFirstAid;
  List<dynamic>? backDislocationFirstAid;
  List<dynamic>? underDislocationFirstAid;
  Future<List<dynamic>> underDislocationFirstAidFun() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['dislocation'];
      return def['under_dislocation']['treatment'];
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> backDislocationFirstAidFun() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['dislocation'];
      return def['back_dislocation']['treatment'];
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    // frontDislocationFirstAidFun().then((data) {
    //   setState(() {
    //     frontDislocationFirstAid = data;
    //   });
    // }).catchError((error) {
    //   print('Error: $error');
    // });
    backDislocationFirstAidFun().then((data) {
      setState(() {
        backDislocationFirstAid = data;
      });
    }).catchError((error) {
      print('Error: $error');
    });
    underDislocationFirstAidFun().then((data) {
      setState(() {
        underDislocationFirstAid = data;
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
          "الإسعافات الأوليه",
          style: TextStyle(fontSize: 24.sp),
        ),
      ),
      body: backDislocationFirstAid != null && underDislocationFirstAid != null
          ? SingleChildScrollView(
              child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                children: [
                  FadeInImage(
                      width: double.infinity,
                      height: 210.h,
                      fit: BoxFit.contain,
                      placeholder: MemoryImage(kTransparentImage),
                      image: const AssetImage(
                          'assets/images/dislocation_treatment.jpg')),
                  Text(
                    "الإسعافات الأوليه للكتف الخلفي",
                    style: TextStyle(color: Colors.blue, fontSize: 18.sp),
                  ),
                  SizedBox(
                    height: 180.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: backDislocationFirstAid!.length,
                      itemBuilder: (context, index) {
                        return Text(
                          "- ${backDislocationFirstAid![index]}",
                          style: TextStyle(fontSize: 16.sp),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  Text(
                    "الإسعافات الأوليه للكتف السفلي",
                    style: TextStyle(color: Colors.blue, fontSize: 18.sp),
                  ),
                  SizedBox(
                    height: 50.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: underDislocationFirstAid!.length,
                      itemBuilder: (context, index) {
                        return Text("- ${underDislocationFirstAid![index]}");
                      },
                    ),
                  ),
                  DislocationDefVid(
                      vidUrl: "assets/videos/shoulder_dislocation.mp4"),
                ],
              ),
            ))
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
