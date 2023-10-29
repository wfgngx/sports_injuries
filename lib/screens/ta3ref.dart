import 'package:flutter/material.dart';

class Ta3reef extends StatelessWidget {
  const Ta3reef({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            'أعراض الكدمه',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Divider(
            color: Colors.blue,
            indent: 30,
            endIndent: 30,
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
              padding: EdgeInsets.all(12),
              child: Center(
                child: Text(
                  'الكدم هو عبارة عن "هرس أنسجة عضو عن طريق قوة خارجية عنيفة مباشرة كالضرب مباشرة أو الاصطدام بجسم صلب" وغالبًا ما يصاحب الكدم ألم وورم ونزيف داخلي وارتشاح لسائل بلازما الدم مكان الإصابة وتغيير في لون الجلد إلى الزرقة الداكنة أو الزرقة المشوبة باحمرار.',
                  style: TextStyle(fontSize: 22),
                ),
              ))
        ],
      ),
    );
  }
}
