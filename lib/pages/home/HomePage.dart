import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../screen_stat.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(milliseconds: 1)).then((value) => setState(() {
        isLoaded = true;
      }));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Container(
          height: 4.h,
          child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.white,),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50.dp)),
                ),
                hintText: 'Recherche...',
                hintStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white)),
        ),
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.format_align_left, color: Colors.white,)),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.notification_important_sharp, color: Colors.white,))
        ],
      ),
      body: _body(),
    );
  }


  _anathorBody(){
    return StatsScreen();
  }
  Widget _body(){
    return Column(
      children: [
        
      ],
    );
  }

dialogue(){
  AwesomeDialog(
    context: context,
    animType: AnimType.scale,
    dialogType: DialogType.info,
    body: Center(child: Text(
      'If the body is specified, then title and description will be ignored, this allows to further customize the dialogue.',
      style: TextStyle(fontStyle: FontStyle.italic),
    ),),
    title: 'This is Ignored',
    desc:   'This is also Ignored',
    btnOkOnPress: () {},
  )..show();
}

}
