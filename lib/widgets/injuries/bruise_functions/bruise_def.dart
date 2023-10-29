import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:sportsInjuries/widgets/videos/dislocation/dislocation_def.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../const.dart';

class BruiseDef extends StatefulWidget {
  const BruiseDef({Key? key}) : super(key: key);

  @override
  State<BruiseDef> createState() => _BruiseDefState();
}

class _BruiseDefState extends State<BruiseDef> {
  List<dynamic>? bruiseDef;
  Future<List<dynamic>> fetchSportsInjuries() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['bruise'];
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
          ? SingleChildScrollView(child: Column(
              children: [
                FadeInImage(
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.contain,
                    placeholder: MemoryImage(kTransparentImage),
                    image: AssetImage('assets/images/kadma.jpg')),
                SizedBox(
                  height: 250.h,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: bruiseDef!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          bruiseDef![index],
                          style:
                              TextStyle(color: Colors.white, fontSize: 22.sp),
                        ));
                  },
                )),
                DislocationDefVid(vidUrl: "assets/videos/def_bruise_vid.mp4")
              ],
            ))
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
