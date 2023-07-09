import 'package:facebook_reactions/fb_reaction_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Facebook Reactions',
      theme: ThemeData(primaryColor: const Color(0xff3b5998)),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MAIN'),
          centerTitle: true,
        ),
        body: const MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  static List<double> timeDelays = [1.0, 2.0, 3.0, 4.0, 5.0];
  int selectedIndex = 0;

  void onSpeedSettingPress(int index) {
    timeDilation = timeDelays[index];
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> buildList() {
    final List<Widget> list = [
      const Text(
        'SPEED:',
        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
      )
    ];
    timeDelays.asMap().forEach((index, delay) {
      list.add(Container(
        margin: const EdgeInsets.all(5.0),
        child: GestureDetector(
          onTap: () => onSpeedSettingPress(index),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: index == selectedIndex
                  ? const Color(0xff3b5998)
                  : const Color(0xffDAA520),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(delay.toString(),
                style: const TextStyle(color: Colors.white)),
          ),
        ),
      ));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
          child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(
                left: 20.0, right: 20.0, top: 20.0, bottom: 10.0),
            child: Row(children: buildList()),
          ),
          Container(
            height: 15.0,
          ),
          buildButton(context, 'Facebook reactions animation', FbReactionBox())
        ],
      )),
    );
  }

  Widget buildButton(
      BuildContext context, String name, StatelessWidget screenTo) {
    return TextButton(
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => screenTo)),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return const Color(0xff3b5998).withOpacity(0.8);
            }
            return const Color(0xff3b5998);
          },
        ),
        splashFactory: NoSplash.splashFactory,
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.fromLTRB(30, 15, 30, 15),
        ),
      ),
      child: SizedBox(
        width: 270.0,
        child: Text(
          name,
          style: const TextStyle(color: Colors.white, fontSize: 16.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
