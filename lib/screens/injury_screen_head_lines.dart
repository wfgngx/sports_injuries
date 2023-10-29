import 'package:flutter/material.dart';
import 'package:sportsInjuries/widgets/injuries/Muscle_tear_functions/def.dart';
import 'package:sportsInjuries/widgets/injuries/Muscle_tear_functions/first_aids.dart';
import 'package:sportsInjuries/widgets/injuries/Muscle_tear_functions/reasons.dart';
import 'package:sportsInjuries/widgets/injuries/Muscle_tear_functions/symptoms.dart';
import 'package:transparent_image/transparent_image.dart';
import '../widgets/injuries/bruise_functions/bruise_def.dart';
import '../widgets/injuries/bruise_functions/bruise_first_aid.dart';
import '../widgets/injuries/bruise_functions/bruise_reasons.dart';
import '../widgets/injuries/bruise_functions/bruise_symptoms.dart';
import '../widgets/injuries/dislocation_functions/def.dart';
import '../widgets/injuries/dislocation_functions/first_aids.dart';
import '../widgets/injuries/dislocation_functions/reasons.dart';
import '../widgets/injuries/dislocation_functions/symptoms.dart';
import '../widgets/injuries/fracture_functions/def.dart';
import '../widgets/injuries/fracture_functions/first_aids.dart';
import '../widgets/injuries/fracture_functions/reasons.dart';
import '../widgets/injuries/fracture_functions/symptoms.dart';
import '../widgets/injuries/muscle_contraction_functions/def.dart';
import '../widgets/injuries/muscle_contraction_functions/first_aids.dart';
import '../widgets/injuries/muscle_contraction_functions/reasons.dart';
import '../widgets/injuries/muscle_contraction_functions/symptoms.dart';
import '../widgets/injuries/sprain_functions/def.dart';
import '../widgets/injuries/sprain_functions/first_aids.dart';
import '../widgets/injuries/sprain_functions/reasons.dart';
import '../widgets/injuries/sprain_functions/symptoms.dart';

class InjuryScreenHeadLines extends StatelessWidget {
  InjuryScreenHeadLines({Key? key, required this.kind}) : super(key: key);
  final String kind;
  late String imgUrl;
  List<String> injuryHeadLines = [
    "التعريف",
    "الأعراض",
    "السبب",
    "الإسعافات الأوليه"
  ];

  void navigateToPage(BuildContext context, String headline) {
    if (headline == "التعريف" && kind == "الكدمات") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BruiseDef()),
      );
    } else if (headline == "الأعراض" && kind == "الكدمات") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BruiseSymptoms()),
      );
    } else if (headline == "السبب" && kind == "الكدمات") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BruiseReasons()),
      );
    } else if (headline == "الإسعافات الأوليه" && kind == "الكدمات") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BruiseFirstAid()),
      );
    } else if (headline == "التعريف" && kind == "الكسور") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => (FractureDef())),
      );
    } else if (headline == "الأعراض" && kind == "الكسور") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FractureSymptoms()),
      );
    } else if (headline == "السبب" && kind == "الكسور") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FractureReasons()),
      );
    } else if (headline == "الإسعافات الأوليه" && kind == "الكسور") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FractureFirstAid()),
      );
    } else if (headline == "التعريف" && kind == "الإلتواء") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SprainDef()),
      );
    } else if (headline == "الأعراض" && kind == "الإلتواء") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SprainSymptoms()),
      );
    } else if (headline == "السبب" && kind == "الإلتواء") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SprainReasons()),
      );
    } else if (headline == "الإسعافات الأوليه" && kind == "الإلتواء") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SprainFirstAid()),
      );
    } else if (headline == "التعريف" && kind == "الخلع") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DislocationDef()),
      );
    } else if (headline == "الأعراض" && kind == "الخلع") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ShoulderDislocationSymptoms()),
      );
    } else if (headline == "السبب" && kind == "الخلع") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ShoulderDislocationReasons()),
      );
    } else if (headline == "الإسعافات الأوليه" && kind == "الخلع") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ShoulderDislocationFirstAid()),
      );
    } else if (headline == "التعريف" && kind == "التقلص العضلي") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MuscleContractionDef()),
      );
    } else if (headline == "الأعراض" && kind == "التقلص العضلي") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MuscleContractionSymptoms()),
      );
    } else if (headline == "السبب" && kind == "التقلص العضلي") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MuscleContractionReasons()),
      );
    } else if (headline == "الإسعافات الأوليه" && kind == "التقلص العضلي") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MuscleContractionFirstAid()),
      );
    } else if (headline == "التعريف" && kind == "التمزق العضلي") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MuscleDef()),
      );
    } else if (headline == "الأعراض" && kind == "التمزق العضلي") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MuscleSymptoms()),
      );
    } else if (headline == "السبب" && kind == "التمزق العضلي") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MuscleReasons()),
      );
    } else if (headline == "الإسعافات الأوليه" && kind == "التمزق العضلي") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MuscleFirstAid()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kind == "الكدمات") {
      imgUrl = 'assets/images/kadma.jpg';
    } else if (kind == "الكسور") {
      imgUrl = 'assets/images/kasr.jpg';
    } else if (kind == "الإلتواء") {
      imgUrl = 'assets/images/eltwaa.jpeg';
    } else if (kind == "الخلع") {
      imgUrl = 'assets/images/dislocation.jpg';
    } else if (kind == "التقلص العضلي") {
      imgUrl = 'assets/images/muscle_contraction_intro.jpg';
    } else if (kind == "التمزق العضلي") {
      imgUrl = 'assets/images/muscle_tear.jpg';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(kind),
      ),
      body: Column(
        children: [
          FadeInImage(
              width: double.infinity,
              height: 200,
              fit: BoxFit.contain,
              placeholder: MemoryImage(kTransparentImage),
              image: AssetImage(imgUrl)),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        injuryHeadLines[index],
                        style: const TextStyle(fontSize: 18),
                      ),
                      GestureDetector(
                          onTap: () {
                            navigateToPage(context, injuryHeadLines[index]);
                          },
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.blue,
                          ))
                    ],
                  ));
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                thickness: 1,
                endIndent: 50,
                indent: 50,
                color: Colors.blue,
              );
            },
            itemCount: 4,
          ))
        ],
      ),
    );
  }
}
