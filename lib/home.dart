import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:yogasanastar/blog.dart';
import 'package:yogasanastar/login.dart';
import 'package:yogasanastar/main.dart';
import 'package:yogasanastar/poses.dart';
import 'package:yogasanastar/profile.dart';
import 'package:yogasanastar/scale_route.dart';
import 'package:yogasanastar/store.dart';
import 'package:yogasanastar/usertab.dart';
import 'package:yogasanastar/util/pose_data.dart';
import 'package:yogasanastar/util/user.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
    this.title,
    this.email,
    this.uid,
    this.displayName,
    this.photoUrl,
    this.cameras,
  }) : super(key: key);
  final String title;
  final String email;
  final String uid;
  final String displayName;
  final String photoUrl;
  final List<CameraDescription> cameras;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _page = 0;
  User user = User();
  GlobalKey _bottomNavigationKey = GlobalKey();

  Widget bodyFunction() {
    switch (_page) {
      case 0:
        return Home(
          email: user.email,
          uid: user.uid,
          displayName: user.displayName,
          photoUrl: user.photoUrl,
          cameras: cameras,
        );
        break;
      case 1:
        return Blog();
        break;
      case 2:
        return Store();
        break;
      case 3:
        return UserTab();
        break;
      default:
        return Home(
          email: user.email,
          uid: user.uid,
          displayName: user.displayName,
          photoUrl: user.photoUrl,
          cameras: cameras,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    User user = User();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.orange[700],
        title: Text('Yogasana-Star'),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {},
          child: Icon(
            (user.email == null)
                ? Icons.cancel_presentation_sharp
                : Icons.verified_outlined,
            color: (user.email == null)
                ? Colors.red
                : Colors.greenAccent, // add custom icons also
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: (user.email == null)
                ? Icon(Icons.outlet_rounded)
                : Icon(Icons.person, color: Colors.greenAccent),
            onPressed: () {
              Navigator.push(
                context,
                (user.email == null)
                    ? MaterialPageRoute(
                        builder: (context) => Login(
                          cameras: cameras,
                        ),
                      )
                    : MaterialPageRoute(
                        builder: (context) => Profile(
                          email: user.email,
                          uid: user.uid,
                          displayName: user.displayName,
                          photoUrl: user.photoUrl,
                        ),
                      ),
              );
            },
          ),
        ],
      ),
      body: bodyFunction(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.black87,
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 0.5,
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _page,
          backgroundColor: Colors.black87,
          elevation: 10,
          selectedItemColor: Colors.orange[900],
          unselectedItemColor: Colors.white.withOpacity(.70),
          selectedFontSize: 12,
          unselectedFontSize: 10,
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Rank',
              icon: Icon(Icons.format_align_center_rounded),
            ),
            BottomNavigationBarItem(
              label: 'Store',
              icon: Icon(Icons.store_mall_directory_outlined),
            ),
            BottomNavigationBarItem(
              label: 'User',
              icon: Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  final String email;
  final String uid;
  final String displayName;
  final String photoUrl;
  final List<CameraDescription> cameras;

  const Home({
    this.email,
    this.uid,
    this.displayName,
    this.photoUrl,
    this.cameras,
  });

  @override
  Widget build(BuildContext context) {
    User user = User();
    String name = (user.displayName == null) ? '________ ' : user.displayName;
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 10.0),
              child: Image(
                image: AssetImage('assets/images/yoga1.png'),
                width: 202,
                height: 250,
              ),
            ),
            // Welcome Text
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Welcome\n$name',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
            ),

            // Beginner Button
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: TextButton(
                child: Text(
                  'Beginner',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size.fromHeight(1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: BorderSide(
                    width: 1.4,
                    color: Colors.orange[700],
                  ),
                ),
                onPressed: () => _onPoseSelect(
                  context,
                  'Beginner',
                  beginnerAsanas,
                  Colors.green,
                ),
              ),
            ),

            // Intermediate Button
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: TextButton(
                child: Text(
                  'Intermediate',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size.fromHeight(1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: BorderSide(
                    width: 1.4,
                    color: Colors.orange[700],
                  ),
                ),
                onPressed: () => _onPoseSelect(
                  context,
                  'Intermediate',
                  intermediateAsanas,
                  Colors.blue,
                ),
              ),
            ),

            // Advance Button
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: TextButton(
                child: Text(
                  'Advance',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.deepPurple[400],
                  minimumSize: Size.fromHeight(1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: BorderSide(
                    width: 1.4,
                    color: Colors.orange[700],
                  ),
                ),
                onPressed: () => _onPoseSelect(
                  context,
                  'Advance',
                  advanceAsanas,
                  Colors.deepPurple[400],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPoseSelect(
    BuildContext context,
    String title,
    List<String> asanas,
    Color color,
  ) async {
    Navigator.push(
      context,
      ScaleRoute(
        page: Poses(
          cameras: cameras,
          title: title,
          model: "assets/models/posenet_mv1_075_float_from_checkpoints.tflite",
          asanas: asanas,
          color: color,
        ),
      ),
    );
  }
}
