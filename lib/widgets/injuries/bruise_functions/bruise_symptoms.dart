import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';

import '../../../const.dart';

class BruiseSymptoms extends StatefulWidget {
  const BruiseSymptoms({Key? key}) : super(key: key);

  @override
  State<BruiseSymptoms> createState() => _BruiseDefState();
}

class _BruiseDefState extends State<BruiseSymptoms> {
  List<dynamic>? bruiseDef;
  Future<List<dynamic>> fetchSportsInjuries() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      final def = data[databaseKey]['bruise'];
      return def['Symptoms'];
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    // postData();
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
        title: Text("أعراض الكدمه"),
        centerTitle: true,
      ),
      body: bruiseDef != null
          ? Column(
              children: [
                Row(
                  children: [
                    FadeInImage(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 200,
                        fit: BoxFit.contain,
                        placeholder: MemoryImage(kTransparentImage),
                        image: AssetImage("assets/images/kadma_symptoms.jpg")),
                    FadeInImage(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 200,
                        fit: BoxFit.contain,
                        placeholder: MemoryImage(kTransparentImage),
                        image:
                            AssetImage("assets/images/kadma_symptoms_two.jpg")),
                  ],
                ),
                Expanded(
                    child: ListView.separated(
                  itemCount: bruiseDef!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          "- ${bruiseDef![index]}",
                          style:
                              TextStyle(color: Colors.white, fontSize: 18.sp),
                        ));
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      indent: 30.w,
                      endIndent: 30.w,
                    );
                  },
                ))
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
