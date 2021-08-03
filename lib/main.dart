import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Clock',
      home: HomeScreen(),
      theme: ThemeData(fontFamily: 'Berlin'),
    ));

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  HomeScreenState();

  _currentTime() {
    return "${DateTime.now().hour} : ${DateTime.now().minute} : ${DateTime.now().second}";
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animationController.addListener(() {
      if (animationController.isCompleted) {
        animationController.reverse();
      } else if (animationController.isDismissed) {
        animationController.forward();
      }
      setState(() {});
    });
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animation = Tween(begin: -0.5, end: 0.5).animate(animation);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Clock',
          style: TextStyle(fontSize: 32.0),
        )),
        backgroundColor: Color(0xFF2D2E28),
        elevation: 0.0,
      ),
      body: Container(
        color: Color(0xFF2D2E28),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(320),
                  ),
                  color: Color(0xFFd0e1ea),
                ),
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(320.0)),
                  elevation: 10.0,
                  color: Color(0xFF0669C7),
                  child: Container(
                    width: 280,
                    height: 280,
                    child: Center(
                      child: Text(
                        _currentTime(),
                        style: TextStyle(
                            fontSize: 60.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              Transform(
                alignment: FractionalOffset(0.5, 0.1),
                transform: Matrix4.rotationZ(animation.value),
                child: Container(
                  child: Image(
                    image: AssetImage(
                      'images/pandulum.png'
                    ),
                    height: 280,
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
