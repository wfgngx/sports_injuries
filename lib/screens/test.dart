// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:new_project/firebase_data/write_data.dart';
// import 'package:http/http.dart' as http;
//
// class TestData extends StatefulWidget {
//   const TestData({Key? key}) : super(key: key);
//
//   @override
//   State<TestData> createState() => _TestDataState();
// }
//
// class _TestDataState extends State<TestData> {
//   //String symptoms = '';
//   List<dynamic> symptoms = [];
//
//   void postData() async {
//     final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
//         'BruisesInfo.json');
//
//     final response = await http.post(
//       url,
//       headers: {'Content-Type': 'application/json'},
//       body: json.encode({
//         'bruise': {
//           "def":
//               "الكدم هو عبارة عن هرس أنسجة عضو عن طريق قوة خارجية عنيفة مباشرة كالضرب مباشرة أو الاصطدام بجسم صلب وغالبًا ما يصاحب الكدم ألم وورم ونزيف داخلي وارتشاح لسائل بلازما الدم مكان الإصابة وتغيير في لون الجلد إلى الزرقة الداكنة أو الزرقة المشوبة باحمرار.",
//           "reasons":
//               "صدمه مباشره لسطح الجسم بجسم غير حاد او نتيجة العنف الخارجي من اللاعب او المنافس او السقوط على الارض ولا يتسبب عنها جرح في الجلد ،وقد ينتج عنها تجمع دموي، وتتوقف مقدره اللاعب على الاداء جزئيا او كليا حسب شده او درجه الإصابة.",
//           "Symptoms": [
//             ' ظهور ورم وانتفاخ نتيجة تجمع وتجلط الدم الجاري في هذه المنطقة .',
//             'ألم في منطقة الكدمة.',
//             'نزيف داخلي نتيجة تمزق الشعيرات الدموية قطع في استمرارية الجهاز الدوري',
//             'عدم القدرة على الحركة مؤقتا بالنسبة للكدمات البسيطة ، وفقد القدرة على الحركة كليا بالنسبة للكدمات الشديدة بسبب الضغط الواقع على الأعصاب الحسية والحركية.',
//             'تغير لون الأغشية والجلد الخارجي حيث تبدا الكدمة في البداية باللون الاحمر وتتغير للأزرق القاتم، ثم تتحول للبنفسجي، ثم الاخضر ثم تتحول الى الاصفر الشاحب حتى تمام الشفاء واختفاء اللون.وغالبا يتم الشفاء الكامل خلال اسبوع واسبوعين حسب شده الكدمة.'
//           ],
//           "firstAid": [
//             'الراحة في وضع ملائم',
//             'استخدام كمادات الثلج لمده( ١٠: ١٥ق )ايقاف النزيف داخلي ويقرر كل ساعتين خلال مرحله العلاج الاولي علي حسب درجه الإصابة.',
//             'رفع العضو المصاب لأعلي بدون ألم .',
//             ' ضغط على المفصل المصاب برباط ضاغط لتقليل نسبه الورم .'
//           ]
//         }
//       }),
//     );
//
//     if (response.statusCode == 200) {
//       print('Data posted successfully');
//     } else {
//       print('Failed to post data. Status code: ${response.statusCode}');
//     }
//   }
//
//   loadData() async {
//     final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
//         'BruisesInfo.json');
//     final response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       // final parsedData = json.decode(jsonData);
//       final bruiseData = data['-NhlugJGghyESAOEnaOC']['bruise'];
//       symptoms = bruiseData['Symptoms'];
//       print('objectis$symptoms');
//     } else {
//       print('Failed to load data. Status code: ${response.statusCode}');
//     }
//     ;
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     postData();
//     load();
//   }
//
//   load() async {
//     await loadData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       children: [
//         SizedBox(
//             height: 500,
//             child: ListView.builder(
//               itemCount: symptoms.length,
//               itemBuilder: (context, index) {
//                 return Text(
//                   symptoms[index],
//                   style: const TextStyle(color: Colors.white),
//                 );
//               },
//             )),
//       ],
//     ));
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TestData extends StatefulWidget {
  const TestData({Key? key}) : super(key: key);

  @override
  State<TestData> createState() => _TestDataState();
}

class _TestDataState extends State<TestData> {
  List<dynamic>? symptoms;

  Future<List<dynamic>> fetchData() async {
    final url = Uri.https('physical-therapy-47a0e-default-rtdb.firebaseio.com',
        'BruisesInfo.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
       print(data);
      final bruiseData = data['-NhmdFGKeAKnF_DJz_uu']['bruise'];
      return bruiseData['Symptoms'];
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData().then((data) {
      setState(() {
        symptoms = data;
      });
    }).catchError((error) {
      print('Error: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 500,
            child:
            symptoms != null
                ? ListView.builder(
                    itemCount: symptoms!.length,
                    itemBuilder: (context, index) {
                      return Text(
                        symptoms![index],
                        style: const TextStyle(color: Colors.white),
                      );
                    },
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }
}
