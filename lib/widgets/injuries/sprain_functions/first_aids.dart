import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import '../../../const.dart';

class SprainFirstAid extends StatefulWidget {
  const SprainFirstAid({Key? key}) : super(key: key);

  @override
  State<SprainFirstAid> createState() => _BruiseDefState();
}

class _BruiseDefState extends State<SprainFirstAid> {
  List<dynamic>? bruiseDef;
  Future<List<dynamic>> fetchSportsInjuries() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['bruise'];
      return def['firstAid'];
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
        title: Text("الإسعافات الأوليه"),
        centerTitle: true,
      ),
      body: bruiseDef != null
          ? ListView.separated(
        itemCount: bruiseDef!.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                "- ${bruiseDef![index]}",
                style: TextStyle(color: Colors.white, fontSize: 18.sp),
              ));
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            indent: 30.w,
            endIndent: 30.w,
          );
        },
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
