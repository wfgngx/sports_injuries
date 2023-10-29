import 'package:flutter/material.dart';

import '../widgets/injuries/bruise_functions/bruise_def.dart';

class InjuryDetails extends StatefulWidget {
  const InjuryDetails(
      {Key? key, required this.queryDetails, required this.queryInjuryName})
      : super(key: key);
  final String queryDetails;
  final String queryInjuryName;

  @override
  State<InjuryDetails> createState() => _InjuryDetailsState();
}

class _InjuryDetailsState extends State<InjuryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.queryDetails),
      ),
      body:Column(children: [
        Text(widget.queryInjuryName),
        ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) {
          return BruiseDef();
        },));}, child: Text("test"))
      ],) ,
    );
  }
}
