import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:sportsInjuries/widgets/videos/dislocation/dislocation_def.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../const.dart';

class FractureDef extends StatefulWidget {
  const FractureDef({Key? key}) : super(key: key);

  @override
  State<FractureDef> createState() => _FractureDefState();
}

class _FractureDefState extends State<FractureDef> {
  List<dynamic>? fractureShapes;
  List<dynamic>? fractureDef;

  Future<List<dynamic>> fractureDefFun() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['fracture'];
      return def['def'];
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> fractureShapesFun() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['fracture'];
      return def['shapes'];
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fractureDefFun().then((data) {
      setState(() {
        fractureDef = data;
      });
    }).catchError((error) {
      print('Error: $error');
    });
    fractureShapesFun().then((data) {
      setState(() {
        fractureShapes = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "التعريف",
          style: TextStyle(fontSize: 24.sp),
        ),
      ),
      body: fractureShapes != null && fractureDef != null
          ? SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInImage(
                    width: double.infinity,
                    height: 200.h,
                    fit: BoxFit.contain,
                    placeholder: MemoryImage(kTransparentImage),
                    image: const AssetImage('assets/images/kasr_xray.jpeg')),
                SizedBox(
                    height: 250.h,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: fractureDef!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              fractureDef?[index],
                              style: TextStyle(
                                  color: Colors.white, fontSize: 22.sp),
                            ));
                      },
                    )),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    "أشكال الكسر",
                    style: TextStyle(color: Colors.blue, fontSize: 18.sp),
                  ),
                ),
                FadeInImage(
                    width: double.infinity,
                    height: 200.h,
                    fit: BoxFit.contain,
                    placeholder: MemoryImage(kTransparentImage),
                    image: const AssetImage('assets/images/shapes_fraction.jpg')),
                SizedBox(
                    height: 450.h,
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: fractureShapes!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              "- ${fractureShapes![index]}",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.sp),
                            ));
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider();
                      },
                    )),
                DislocationDefVid(vidUrl: "assets/videos/fraction.mp4"),
              ],
            ))
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
