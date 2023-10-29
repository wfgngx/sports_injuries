import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:sportsInjuries/widgets/videos/dislocation/dislocation_def.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../const.dart';

class MuscleContractionDef extends StatefulWidget {
  const MuscleContractionDef({Key? key}) : super(key: key);

  @override
  State<MuscleContractionDef> createState() => _MuscleContractionDefState();
}

class _MuscleContractionDefState extends State<MuscleContractionDef> {
  List<dynamic>? bruiseDef;
  Future<List<dynamic>> fetchSportsInjuries() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['muscle contraction'];
      return def['def'];
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSportsInjuries().then((data) {
      setState(() {
        bruiseDef = data;
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
          "التعريف",
          style: TextStyle(fontSize: 24.sp),
        ),
      ),
      body: bruiseDef != null
          ? SingleChildScrollView(
              child: Column(
              children: [
                FadeInImage(
                    width: double.infinity,
                    height: 200.h,
                    fit: BoxFit.contain,
                    placeholder: MemoryImage(kTransparentImage),
                    image:
                        AssetImage('assets/images/muscle_contraction_def.jpg')),
                SizedBox(
                  height: 200.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bruiseDef!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(4),
                          child: Text(
                            bruiseDef![index],
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.sp),
                          ));
                    },
                  ),
                ),
                DislocationDefVid(vidUrl: "assets/videos/muscle_contraction_first_vid.mp4")
              ],
            ))
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
