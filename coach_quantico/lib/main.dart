import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.nunito().fontFamily,
      ),
      title: 'Coach Quântico',
      home: CoachQuanticoApp(),
    );
  }
}

class CoachQuanticoApp extends StatefulWidget {
  @override
  _CoachQuanticoAppState createState() => _CoachQuanticoAppState();
}

class _CoachQuanticoAppState extends State<CoachQuanticoApp> {
  bool _visible = false;
  String _fraseGerada = 'Clique abaixo para gerar uma nova frase';
  List<String> _frases = [
    '"Quando a nossa vontade é frustada por algo contrário, temos a chance de crescer ou sofrer."',
    '"O insight que mudará a sua vida pode estar em um texto que você ainda não leu."',
    '"São as cicatrizes que comprovam que vencemos, não as feridas. Feridas abertas apodrecem"',
    '"Só há duas maneiras de viver. Uma é como se nada fosse um milagre; a outra é como se tudo fosse um milagre."',
    '"Eu pensava que nós seguíamos caminhos já feitos, mas parece que não há. O nosso ir faz o caminho."',
    '"Ontem é um cheque cancelado, amanhã é um nota promissória e hoje é único cash que você tem - gaste-o com sabedoria."',
    '"A felicidade não tem nada que ver com o prazer. O prazer é um momento; a felicidade, uma escolha."',
    '"Decida quais são suas prioridades e quanto tempo você vai dedicar a cada uma. Se não o fizer, alguém fará por você."'
        '"Fraqueza é achar que ter problemas é um problema."',
    '"Conhecimento é saber que o tomate é uma fruta; sabedoria é não o colocar em uma salada de frutas."',
    '"Não vemos o mundo como ele é, e sim como nós somos."',
    '"Não podemos acrescentar dias à nossa vida, mas podemos acrescentar vida aos nosso dias."'
  ];

  void _gerarFrases() {
    int _numeroAleatorio = Random().nextInt(_frases.length);
    setState(() {
      _fraseGerada = _frases[_numeroAleatorio];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              border: Border.all(
                width: 4,
                color: Color(0xFF463FC0),
              ),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/logo_alex.png',
                width: MediaQuery.of(context).size.width * .75,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      _fraseGerada,
                      style: TextStyle(
                        color: Color(0xFF3F3D56),
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.8,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    _visible
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  FontAwesome5.copy,
                                  color: Color(0xFF463FC0),
                                  size: 24,
                                ),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.g_translate,
                                  color: Color(0xFF463FC0),
                                  size: 24,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
              RaisedButton(
                  color: Color(0xFF463FC0),
                  onPressed: () {
                    _gerarFrases();
                    setState(() {
                      _visible = true;
                    });
                  },
                  child: Container(
                    child: Text(
                      'Gerar nova frase!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
