import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:transparent_image/transparent_image.dart';

import '../widgets/fetch_sporst_injuries_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("الإصابات الرياضيه"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.blue,
              ))
        ],
      ),
      body:   Column(
        children: [
          FadeInImage(
              width: double.infinity,
              height: 200.h,
              fit: BoxFit.contain,
              placeholder: MemoryImage(kTransparentImage),
              image: const AssetImage('assets/images/sports-injuries.jpg')),
           SizedBox(
            height: 12.h,
          ),
           Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                textAlign: TextAlign.start,
                '-فالإصابة هي اعاقة أو تلف سواء كان هذا التلف مصاحبا أو غير مصاحب بتهتك بلأنسجة نتيجة لأي تأثير خارجي او داخلي سواء كان هذا التأثير ( ميكانيكيا او عضويا ، أو كيميائيا ) وغالبا ما يكون التأثير الخارجي مفاجنا وشديدا ويسبب تعطيل في وظائف أنسجة وأعضاء الجسم.',
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
              )),
          Expanded(
              child: AnimationLimiter(
                  child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(seconds: 1),
                  child: FadeInAnimation(
                      child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: KindOfEsabat(
                            indexOFInjury: index,
                          ))));
            },
          )))
        ],
      ),
    );
  }
}
