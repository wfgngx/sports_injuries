import 'package:flutter/material.dart';
import 'package:sportsInjuries/screens/ta3ref.dart';
import 'package:transparent_image/transparent_image.dart';

class Details extends StatelessWidget {
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('الكدمه'),centerTitle: true,),
      body: Column(
        children: [
          SizedBox(height: 30,),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child:
            FadeInImage(
                width: 300,
                height: 200,
                fit: BoxFit.contain,
                placeholder: MemoryImage(kTransparentImage),
                image: AssetImage('assets/images/kadma.jpg')),
          ),
          SizedBox(height: 20,),
          Expanded(
              child: ListView.separated(
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'الأعراض',
                        style: TextStyle(fontSize: 18),
                      ),
                      IconButton(
                          color: Colors.blue,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return const Ta3reef();
                            },));
                          },
                          icon: const Icon(Icons.arrow_forward_ios_rounded))
                    ],
                  ));
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                thickness: 1,
                endIndent: 50,
                indent: 50,
                color: Colors.blue,
              );
            },
            itemCount: 10,
          ))
        ],
      ),
    );
  }
}
