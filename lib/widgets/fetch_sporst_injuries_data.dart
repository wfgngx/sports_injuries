import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import '../const.dart';
import '../screens/details.dart';
import '../screens/injury_screen_head_lines.dart';

class KindOfEsabat extends StatefulWidget {
  KindOfEsabat({Key? key, required this.indexOFInjury}) : super(key: key);
  final int indexOFInjury;

  @override
  State<KindOfEsabat> createState() => _KindOfEsabatState();
}

class _KindOfEsabatState extends State<KindOfEsabat> {
  List<dynamic>? injuriesData;
  Future<List<dynamic>?> fetchSportsInjuries() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print(data);
      injuriesData = data[databaseKey]['SportsInjuries'];
      return injuriesData;
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
        injuriesData = data;
      });
    }).catchError((error) {
      print('Error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return injuriesData != null
        ? InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const Details();
                },
              ));
            },
            child: SizedBox(
                height: 40,
                width: double.infinity,
                child: InkWell(
                    onTap: () {
                      if (widget.indexOFInjury == 0) {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return InjuryScreenHeadLines(kind: "الكدمات");
                          },
                        ));
                      } else if (widget.indexOFInjury == 1) {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return InjuryScreenHeadLines(kind: "الكسور");
                          },
                        ));
                      } else if (widget.indexOFInjury == 2) {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return InjuryScreenHeadLines(kind: "الإلتواء");
                          },
                        ));
                      } else if (widget.indexOFInjury == 3) {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return InjuryScreenHeadLines(kind: "الخلع");
                          },
                        ));
                      } else if (widget.indexOFInjury == 4) {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return InjuryScreenHeadLines(kind: "التقلص العضلي");
                          },
                        ));
                      } else if (widget.indexOFInjury == 5) {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return InjuryScreenHeadLines(kind: "التمزق العضلي");
                          },
                        ));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.blueAccent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: Text(
                            injuriesData![widget.indexOFInjury].toString(),
                            style:  TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ))
                        ],
                      ),
                    ))))
        : const CircularProgressIndicator();
  }
}
