import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'fetch_sporst_injuries_data.dart';

class KindOfBurises extends StatelessWidget {
  const KindOfBurises({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          const Text(
            'أنواع الإصابات الرياضيه',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
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
                          padding: const EdgeInsets.all(12),
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
