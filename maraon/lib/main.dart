import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

main() => runApp(MyApp());

String text1 =
    'Este é o aplicativo que permite descobrir e\n ler ebooks e revistas.';
String texto2 =
    'Peça emprestado e leia livros,\naudiolivros e revistas gratuitos da \nsua biblioteca usando seu telefone ou \ntablet. É fácil de conseguir.';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Hero(tag: 'logo', child: Image.asset('icon.png', height: 35)),
              SizedBox(height: 30),
              Image.asset('img1.png'),
              SizedBox(height: 30),
              Text(
                'Olá',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(height: 15),
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 20),
              Hero(
                tag: 'button',
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondScreen(),
                      ),
                    );
                  },
                  color: Color(0xff2c2d37),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                  child: Text(
                    'Vamos começar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Hero(tag: 'logo', child: Image.asset('icon.png', height: 30)),
                  Text(
                    'PULAR',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
              SizedBox(height: 60),
              Image.asset('img2.png'),
              SizedBox(height: 40),
              Text(
                'Conheça',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 10),
              Text(
                'MaraBook',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(height: 10),
              Text(
                texto2,
                style: TextStyle(
                  height: 1.4,
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Emprestar e ler eboks grátis',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xffd5727f),
                        color: Color(0xffd5727f),
                        fontWeight: FontWeight.w600),
                  ),
                  Hero(
                    tag: 'button',
                    child: MaterialButton(
                      minWidth: 50,
                      color: Color(0xff2c2d37),
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.chevron_right,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Color(0xffF2F5F9),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 60,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Olá Mara,',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.search, size: 28),
                      SizedBox(width: 14),
                      Icon(Icons.notifications_none, size: 28)
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Image.asset(
                  "banner.png",
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
          )),
    );
  }
}
