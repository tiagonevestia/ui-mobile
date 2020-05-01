import 'package:wine_book/models/baseModel.dart';

class Anotacao {
  /// Tipos
  int id;
  String title;
  String content;
  String color;

  /// Para debug
  String toString() {
    return "{ id=$id, title=$title, content=$content, color=$color }";
  }
}

class AnotacoesModel extends BaseModel {
  /// A cor que o usuário escolher
  String color;

  /// Para exibição da cor escolhida pelo usuário.
  ///
  /// @param inColor The color.
  void setColor(String inColor) {
    print("## NotesModel.setColor(): inColor = $inColor");

    color = inColor;
    notifyListeners();
  }
}

// A primeira e a única instância deste modelo.
AnotacoesModel anotacoesModel = AnotacoesModel();
