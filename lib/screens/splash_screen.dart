import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    // After a delay, navigate to the LoginScreen
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // @override
    // Future.delayed(Duration(seconds: 10), () {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => LoginScreen()),
    //   );
    // });
    return Scaffold(
      // backgroundColor: Color(0xffEFCEAD),

      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/wallpaper.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: Image.asset('assets/logo.png'),
              ),
              Text(
                "Bookish Haven",
                style: TextStyle(
                    letterSpacing: 8,
                    fontWeight: FontWeight.w100,
                    fontSize: 15),
              ),
              SizedBox(height: 20),
              Container(
                  width: 150,
                  child: LinearProgressIndicator(
                    backgroundColor: Color(0xffEFCEAD),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
