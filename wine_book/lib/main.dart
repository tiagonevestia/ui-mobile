import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wine_book/modules/anotacoes/anotacoes_page.dart';
import 'package:wine_book/modules/compromissos/compromissos_page.dart';
import 'package:wine_book/modules/contatos/contatos_page.dart';
import 'package:wine_book/modules/tarefas/tarefas_page.dart';
import 'package:wine_book/utils/diretorio.dart' as dirUtils;

/// Iniciando a aplicação
void main() {
  /// Processar antes do runApp()
  WidgetsFlutterBinding.ensureInitialized();

  print("## main(): WineBook Iniciando");

  startApp() async {
    /// Retornar o caminho do diretório que fornece armazenamento durável.
    Directory docsDir = await getApplicationDocumentsDirectory();
    dirUtils.docsDir = docsDir;
    runApp(WineBook());
  }

  startApp();
} /* Fim do main(). */

/// ***************************************************************************
/// Main app widget.
/// ***************************************************************************
class WineBook extends StatefulWidget {
  @override
  _WineBookState createState() => _WineBookState();
}

class _WineBookState extends State<WineBook> {
  int _currentPage = 0;

  List<Widget> _pageList = [
    CompromissosPage(),
    ContatosPage(),
    AnotacoesPage(),
    TarefasPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.montserratAlternates().fontFamily,
      ),
      home: Scaffold(
        body: _pageList.elementAt(_currentPage),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          currentIndex: _currentPage,
          fixedColor: Colors.red.shade900,
          iconSize: 35.0,
          unselectedItemColor: Colors.black45,
          unselectedIconTheme: IconThemeData(size: 25.0),
          showSelectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.date_range),
              title: Text('Compromissos'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contacts),
              title: Text('Contatos'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note),
              title: Text('Anotações'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_turned_in),
              title: Text('Tarefas'),
            ),
          ],
          onTap: (int index) {
            setState(() {
              _currentPage = index;
            });
          },
        ),
      ),
    );
  }
}
