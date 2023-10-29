import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:sportsInjuries/const.dart';
import 'package:transparent_image/transparent_image.dart';

class MuscleFirstAid extends StatefulWidget {
  const MuscleFirstAid({Key? key}) : super(key: key);

  @override
  State<MuscleFirstAid> createState() => _BruiseDefState();
}

class _BruiseDefState extends State<MuscleFirstAid> {
  List<dynamic>? muscleFirstAid;
  Future<List<dynamic>> fetchSportsInjuries() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['Muscle tear'];
      return def['FirstAid'];
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
        muscleFirstAid = data;
      });
    }).catchError((error) {
      print('Error: $error');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الإسعافات الأوليه"),
        centerTitle: true,
      ),
      body: muscleFirstAid != null
          ? SingleChildScrollView(child: Column(children: [
        FadeInImage(
            width: double.infinity,
            height: 200.h,
            fit: BoxFit.contain,
            placeholder: MemoryImage(kTransparentImage),
            image:
            AssetImage('assets/images/muscle_tear_first_aid.jpg')),
        SizedBox(height: 500.h,child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: muscleFirstAid!.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  "- ${muscleFirstAid![index]}",
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ));
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              indent: 30.w,
              endIndent: 30.w,
            );
          },
        ),)
      ],),)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
